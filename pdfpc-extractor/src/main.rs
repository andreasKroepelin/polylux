use miette::{miette, IntoDiagnostic, WrapErr};
use std::{collections::HashMap, process::Command};
use tinyjson::JsonValue;

#[derive(Debug)]
enum QueryItem {
    SlideStart,
    SlideEnd,
    Idx(u32),
    Label(String),
    Overlay(u32),
    Note(String),
}

impl QueryItem {
    fn from_json(json: &JsonValue) -> miette::Result<Self> {
        let object: &HashMap<_, _> = json
            .get()
            .ok_or_else(|| miette!("JSON item in query is not an object."))?;
        let typst_label: &String = object
            .get("label")
            .ok_or_else(|| miette!("Query item has no label."))?
            .get()
            .ok_or_else(|| miette!("\"label\" field does not contain a string."))?;
        let value: &String = object
            .get("value")
            .ok_or_else(|| miette!("Query item has no value."))?
            .get()
            .ok_or_else(|| miette!("\"value\" field does not contain a string."))?;

        if typst_label == "<pdfpc-marker>" && value == "slide start" {
            Ok(QueryItem::SlideStart)
        } else if typst_label == "<pdfpc-marker>" && value == "slide end" {
            Ok(QueryItem::SlideEnd)
        } else if typst_label == "<pdfpc-idx>" {
            value
                .parse::<u32>()
                .into_diagnostic()
                .wrap_err("idx must be an integer.")
                .map(QueryItem::Idx)
        } else if typst_label == "<pdfpc-overlay>" {
            value
                .parse::<u32>()
                .into_diagnostic()
                .wrap_err("overlay must be an integer.")
                .map(QueryItem::Overlay)
        } else if typst_label == "<pdfpc-label>" {
            Ok(QueryItem::Label(value.clone()))
        } else if typst_label == "<pdfpc-note>" {
            Ok(QueryItem::Note(value.clone()))
        } else {
            Err(miette!(
                "Unknown query item with label = \"{typst_label}\" and value = \"{value}\"."
            ))
        }
    }

    fn to_pages(items: Vec<Self>) -> miette::Result<JsonValue> {
        let mut pages = Vec::new();
        let mut current_page: Option<HashMap<String, JsonValue>> = None;

        trait PageExt<T>: Sized {
            fn err_if_none(self: &mut Self) -> miette::Result<&mut T>;
        }

        impl<T> PageExt<T> for Option<T> {
            fn err_if_none(self: &mut Self) -> miette::Result<&mut T> {
                self.as_mut()
                    .ok_or_else(|| miette!("Page parameter given but no slide currently open."))
            }
        }

        for item in items.into_iter() {
            match item {
                QueryItem::SlideStart => {
                    miette::ensure!(
                        current_page.is_none(),
                        "New slide started before previous one ended."
                    );
                    current_page = Some(HashMap::new());
                }
                QueryItem::SlideEnd => {
                    let mut finished_page = current_page
                        .take()
                        .ok_or_else(|| miette!("Slide ended but none currently open."))?;
                    if finished_page
                        .get("overlay")
                        .and_then(|overlay_json| overlay_json.get::<f64>())
                        .is_some_and(|&overlay| overlay > 0.)
                    {
                        finished_page.insert("forcedOverlay".to_owned(), JsonValue::Boolean(true));
                    }
                    pages.push(JsonValue::Object(finished_page));
                }
                QueryItem::Idx(idx) => {
                    current_page
                        .err_if_none()?
                        .insert("idx".to_owned(), JsonValue::Number(f64::from(idx)));
                }
                QueryItem::Overlay(overlay) => {
                    current_page
                        .err_if_none()?
                        .insert("overlay".to_owned(), JsonValue::Number(f64::from(overlay)));
                }
                QueryItem::Label(label) => {
                    current_page
                        .err_if_none()?
                        .insert("label".to_owned(), JsonValue::String(label));
                }
                QueryItem::Note(note) => {
                    current_page
                        .err_if_none()?
                        .insert("note".to_owned(), JsonValue::String(note));
                }
            }
        }

        Ok(JsonValue::Array(pages))
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
        .arg("selector(<pdfpc-marker>).or(<pdfpc-note>).or(<pdfpc-idx>).or(<pdfpc-label>).or(<pdfpc-overlay>)")
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

    let query = query_str
        .parse::<JsonValue>()
        .into_diagnostic()
        .wrap_err("Failed to parse JSON produced by typst query.")?;
    let query_items: &Vec<_> = query.get().ok_or_else(|| {
        miette!("typst query did not produce a JSON array as the top level value.")
    })?;

    let parsed_items = query_items
        .iter()
        .map(QueryItem::from_json)
        .collect::<Result<Vec<_>, _>>()
        .wrap_err("Failed to interpret output of typst query for use in pdfpc.")?;

    let pages =
        QueryItem::to_pages(parsed_items).wrap_err("Failed to compose pdfpc-JSON for pages.")?;

    let mut pdfpc_object = HashMap::new();
    pdfpc_object.insert("pdfpcFormat".to_owned(), JsonValue::Number(2.));
    pdfpc_object.insert("pages".to_owned(), pages);

    let output = JsonValue::Object(pdfpc_object)
        .format()
        .into_diagnostic()
        .wrap_err("Failed to create pdfpc JSON.")?;
    let outfile = std::path::Path::new(&filename).with_extension("pdfpc");
    std::fs::write(outfile, output)
        .into_diagnostic()
        .wrap_err("Failed to write pdfpc JSON to file.")?;
    Ok(())
}
