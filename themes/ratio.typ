// Ratio theme
//
// A highly customizable theme inspired by old Beamer theme Singapore with it's section
// names at the top.

#import "../logic.typ"
#import "../utils/utils.typ"

#let hsl = color.hsl
#let transparent = rgb(0, 0, 0, 0)

#let ratio-options = state("ratio-options", (:))

#let register-options(options) = {
  ratio-options.update(s => {
    s = s + options
    s
  })
}

// A default color palette to pull from.
#let palette = (
  primary-900: hsl(rgb("#1f4ac3")),
  primary-800: hsl(rgb("#2c57ce")),
  primary-700: hsl(rgb("#3963d9")),
  primary-600: hsl(rgb("#4370ec")),
  primary-500: hsl(rgb("#4d7cfe")),
  primary-400: hsl(rgb("#6890fe")),
  primary-300: hsl(rgb("#82a3fe")),
  primary-200: hsl(rgb("#82a3fe")),
  primary-100: hsl(rgb("#a6beff")),
  primary-50: hsl(rgb("#eaefff")),
  secondary-900: hsl(rgb("#0f0f25")),
  secondary-800: hsl(rgb("#171731")),
  secondary-700: hsl(rgb("#1e1e3d")),
  secondary-600: hsl(rgb("#232345")),
  secondary-500: hsl(rgb("#28284d")),
  secondary-400: hsl(rgb("#38385b")),
  secondary-300: hsl(rgb("#484868")),
  secondary-200: hsl(rgb("#848499")),
  secondary-100: hsl(rgb("#bfbfca")),
  secondary-50: hsl(rgb("#e5e5ea")),
  contrast: white,
  success: hsl(rgb("#8bc34a")),
  warning: hsl(rgb("#ff9800")),
  danger: hsl(rgb("#f44336")),
  error: hsl(rgb("#f44336")),
  info: hsl(rgb("#4d7cfe")),
  cat-0: hsl(rgb("#e58606")),
  cat-1: hsl(rgb("#5d69b1")),
  cat-2: hsl(rgb("#52bca3")),
  cat-3: hsl(rgb("#99c945")),
  cat-4: hsl(rgb("#cc61b0")),
  cat-5: hsl(rgb("#24796c")),
  cat-6: hsl(rgb("#daa51b")),
  cat-7: hsl(rgb("#2f8ac4")),
  cat-8: hsl(rgb("#764e9f")),
  cat-9: hsl(rgb("#ed645a")),
  cat-10: hsl(rgb("#a5aa99")),
)

// Create a Ratio style author entry.
#let author(name, affiliation, email) = { (name: name, affiliation: affiliation, email: email) }

