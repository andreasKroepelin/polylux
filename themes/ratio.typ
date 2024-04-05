// Ratio theme
//
// A highly customizable theme inspired by old Beamer theme Singapore with
// the section names at the top.
//
// The theme's initialization function is at the bottom of this file.

#import "../logic.typ"
#import "../utils/utils.typ"

// GLOBAL HELPERS

// Ratio color palette for easy styling.
#let ratio-palette = (
  primary-900: color.hsl(rgb("#1f4ac3")),
  primary-800: color.hsl(rgb("#2c57ce")),
  primary-700: color.hsl(rgb("#3963d9")),
  primary-600: color.hsl(rgb("#4370ec")),
  primary-500: color.hsl(rgb("#4d7cfe")),
  primary-400: color.hsl(rgb("#6890fe")),
  primary-300: color.hsl(rgb("#82a3fe")),
  primary-200: color.hsl(rgb("#82a3fe")),
  primary-100: color.hsl(rgb("#a6beff")),
  primary-50: color.hsl(rgb("#eaefff")),
  secondary-900: color.hsl(rgb("#0f0f25")),
  secondary-800: color.hsl(rgb("#171731")),
  secondary-700: color.hsl(rgb("#1e1e3d")),
  secondary-600: color.hsl(rgb("#232345")),
  secondary-500: color.hsl(rgb("#28284d")),
  secondary-400: color.hsl(rgb("#38385b")),
  secondary-300: color.hsl(rgb("#484868")),
  secondary-200: color.hsl(rgb("#848499")),
  secondary-100: color.hsl(rgb("#bfbfca")),
  secondary-50: color.hsl(rgb("#e5e5ea")),
  contrast: white,
  success: color.hsl(rgb("#8bc34a")),
  warning: color.hsl(rgb("#ff9800")),
  danger: color.hsl(rgb("#f44336")),
  error: color.hsl(rgb("#f44336")),
  info: color.hsl(rgb("#4d7cfe")),
  cat-0: color.hsl(rgb("#e58606")),
  cat-1: color.hsl(rgb("#5d69b1")),
  cat-2: color.hsl(rgb("#52bca3")),
  cat-3: color.hsl(rgb("#99c945")),
  cat-4: color.hsl(rgb("#cc61b0")),
  cat-5: color.hsl(rgb("#24796c")),
  cat-6: color.hsl(rgb("#daa51b")),
  cat-7: color.hsl(rgb("#2f8ac4")),
  cat-8: color.hsl(rgb("#764e9f")),
  cat-9: color.hsl(rgb("#ed645a")),
  cat-10: color.hsl(rgb("#a5aa99")),
  transparent: color.hsl(rgb(0, 0, 0, 0)),
)

// Create a Ratio theme author entry.
#let ratio-author(name, affiliation, email) = { (name: name, affiliation: affiliation, email: email) }

// Ratio default options.
#let ratio-defaults = (
  // Presentation aspect ratio.
  aspect-ratio: "16-9",
  // Presentation title.
  title: [Presentation title],
  // An abstract for your work. Can be omitted if you don't have one.
  abstract: lorem(30),
  // Presentation authors/presenters.
  authors: (
    ratio-author("Jane Doe", "Foo Ltd.", "jane.doe@foo.ltd"),
    ratio-author("Foo Bar", "Quux Co.", "foo.bar@quux.co"),
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
  // Presentation author
  // Whether to apply some heading styling.
  style-headings: true,
  // Whether to apply the custom link style.
  style-links: true,
  // Whether to apply some raw styling.
  style-raw: true,
  // What to show in the header ("navigation", "progress", content, none).
  header: "navigation",
  // What to show in the footer ("navigation", "progress", content, none).
  footer: "progress",
  // Title background color.
  title-hero-color: ratio-palette.secondary-800,
  // Title text style.
  title-text: (size: 20pt, fill: ratio-palette.contrast),
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
  link-color: ratio-palette.primary-500,
  // Heading color.
  heading-text: (fill: ratio-palette.secondary-800),
  // Stroke color for tables and such.
  stroke-color: ratio-palette.secondary-100,
  // Fill color for code blocks and such.
  fill-color: ratio-palette.secondary-50,
  // Navigation background color.
  navigation-bar-color: ratio-palette.secondary-50,
  // Navigation text options for all text.
  navigation-text: (fill: ratio-palette.secondary-200, size: 0.5em),
  // Navigation text overrides for past sections.
  navigation-text-past: (:),
  // Navigation text overrides for the current section.
  navigation-text-current: (weight: "bold"),
  // Navigation text overrides for future sections.
  navigation-text-future: (:),
  // Navigation shape for past subsections.
  navigation-shape-past: box(height: 3.8pt, circle(
    radius: 1.7pt,
    fill: ratio-palette.secondary-100,
    stroke: 0.7pt + ratio-palette.secondary-100,
  )),
  // Navigation shape for current subsections.
  navigation-shape-current: box(height: 3.8pt, circle(
    radius: 1.7pt,
    fill: ratio-palette.primary-500,
    stroke: 0.7pt + ratio-palette.primary-500,
  )),
  // Navigation shape for future subsections.
  navigation-shape-future: box(
    height: 3.8pt,
    circle(radius: 1.7pt, stroke: 0.7pt + ratio-palette.secondary-100),
  ),
  // Progress bar height.
  progress-bar-height: 5pt,
  // Progress bar background color.
  progress-bar-color: ratio-palette.secondary-50,
  // Progress bar overlay color.
  progress-overlay-color: ratio-palette.secondary-100,
  // Progress bar text color.
  progress-text-color: ratio-palette.secondary-200,
)

