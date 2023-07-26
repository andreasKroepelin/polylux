#import "../logic.typ"
#import "../helpers.typ"

// University theme
//
// Originally contributed by Pol Dellaiera - https://github.com/drupol
//
// Please feel free to improve this theme
// by submitting a PR in https://github.com/andreasKroepelin/typst-slides

#let uni-colors = state("uni-colors", (:))
#let uni-short-title = state("uni-short-title", none)
#let uni-short-author = state("uni-short-author", none)
#let uni-short-date = state("uni-short-date", none)
#let uni-progress-bar = state("uni-progress-bar", true)

#let university-theme(
  aspect-ratio: "16-9",
  short-title: none,
  short-author: none,
  short-date: none,
  color-a: rgb("#0C6291"),
  color-b: rgb("#A63446"),
  color-c: rgb("#FBFEF9"),
  progress-bar: true,
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

  uni-progress-bar.update(progress-bar)
  uni-colors.update((a: color-a, b: color-b, c: color-c))
  uni-short-title.update(short-title)
  uni-short-author.update(short-author)
  uni-short-date.update(short-date)

  body
}

#let title-slide(
  title: [],
  subtitle: none,
  authors: (),
  institution-name: "University",
  date: none,
  logo: none,
) = {
  let authors = if type(authors) ==  "array" { authors } else { (authors,) }

  let content = locate( loc => {
    let colors = uni-colors.at(loc)

    if logo != none {
      align(right, logo)
    }

    align(center + horizon, {
      block(
        inset: 0em,
        breakable: false,
        {
          text(size: 2em, fill: colors.a, strong(title))
          if subtitle != none {
            parbreak()
            text(size: 1.2em, fill: colors.a, subtitle)
          }
        }
      )
      set text(size: .8em)
      grid(
        columns: (1fr,) * calc.min(authors.len(), 3),
        column-gutter: 1em,
        row-gutter: 1em,
        ..authors.map(author => text(fill: black, author))
      )
      v(1em)
      if institution-name != none {
        parbreak()
        text(size: .9em, institution-name)
      }
      if date != none {
        parbreak()
        text(size: .8em, date)
      }
    })
  })

  logic.polylux-slide(content)
}


#let slide(
  title: none,
  columns: none,
  gutter: none,
  header: none,
  footer: none,
  new-section: none,
  ..bodies
) = {
  let bodies = bodies.pos()
  let gutter = if gutter == none { 1em } else { gutter }
  let columns = if columns ==  none { (1fr,) * bodies.len() } else { columns }
  if columns.len() != bodies.len() {
    panic("number of columns must match number of content arguments")
  }

  let body = pad(x: 2em, y: .5em, grid(columns: columns, gutter: gutter, ..bodies))
  
  let progress-barline = locate( loc => {
    if uni-progress-bar.at(loc) {
      let cell = block.with( width: 100%, height: 100%, above: 0pt, below: 0pt, breakable: false )
      let colors = uni-colors.at(loc)

      helpers.polylux-progress( ratio => {
        grid(
          rows: 2pt, columns: (ratio * 100%, 1fr),
          cell(fill: colors.a),
          cell(fill: colors.b)
        )
      })
    } else { [] }
  })

  let header-text = {
    if header != none {
      header
    } else if title != none {
      if new-section != none {
        helpers.register-section(new-section)
      }
      locate( loc => {
        let colors = uni-colors.at(loc)
        block(fill: colors.c, inset: (x: .5em), grid(
          columns: (60%, 40%),
          align(top + left, heading(level: 2, text(fill: colors.a, title))),
          align(top + right, text(fill: colors.a.lighten(65%), helpers.current-section))
        ))
      })
    } else { [] }
  }

  let header = {
    set align(top)
    grid(rows: (auto, auto), row-gutter: 3mm, progress-barline, header-text)
  }

  let footer = {
    set text(size: 10pt)
    set align(center + bottom)
    let cell(fill: none, it) = rect(
      width: 100%, height: 100%, inset: 1mm, outset: 0mm, fill: fill, stroke: none,
      align(horizon, text(fill: white, it))
    )
    if footer != none {
      footer
    } else {
      locate( loc => {
        let colors = uni-colors.at(loc)

        show: block.with(width: 100%, height: auto, fill: colors.b)
        grid(
          columns: (25%, 1fr, 15%, 10%),
          rows: (1.5em, auto),
          cell(fill: colors.a, uni-short-author.display()),
          cell(uni-short-title.display()),
          cell(uni-short-date.display()),
          cell(logic.logical-slide.display() + [~/~] + helpers.last-slide-number)
        )
      })
    }
  }


  set page(
    margin: ( top: 2em, bottom: 1em, x: 0em ),
    header: header,
    footer: footer,
    footer-descent: 0em,
    header-ascent: .6em,
  )

  logic.polylux-slide(body)
}

#let focus-slide(background-color: none, background-img: none, body) = {
  let background-color = if background-img == none and background-colour ==  none {
    rgb("#0C6291")
  } else {
    background-color
  }

  set page(fill: background-color, margin: 1em) if background-color != none
  set page(
    background: {
      set image(fit: "stretch", width: 100%, height: 100%)
      background-img
    },
    margin: 1em,
  ) if background-img != none

  set text(fill: white, size: 2em)

  logic.polylux-slide(align(horizon, body))
}

#let matrix-slide(columns: none, rows: none, ..bodies) = {
  let bodies = bodies.pos()

  let columns = if type(columns) == "integer" {
    (1fr,) * columns
  } else if columns == none {
    (1fr,) * bodies.len()
  } else {
    columns
  }
  let num-cols = columns.len()

  let rows = if type(rows) == "integer" {
    (1fr,) * rows
  } else if rows == none {
    let quotient = calc.quo(bodies.len(), num-cols)
    let correction = if calc.rem(bodies.len(), num-cols) == 0 { 0 } else { 1 }
    (1fr,) * (quotient + correction)
  } else {
    rows
  }
  let num-rows = rows.len()

  if num-rows * num-cols < bodies.len() {
    panic("number of rows (" + str(num-rows) + ") * number of columns (" + str(num-cols) + ") must at least be number of content arguments (" + str(bodies.len()) + ")")
  }

  let cart-idx(i) = (calc.quo(i, num-cols), calc.rem(i, num-cols))
  let color-body(idx-body) = {
    let (idx, body) = idx-body
    let (row, col) = cart-idx(idx)
    let color = if calc.even(row + col) { white } else { silver }
    set align(center + horizon)
    rect(inset: .5em, width: 100%, height: 100%, fill: color, body)
  }

  let content = grid(
    columns: columns, rows: rows,
    gutter: 0pt,
    ..bodies.enumerate().map(color-body)
  )

  logic.polylux-slide(content)
}