// Ratio style title slide.
#let title-slide(
  // Slide title.
  title: none,
  // Document authors/presenters.
  authors: none,
  // Presentation abstract or subtitle.
  abstract: none,
  // Presentation date. Set to none to hide.
  date: none,
  // Presentation version. Set to none to hide.
  version: none,
  // Raw content to show (in front of regular title page content).
  content: none,
  // Whether to register this slide title as a section.
  register-section: false,
) = {
  let content = context {
    let options = ratio-options.get()
    let fill = options.at("title-background-color", default: palette.secondary-800)
    set text(fill: options.at("title-text-color", default: palette.contrast))
    if fill != none {
      // Build the background.
      place(block(width: 100%, height: 100%, fill: fill))
      // The left triangle.
      place(left + top, polygon(
        fill: fill.lighten(20%).transparentize(50%),
        (0%, 100%),
        (25%, 80%),
        (0%, 70%),
      ))
      // The bottom triangle.
      place(left + top, polygon(
        fill: fill.lighten(20%).transparentize(20%),
        (0%, 100%),
        (25%, 80%),
        (75%, 100%),
      ))
      // The large one on the right.
      place(left + top, polygon(
        fill: fill.lighten(20%).transparentize(85%),
        (0%, 100%),
        (100%, 100%),
        (100%, 20%),
      ))
    }

    // The textual content.
    place(
      left + horizon,
      block(
        width: 100%,
        inset: 15%,
      )[
        #let v-space = v(1.5em, weak: true)
        #set text(
          ..options.at("title-text", default: (size: 20pt, fill: palette.contrast)),
        )
        #if title != none {
          text(
            ..options.at("title-heading-text", default: (size: 3em, weight: "bold")),
          )[#title]
          if register-section {
            utils.register-section(title)
          }
        }

        #if authors != none and authors.len() > 0 {
          set text(..options.at("title-author-text", default: (:)))
          for author in utils.as_array(authors) {
            v-space
            let name = author.at("name", default: none)
            let email = author.at("email", default: none)
            let affiliation = author.at("affiliation", default: none)
            if email == none {
              name
            } else {
              link("mailto:" + email)[#name]
            }
            if affiliation != none {
              linebreak()
              text(
                ..options.at("title-affiliation-text", default: (size: 0.8em, weight: "light")),
                affiliation,
              )
            }
          }
        }

        #if abstract != none {
          v-space
          let abstract = text(..options.at("title-abstract-text", default: (:)), abstract)
          par(leading: 0.78em, justify: true, linebreaks: "optimized")[#abstract]
        }

        #if date != none or version != none {
          v-space
          set text(
            ..options.at("title-version-text", default: (size: 0.8em, weight: "light")),
          )
          if date != none {
            text(date.display())
          }
          if date != none and version != none {
            h(1.6pt)
            text("|")
            h(1.6pt)
          }
          if version != none {
            text(version)
          }
        }
      ],
    )

    // Raw content if any.
    if content != none {
      place(left + top, block(width: 100%, height: 100%)[#content])
    }
  }
  logic.polylux-slide(content)
}

// Ratio style section navigation.
#let navigation() = {
  locate(
    loc => {
      // Get the variables at this stage or final.
      let options = ratio-options.at(loc)
      let page = loc.page()
      let secs = utils.sections-state.final()
      let subs = utils.subsections-state.final()

      set text(..options.navigation-text)

      // Precalculate when sections and subsections end.
      let sec_ends = {
        if secs.len() > 1 {
          secs.slice(1).map(s => s.loc.page())
        } else {
          ()
        }
      }
      sec_ends.push(none)

      let sub_ends = {
        subs.enumerate().map(((idx, subs)) => {
          let ends = if subs.len() > 1 {
            subs.slice(1).map(s => s.loc.page())
          } else {
            ()
          }
          // Last one ends at next section.
          ends.push(sec_ends.at(idx, default: none))
          ends
        })
      }

      // The main headings.
      let sec_displays = secs.zip(sec_ends).map(((sec, end)) => {
        link(sec.loc)[
          #if page < sec.loc.page() {
            text(..options.navigation-text-future, sec.body)
          } else {
            if page == sec.loc.page() or (end != none and page < end) {
              text(..options.navigation-text-current, sec.body)
            } else {
              text(..options.navigation-text-past, sec.body)
            }
          }
        ]
      })

      // Subsection shapes.
      let columns = if subs.len() > 0 {
        subs.len()
      } else {
        1
      }
      let sub_displays = subs.zip(sub_ends).map(
        ((subs, ends)) => {
          pad(
            x: .5em,
            grid(columns: columns, gutter: .5em, ..subs.zip(ends).map(((sub, end)) => {
              link(sub.loc)[
                #if page < sub.loc.page() {
                  options.navigation-shape-future
                } else {
                  if page == sub.loc.page() or (end != none and page < end) {
                    options.navigation-shape-current
                  } else {
                    options.navigation-shape-past
                  }
                }
              ]
            })),
          )
        },
      )

      // Combine into a block that fills the header.
      block(fill: options.navigation-bar-color, width: 100%, align(horizon, {
        pad(x: 0.8em, y: 0.4em, grid(
          columns: range(sec_displays.len()).map(_ => 1fr),
          gutter: .4em,
          ..sec_displays,
          ..sub_displays,
        ))
      }))
    },
  )
}