// Variable to hold the options state.
#let ratio-options = state("ratio-options", ratio-defaults)

// Register new options or replace existing keys.
#let ratio-register(options) = {
  ratio-options.update(s => {
    s = s + options
    s
  })
}

// Update options by replacing values and updating dictionaries.
#let ratio-update(options) = {
  ratio-options.update(s => utils.update-dict(s, options))
}

// Draw a tiny anchor on the top right of the body text.
#let ratio-anchor(body, color: ratio-defaults.link-color) = {
  body
  h(0.05em)
  super(box(height: 0.7em, circle(radius: 0.15em, stroke: 0.08em + color)))
}

// TITLE SLIDE

// Ratio custom background image.
#let ratio-hero(fill: ratio-defaults.title-hero-color) = {
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

// Ratio title text content. Draws only from defaults, fully customizable.
#let ratio-title-content(
  title: ratio-defaults.title,
  authors: ratio-defaults.authors,
  abstract: ratio-defaults.abstract,
  date: ratio-defaults.date,
  version: ratio-defaults.version,
  keywords: ratio-defaults.keywords,
  title-text: ratio-defaults.title-text,
  heading-text: ratio-defaults.title-heading-text,
  author-text: ratio-defaults.title-author-text,
  affiliation-text: ratio-defaults.title-affiliation-text,
  abstract-text: ratio-defaults.title-abstract-text,
  version-text: ratio-defaults.title-version-text,
  register-section: false,
) = {
  let v-space = v(1.5em, weak: true)
  set text(..title-text)

  if title != none {
    text(..heading-text)[#title]
    if register-section {
      utils.register-section(title)
    }
  }

  if authors != none and authors.len() > 0 {
    for author in utils.as-array(authors) {
      v-space
      let name = author.at("name", default: none)
      let email = author.at("email", default: none)
      let affiliation = author.at("affiliation", default: none)

      let author-text = text(..author-text)[#name]
      if email == none {
        author-text
      } else {
        link("mailto:" + email)[#author-text]
      }

      if affiliation != none {
        linebreak()
        text(..affiliation-text)[#affiliation]
      }
    }
  }

  if abstract != none {
    v-space
    set text(..abstract-text)
    par(leading: 0.78em, justify: true, linebreaks: "optimized")[#abstract]
  }

  let date-line = ()
  if date != none {
    date-line.push(date.display())
  }
  if version != none {
    date-line.push(version)
  }
  if keywords != none {
    let keywords = utils.as-array(keywords)
    date-line.push(keywords.join(", "))
  }

  if date-line.len() > 0 {
    v-space
    let sep = [
      #h(1.6pt)
      |
      #h(1.6pt)
    ]
    set text(..version-text)

    date-line.join(sep)
  }
}

// Ratio style title slide.
// Draws options from context that are not in the parameter list.
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
  // Presentation keywords. Set to none to hide.
  keywords: none,
  // Foreground content to show (in front of regular title page content).
  foreground: none,
  // Background content to show (behind regular title page content).
  background: none,
  // Whether to draw the hero image.
  hero: true,
  // Whether to register this slide title as a section.
  register-section: false,
) = {
  let content = context {
    let options = ratio-options.get()

    if hero {
      let fill = options.title-hero-color
      if fill != none {
        ratio-hero(fill: fill)
      }
    }

    if background != none {
      background
    }

    place(left + horizon, block(width: 100%, inset: 15%, ratio-title-content(
      title: title,
      authors: authors,
      abstract: abstract,
      date: date,
      version: version,
      keywords: keywords,
      title-text: options.title-text,
      heading-text: options.title-heading-text,
      author-text: options.title-author-text,
      affiliation-text: options.title-affiliation-text,
      abstract-text: options.title-abstract-text,
      version-text: options.title-version-text,
    )))

    if foreground != none {
      foreground
    }
  }
  logic.polylux-slide(content)
}

// CONTENT SLIDE HELPERS

// Ratio style section navigation bar. Draws everything from options.
#let ratio-navigation() = {
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

// Ratio progress bar. Draws everything from options.
#let ratio-progress() = {
  locate(loc => {
    let options = ratio-options.at(loc)
    let current = loc.page()
    let total = counter(page).final().first()
    block(
      fill: options.progress-bar-color,
      width: 100%,
      height: options.progress-bar-height,
      place(left + horizon, utils.polylux-progress(ratio => block(
        fill: options.progress-overlay-color,
        width: ratio * 100%,
        height: 100%,
      ))),
    )
  })
}

// Ratio header or footer bar helper.
#let ratio-bar(kind) = {
  if kind == "navigation" {
    ratio-navigation()
  } else if kind == "progress" {
    ratio-progress()
  } else if kind == none {
    []
  } else {
    kind
  }
}

// Ratio header helper.
#let ratio-header() = {
  context ratio-bar(ratio-options.get().at("header", default: none))
}

// Ratio footer helper.
#let ratio-footer() = {
  context ratio-bar(ratio-options.get().at("footer", default: none))
}

