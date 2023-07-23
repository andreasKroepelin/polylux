#import "../logic.typ"

#let clean-footer = state("clean-footer", [])
#let clean-color = state("clean-color", teal)
#let clean-section = state("clean-section", [])

#let new-section(it) = clean-section.update(it)

#let clean-theme(
  aspect-ratio: "16-9",
  footer: [],
  color: teal,
  body
) = {
  set page(
    paper: "presentation-" + aspect-ratio,
    margin: 2em,
    header: none,
    footer: none,
  )
  set text(size: 25pt)
  show footnote.entry: set text(size: .6em)
  show heading.where(level: 2): set block(below: 1.5em)
  set outline(target: heading.where(level: 1), title: none, fill: none)

  clean-footer.update(footer)
  clean-color.update(color)

  body
}


#let title-slide(
  title: none,
  subtitle: none,
  authors: (),
  date: none,
) = {
  let content = locate( loc => {
    let color = clean-color.at(loc)
    let authors = if type(authors) in ("string", "content") {
      ( authors, )
    } else {
      authors
    }
    align(center + horizon)[
      #block(
        stroke: ( y: 1mm + color ),
        inset: 1em,
        breakable: false,
        [
          #text(1.3em)[*#title*] \
          #{
            if subtitle != none {
              parbreak()
              text(.9em)[#subtitle]
            }
          }
        ]
      )
      #set text(size: .8em)
      #grid(
        columns: (1fr,) * calc.min(authors.len(), 3),
        column-gutter: 1em,
        row-gutter: 1em,
        ..authors
      )
      #v(1em)
      #date
    ]
  })
  logic.polylux-slide(content)
}

#let slide(title: none, body) = {
  let decoration(position, body) = {
    locate( loc => {
      let color = clean-color.at(loc)
      let border = 1mm + color
      let strokes = (
        header: ( bottom: border ),
        footer: ( top: border )
      )
      block(
        stroke: strokes.at(position),
        width: 100%,
        inset: ( y: .3em),
        text(.5em, body)
      )
    })
  }

  set page(
    header: decoration("header", clean-section.display()),
    footer: decoration("footer", {
      clean-footer.display(); h(1fr); logic.logical-slide.display()
    }),
    footer-descent: 1em,
    header-ascent: 1em,
  )

  let content = {
    if title != none {
      heading(level: 2, title)
    }
    body
  }
  
  logic.polylux-slide(content)
}

#let focus-slide(bg: teal, fg: white, body) = {
  set page(fill: bg)
  set text(fill: fg, size: 1.5em)
  logic.polylux-slide(align(horizon, body))
}