// Ratio style footer.
#let progress() = {
  locate(
    loc => {
      let options = ratio-options.at(loc)
      let current = loc.page()
      let total = counter(page).final().first()
      block(
        fill: options.at("progress-bar-color", default: palette.secondary-50),
        width: 100%,
        height: options.at("progress-bar-height", default: 5pt),
        place(
          left + horizon,
          utils.polylux-progress(
            ratio => block(
              fill: options.at("progress-overlay-color", default: palette.secondary-100),
              width: ratio * 100%,
              height: 100%,
            ),
          ),
        ),
      )
    },
  )
}

#let ratio-bar(kind) = {
  if kind == "navigation" {
    navigation()
  } else if kind == "progress" {
    progress()
  } else if kind == none {
    []
  } else {
    kind
  }
}

#let ratio-header() = {
  context ratio-bar(ratio-options.get().at("header", default: none))
}

#let ratio-footer() = {
  context ratio-bar(ratio-options.get().at("footer", default: none))
}

// Ratio style slide.
#let slide(title: none, body) = {
  let content = {
    if title != none {
      heading(level: 1, title)
    }
    pad(left: 1em, right: 2em, body)
  }
  let header = ratio-header()
  let footer = ratio-footer()
  logic.polylux-slide(grid(
    columns: 1,
    gutter: 1em,
    rows: (auto, 1fr, auto),
    ..(header, content, footer),
  ))
}

#let anchored(body, color: palette.primary-500) = {
  body
  h(0.05em)
  super(box(height: 0.7em, circle(radius: 0.15em, stroke: 0.08em + color)))
}

