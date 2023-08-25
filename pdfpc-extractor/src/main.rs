use miette::{miette, IntoDiagnostic, WrapErr};
use serde::{Deserialize, Serialize};
use std::{convert::TryFrom, process::Command};

#[derive(Deserialize)]
#[serde(transparent)]
struct TypstQueryOutput(Vec<QueryItem>);

#[derive(Debug, Deserialize)]
#[serde(tag = "t", content = "v")]
enum QueryItem {
    Duration(u32),
    StartTime(String),
    EndTime(String),
    LastMinutes(u32),
    DisableMarkdown(bool),
    NoteFontSize(u32),
    DefaultTransition(String),

    NewSlide,
    Idx(u32),
    LogicalSlide(u32),
    Overlay(u32),
    Note(String),
    EndSlide,
    SaveSlide,
    HiddenSlide,
}

#[derive(Serialize)]
#[serde(rename_all = "camelCase")]
struct Page {
    idx: u32,
    #[serde(rename = "label")]
    logical_slide: u32,
    overlay: u32,
    forced_overlay: bool,
    hidden: bool,
    #[serde(skip_serializing_if = "Option::is_none")]
    note: Option<String>,
    #[serde(skip)]
    end: bool,
    #[serde(skip)]
    saved: bool,
}

impl<'a> TryFrom<&'a [QueryItem]> for Page {
    type Error = miette::Report;

    fn try_from(items: &'a [QueryItem]) -> miette::Result<Page> {
        use QueryItem::*;
        Ok(Page {
            idx: items
                .iter()
                .find_map(|item| if let Idx(idx) = item { Some(idx) } else { None })
                .cloned()
                .ok_or_else(|| miette!("Page has no idx."))?,
            logical_slide: items
                .iter()
                .find_map(|item| {
                    if let LogicalSlide(logical_slide) = item {
                        Some(logical_slide)
                    } else {
                        None
                    }
                })
                .cloned()
                .ok_or_else(|| miette!("Page has no label."))?,
            overlay: items
                .iter()
                .find_map(|item| {
                    if let Overlay(overlay) = item {
                        Some(overlay)
                    } else {
                        None
                    }
                })
                .cloned()
                .ok_or_else(|| miette!("Page has no overlay."))?,
            note: items
                .iter()
                .find_map(|item| {
                    if let Note(note) = item {
                        Some(note)
                    } else {
                        None
                    }
                })
                .cloned(),
            forced_overlay: items.iter().any(|item| match item {
                &Overlay(overlay) if overlay > 0 => true,
                _ => false,
            }),
            hidden: items.iter().any(|item| matches!(item, HiddenSlide)),
            end: items.iter().any(|item| matches!(item, EndSlide)),
            saved: items.iter().any(|item| matches!(item, SaveSlide)),
        })
    }
}

#[derive(Serialize)]
#[serde(rename_all = "camelCase")]
struct PdfpcConfig {
    pdfpc_format: u32,
    /// Duration in minutes
    #[serde(skip_serializing_if = "Option::is_none")]
    duration: Option<u32>,
    #[serde(skip_serializing_if = "Option::is_none")]
    start_time: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    end_time: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    last_minutes: Option<u32>,
    disable_markdown: bool,
    #[serde(skip_serializing_if = "Option::is_none")]
    note_font_size: Option<u32>,
    #[serde(skip_serializing_if = "Option::is_none")]
    default_transition: Option<String>,
}

impl<'a> TryFrom<&'a [QueryItem]> for PdfpcConfig {
    type Error = miette::Report;

