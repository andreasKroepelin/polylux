// This theme contains ideas from the former "bristol" theme, contributed by
// https://github.com/MarkBlyth

#import "../logic.typ"

#let clean-footer = state("clean-footer", [])
#let clean-short-title = state("clean-short-title", none)
#let clean-color = state("clean-color", teal)
#let clean-logo = state("clean-logo", none)
#let clean-section = state("clean-section", [])

#let new-section(it) = clean-section.update(it)

#let clean-theme(
  aspect-ratio: "16-9",
  footer: [],
  short-title: none,
  logo: none,
  color: teal,
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
  show heading.where(level: 2): set block(below: 1.5em)
  set outline(target: heading.where(level: 1), title: none, fill: none)
  show outline.entry: it => it.body
  show outline: it => block(inset: (x: 1em), it)


  clean-footer.update(footer)
  clean-color.update(color)
  clean-short-title.update(short-title)
  clean-logo.update(logo)

  body
}


#let title-slide(
  title: none,
  subtitle: none,
  authors: (),
  date: none,
  watermark: none,
  secondlogo: none,
) = {
  let content = locate( loc => {
    let color = clean-color.at(loc)
    let logo = clean-logo.at(loc)
    let authors = if type(authors) in ("string", "content") {
      ( authors, )
    } else {
      authors
    }

    if type(watermark) == "string" {
      place(image(watermark, width:100%))
    }

    v(5%)
    grid(columns: (5%, 1fr, 1fr, 5%),
      [],
      if type(logo) == "string" { align(bottom + left, image(logo, height: 3em)) } else { [] },
      if type(secondlogo) == "string" { align(bottom + right, image(secondlogo, height: 3em)) } else { [] },
      []
    )

    v(-10%)
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

#let slide(title: none, columns: none, gutter: none, ..bodies) = {
  let header = locate( loc => {
    let color = clean-color.at(loc)
    let logo = clean-logo.at(loc)
    let short-title = clean-short-title.at(loc)
    let sections = query(heading.where(level: 1, outlined: true).before(loc), loc)
    let section = if sections == () [] else { sections.last().body }

    block(
      stroke: ( bottom: 1mm + color ), width: 100%, inset: ( y: .3em ),
      text(.5em, grid(columns: (1fr, 1fr),
        if type(logo) == "string" { align(left, image(logo, height: 4em)) } else { [] },
        if short-title != none {
          align(right, grid(
            columns: 1, rows: 1em, gutter: .5em,
            short-title,
            section
          ))
        } else {
          align(horizon + right, section)
        }
      ))
    )
  })

  let footer = locate( loc => {
    let color = clean-color.at(loc)

    block(
      stroke: ( top: 1mm + color ), width: 100%, inset: ( y: .3em ),
      text(.5em, {
        clean-footer.display()
        h(1fr)
        logic.logical-slide.display()
      })
    )
  })

  set page(
    margin: ( top: 4em, bottom: 2em, x: 2em ),
    header: header,
    footer: footer,
    footer-descent: 1em,
    header-ascent: 1.5em,
  )

  let bodies = bodies.pos()
  let gutter = if gutter == none { 1em } else { gutter }
  let columns = if columns ==  none { (1fr,) * bodies.len() } else { columns }
  if columns.len() != bodies.len() {
    panic("number of columns must match number of content arguments")
  }

  let body = grid(columns: columns, gutter: gutter, ..bodies)
  

  let content = {
    if title != none {
      heading(level: 2, title)
    }
    body
  }
  
  logic.polylux-slide(content)
}

#let focus-slide(background: teal, foreground: white, body) = {
  set page(fill: background, margin: 2em)
  set text(fill: foreground, size: 1.5em)
  logic.polylux-slide(align(horizon, body))
}

#let new-section-slide(name) = {
  set page(margin: 2em)
  let content = locate( loc => {
    let color = clean-color.at(loc)
    align(
      center + horizon,
      block(
        stroke: ( bottom: 1mm + color ), inset: 1em,
        heading(level: 1, name)
      )
    )
  })
  logic.polylux-slide(content)
}