// The Ratio theme function that sets up all styling at once.
#let ratio-theme(
  // Presentation aspect ratio.
  aspect-ratio: "16-9",
  // Whether to include the default cover page.
  cover: true,
  // Presentation title.
  title: [Presentation title],
  // An abstract for your work. Can be omitted if you don't have one.
  abstract: lorem(30),
  // Presentation authors/presenters.
  authors: (
    author("Jane Doe", "Foo Ltd.", "jane.doe@foo.ltd"),
    author("Foo Bar", "Quux Co.", "foo.bar@quux.co"),
  ),
  // Date that will be displayed on cover page.
  // The value needs to be of the 'datetime' type.
  // More info: https://typst.app/docs/reference/foundations/datetime/
  // Example: datetime(year: 2024, month: 03, day: 17)
  date: datetime.today(),
  // Document keywords to set.
  keywords: (),
  // The version of your work.
  version: "Draft",
  // Whether to apply some heading styling.
  style-headings: true,
  // Whether to apply the custom link style.
  style-links: true,
  // What to show in the header ("navigation", "progress", content, none).
  header: "navigation",
  // What to show in the footer ("navigation", "progress", content, none).
  footer: "progress",
  // Title background color.
  title-background-color: palette.secondary-800,
  // Title text style.
  title-text: (size: 20pt, fill: palette.contrast),
  // Title text heading overrides.
  title-heading-text: (size: 3em, weight: "bold"),
  // Title author text heading overrides.
  title-author-text: (:),
  // Title affiliation text overrides.
  title-affiliation-text: (size: 0.8em, weight: "light"),
  // Title abstract text overrides.
  title-abstract-text: (:),
  // Title date and version text override.
  title-version-text: (size: 0.8em, weight: "light"),
  // Color for external link anchors.
  link-color: palette.primary-500,
  // Heading color.
  heading-color: palette.secondary-800,
  // Stroke color for tables and such.
  stroke-color: palette.secondary-100,
  // Fill color for code blocks and such.
  fill-color: palette.secondary-50,
  // Navigation background color.
  navigation-bar-color: palette.secondary-50,
  // Navigation text options for all text.
  navigation-text: (fill: palette.secondary-200, size: 0.7em),
  // Navigation text overrides for past sections.
  navigation-text-past: (:),
  // Navigation text overrides for the current section.
  navigation-text-current: (weight: "bold"),
  // Navigation text overrides for future sections.
  navigation-text-future: (:),
  // Navigation shape for past subsections.
  navigation-shape-past: box(height: 3.8pt, circle(
    radius: 1.7pt,
    fill: palette.secondary-100,
    stroke: 0.7pt + palette.secondary-100,
  )),
  // Navigation shape for current subsections.
  navigation-shape-current: box(height: 3.8pt, circle(
    radius: 1.7pt,
    fill: palette.primary-500,
    stroke: 0.7pt + palette.primary-500,
  )),
  // Navigation shape for future subsections.
  navigation-shape-future: box(
    height: 3.8pt,
    circle(radius: 1.7pt, stroke: 0.7pt + palette.secondary-100),
  ),
  // Progress bar height.
  progress-bar-height: 5pt,
  // Progress bar background color.
  progress-bar-color: palette.secondary-50,
  // Progress bar overlay color.
  progress-overlay-color: palette.secondary-100,
  // Progress bar text color.
  progress-text-color: palette.secondary-200,
  // Presentation contents.
  body,
) = {
  // Set document properties.
  set document(
    title: title,
    author: authors.first().name,
    date: date,
    keywords: keywords,
  )

  set page(
    paper: "presentation-" + aspect-ratio,
    margin: 0em,
    header: none,
    footer: none,
  )

  register-options((
    style-headings: style-headings,
    style-links: style-links,
    header: header,
    footer: footer,
    title-background-color: title-background-color,
    title-text: title-text,
    title-heading-text: title-heading-text,
    title-author-text: title-author-text,
    title-affiliation-text: title-affiliation-text,
    title-abstract-text: title-abstract-text,
    title-version-text: title-version-text,
    link-color: link-color,
    heading-color: heading-color,
    stroke-color: stroke-color,
    fill-color: fill-color,
    navigation-bar-color: navigation-bar-color,
    navigation-text: navigation-text,
    navigation-text-past: navigation-text-past,
    navigation-text-current: navigation-text-current,
    navigation-text-future: navigation-text-future,
    navigation-shape-past: navigation-shape-past,
    navigation-shape-current: navigation-shape-current,
    navigation-shape-future: navigation-shape-future,
    progress-bar-height: progress-bar-height,
    progress-bar-color: progress-bar-color,
    progress-overlay-color: progress-overlay-color,
    progress-text-color: progress-text-color,
  ))

  // Text setup.
  set par(leading: 0.7em, justify: true, linebreaks: "optimized")
  show par: set block(spacing: 1.35em)
  set text(font: "Cantarell", 18pt)

  // Heading setup.
  show heading: it => {
    // Register sections and subsections.
    if it.depth == 1 {
      locate(loc => {
        utils.register-section(it.body)
      })
    } else if it.depth == 2 {
      locate(loc => {
        utils.register-subsection(it.body)
      })
    }
    context {
      let options = ratio-options.get()
      if options.at("style-headings", default: false) {
        let fill = options.at("heading-color", default: text.fill)
        // Do not hyphenate headings.
        text(fill: fill, hyphenate: false)[#it]
      } else {
        it
      }
    }
  }

  // Style links if set.
  show link: it => {
    context {
      let options = ratio-options.get()
      if options.at("style-links", default: false) {
        // Don't style for internal links.
        if type(it.dest) == label or type(it.dest) == location {
          return it
        }
        let color = options.at("link-color", default: palette.primary-500)
        anchored(it)
      } else {
        it
      }
    }
  }

  // Title slide if set.
  if cover {
    title-slide(
      title: title,
      authors: authors,
      abstract: abstract,
      date: date,
      version: version,
      register-section: false, // Don't register the cover.
    )
  }

  // Presentation contents.
  body
}