// CONTENT SLIDES

// Ratio style slide.
#let slide(title: none, header: auto, footer: auto, body) = {
  let content = pad(left: 1em, right: 2em)[
    #if title != none {
      heading(level: 1, title)
    }
    #body
  ]
  let header = if header == auto {
    ratio-header()
  } else {
    header
  }
  let footer = if footer == auto {
    ratio-footer()
  } else {
    footer
  }
  logic.polylux-slide(grid(
    columns: 1,
    gutter: 1em,
    rows: (auto, 1fr, auto),
    ..(header, content, footer),
  ))
}

// Ratio style centered slide.
#let center-slide(header: auto, footer: auto, body) = {
  slide(
    header: header,
    footer: footer,
    block(width: 100%, height: 100%, place(center + horizon, body)),
  )
}

// Ratio style bare bones slide.
#let bare-slide = logic.polylux-slide

// THEME

// The Ratio theme function that sets up all styling and show rules once.
// Any provided options update the defaults by recursively updating the
// options dictionary. I.e. setting: `options: (title-text: (fill: red))`
// Only changes the title text's fill to red and maintains other options.
// You can view all defaults in the `ratio-defaults` variable.
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
    ratio-author("Jane Doe", "Foo Ltd.", "jane.doe@foo.ltd"),
    ratio-author("Foo Bar", "Quux Co.", "foo.bar@quux.co"),
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
  // Ratio theme options.
  options: (:),
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

  // Update all options.
  let options = options + (
    aspect-ratio: aspect-ratio,
    title: title,
    abstract: abstract,
    authors: authors,
    date: date,
    keywords: keywords,
    version: version,
  )
  ratio-update(options)

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
      if options.style-headings {
        // Do not hyphenate headings.
        text(hyphenate: false, ..options.heading-text)[#it]
      } else {
        it
      }
    }
  }

  // Style links if set.
  show link: it => {
    context {
      let options = ratio-options.get()
      if options.style-links {
        // Don't style for internal links.
        if type(it.dest) == label or type(it.dest) == location {
          return it
        }
        let color = options.at("link-color", default: ratio-palette.primary-500)
        ratio-anchor(it)
      } else {
        it
      }
    }
  }

  // Set raw font to Fira Code if available.
  show raw: it => {
    context {
      if ratio-options.get().style-raw {
        set text(font: "Fira Code")
        it
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
      keywords: keywords,
      register-section: false, // Don't register the cover.
    )
  }

  // Presentation contents.
  body
}
