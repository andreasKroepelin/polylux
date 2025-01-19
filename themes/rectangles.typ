#import "../logic.typ"
#import "../utils/utils.typ"

// Rectangles theme by Ruben Felgenhauer (felsenhower).
// This theme was inspired by LaTeX presentations using the outer theme "miniframes" and inner theme "rectangles".

#let rectangles-title = state("rectangles-title", none)
#let rectangles-subtitle = state("rectangles-subtitle", none)
#let rectangles-authors = state("rectangles-authors", none)
#let rectangles-date = state("rectangles-date", none)
#let rectangles-short-title = state("rectangles-short-title", none)
#let rectangles-short-authors = state("rectangles-short-authors", none)
#let rectangles-accent-fill-color = state("rectangles-accent-fill-color", none)
#let rectangles-accent-text-color = state("rectangles-accent-text-color", none)

#let rectangles-theme(
  aspect-ratio: "16-9",
  title: none,
  subtitle: none,
  authors: none,
  date: none,
  short-title: none,
  short-authors: none,
  accent-fill-color: rgb("#008ccc"),
  accent-text-color: white,
  body
) = {
  set page(
    paper: "presentation-" + aspect-ratio,
    margin: 0em,
    header: none,
    footer: none,
  )
  set text(size: 25pt)
  show footnote.entry: set text(size: .6em)
  show heading.where(level: 1): it => pad(bottom: 1em, it)
  set list(marker: text(accent-fill-color, sym.square.filled))
  
  if short-title == none and title != none {
    short-title = if subtitle != none {
      title + [ – ] + subtitle
    } else {
      title
    }
  }
  if authors != none and type(authors) != "array" {
    authors = (authors, )
  }
  if short-authors == none and authors != none {
    short-authors = authors.join(", ")
  }
  
  rectangles-short-title.update(short-title)
  rectangles-title.update(title)
  rectangles-subtitle.update(subtitle)
  rectangles-accent-fill-color.update(accent-fill-color)
  rectangles-accent-text-color.update(accent-text-color)
  rectangles-authors.update(authors)
  rectangles-date.update(date)
  rectangles-short-authors.update(short-authors)

  body
}

#let title-slide() = {
  let content = locate(loc => {
    let authors = rectangles-authors.at(loc)
    let title = rectangles-title.at(loc)
    let subtitle = rectangles-subtitle.at(loc)
    let date = rectangles-date.at(loc)
    let accent-fill-color = rectangles-accent-fill-color.at(loc)
    let accent-text-color = rectangles-accent-text-color.at(loc)

    align(center + horizon, [
      #block(fill: accent-fill-color, width: 60%, inset: 1em)[
        #set text(accent-text-color)
        #text(1.5em, weight: 500, title) \
        #{
          if subtitle != none {
            parbreak()
            subtitle
          }
        }
      ]
      #set text(size: .8em)
      #grid(
        columns: 1,
        row-gutter: 1em,
        ..authors, "", date
      )
    ])
  })

  logic.polylux-slide(content)
}

#let slide(
  body
) = {
  body = pad(x: 2em, y: .5em, body)
  
  let decoration(body) = {
    locate(loc => {
      let accent-fill-color = rectangles-accent-fill-color.at(loc)
      let accent-text-color = rectangles-accent-text-color.at(loc)
      set text(accent-text-color, size: 11pt)
      block(
        fill: accent-fill-color,
        width: 100%,
        inset: 0.75em,
        height: 2.2em,
        align(horizon, body)
      )
    })
  }
  
  let header = {
    align(top, decoration( 
      align(center, utils.current-section),
    ))
  }

  let footer = {
    align(bottom,
    decoration(grid(
      columns: (1fr, auto, 1fr),
      align(left, rectangles-short-authors.display()),
      align(center, rectangles-short-title.display()),
      align(right, logic.logical-slide.display() + [~/~] + utils.last-slide-number)
    )))
  }

  set page(
    margin: (top: 2em, bottom: 1em, x: 0em),
    header: header,
    footer: footer,
    footer-descent: 0em,
    header-ascent: 0em,
  )

  logic.polylux-slide(body)
}

#let new-section(name) = {
  utils.register-section(name)
} 