    fn try_from(items: &'a [QueryItem]) -> miette::Result<PdfpcConfig> {
        use QueryItem::*;
        Ok(PdfpcConfig {
            pdfpc_format: 2,
            duration: items
                .iter()
                .find_map(|item| {
                    if let Duration(duration) = item {
                        Some(duration)
                    } else {
                        None
                    }
                })
                .cloned(),
            start_time: items
                .iter()
                .find_map(|item| {
                    if let StartTime(start_time) = item {
                        Some(start_time)
                    } else {
                        None
                    }
                })
                .cloned(),
            end_time: items
                .iter()
                .find_map(|item| {
                    if let EndTime(end_time) = item {
                        Some(end_time)
                    } else {
                        None
                    }
                })
                .cloned(),
            last_minutes: items
                .iter()
                .find_map(|item| {
                    if let LastMinutes(last_minutes) = item {
                        Some(last_minutes)
                    } else {
                        None
                    }
                })
                .cloned(),
            note_font_size: items
                .iter()
                .find_map(|item| {
                    if let NoteFontSize(note_font_size) = item {
                        Some(note_font_size)
                    } else {
                        None
                    }
                })
                .cloned(),
            default_transition: items
                .iter()
                .find_map(|item| {
                    if let DefaultTransition(default_transition) = item {
                        Some(default_transition)
                    } else {
                        None
                    }
                })
                .cloned(),
            disable_markdown: items
                .iter()
                .any(|item| matches!(item, DisableMarkdown(true))),
        })
    }
}

#[derive(Serialize)]
#[serde(rename_all = "camelCase")]
struct Pdfpc {
    #[serde(flatten)]
    config: PdfpcConfig,
    #[serde(skip_serializing_if = "Option::is_none")]
    end_slide: Option<u32>,
    #[serde(skip_serializing_if = "Option::is_none")]
    saved_slide: Option<u32>,
    pages: Vec<Page>,
}

impl TryFrom<TypstQueryOutput> for Pdfpc {
    type Error = miette::Report;

    fn try_from(output: TypstQueryOutput) -> miette::Result<Pdfpc> {
        let mut split_output = output.0.split(|item| matches!(item, QueryItem::NewSlide));
        let config_items = split_output
            .next()
            .ok_or_else(|| miette!("There are no slides."))?;
        let config = PdfpcConfig::try_from(config_items)
            .wrap_err("Failed to aggregate pdfpc configuration data.")?;
        let pages = split_output
            .map(Page::try_from)
            .collect::<Result<Vec<_>, _>>()
            .wrap_err("Failed to aggregate page information.")?;

        Ok(Pdfpc {
            config,
            end_slide: pages.iter().find_map(|page| {
                if page.end {
                    Some(page.logical_slide - 1)
                } else {
                    None
                }
            }),
            saved_slide: pages.iter().find_map(|page| {
                if page.saved {
                    Some(page.logical_slide - 1)
                } else {
                    None
                }
            }),
            pages,
        })
    }
}

fn main() -> miette::Result<()> {
    let args: Vec<_> = std::env::args().skip(1).collect();
    let filename = args
        .iter()
        .find(|arg| arg.ends_with(".typ"))
        .cloned()
        .ok_or_else(|| miette!("No .typ file provided."))?;

    // dbg!(filename);

    let query_output = Command::new("typst")
        .arg("query")
        .args(args)
        .arg("--field")
        .arg("value")
        .arg("<pdfpc>")
        .output()
        .into_diagnostic()
        .wrap_err("typst query failed.")?;
    let query_str = String::from_utf8(query_output.stdout)
        .into_diagnostic()
        .wrap_err("typst query produced invalid UTF-8 data.")?;

    if query_str.is_empty() {
        let query_errstr = String::from_utf8(query_output.stderr)
            .into_diagnostic()
            .wrap_err("typst query produced invalid UTF-8 on stderr.")?;
        miette::bail!(miette::diagnostic!(
            help = query_errstr,
            "typst query did not produce any output."
        ))
    }

    let query: TypstQueryOutput = serde_json::from_str(&query_str)
        .into_diagnostic()
        .wrap_err("Failed to parse JSON produced by typst query.")?;

    let pdfpc = Pdfpc::try_from(query).wrap_err("Failed to construct pdfpc data")?;

    let output = serde_json::to_string(&pdfpc)
        .into_diagnostic()
        .wrap_err("Failed to create pdfpc JSON.")?;
    let outfile = std::path::Path::new(&filename).with_extension("pdfpc");
    std::fs::write(outfile, output)
        .into_diagnostic()
        .wrap_err("Failed to write pdfpc JSON to file.")?;
    Ok(())
}
