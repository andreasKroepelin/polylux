// This theme is inspired by https://slidesgo.com/theme/modern-annual-report

#let metropolis-theme(extra: none) = data => {
  //let m-dark-brown = rgb("#604c38")
  let m-dark-teal = rgb("#23373b")
  let m-light-brown = rgb("#eb811b")
  let m-lighter-brown = rgb("#d6c6b7")
  let m-light-green = rgb("#14b03d")
  let m-extra-light-gray = white.darken(2%)

  let my-dark = rgb("#192e41")
  let my-bright = rgb("#fafafa")
  let my-accent = rgb("#fc9278")

  let cell = block.with(
    width:100%,
    height:100%,
    above:0pt,
    below:0pt,
    breakable:false
  )

  let title-slide(slide-info, bodies) = {
    if bodies.len() != 0 {
        panic("title slide of bipartite theme does not support any bodies")
    }
    set text(fill: m-dark-teal)
    cell(fill: m-extra-light-gray)[
      #align(horizon)[
        #block(
          width:100%,
          inset:2em
        )[
          #text(1.3em)[*#data.title*]
          #if data.subtitle != none {
            linebreak()
            text(0.9em)[#data.subtitle]
          }
          #line(length:100%, stroke: .05em + m-light-brown)
          #text(size: .8em)[#data.authors.join(", ")]
          #if extra != none {
            linebreak()
            extra
          }
        ]
      ]
    ]
  }

  let displayed-title(slide-info) = if "title" in slide-info {
    heading(level: 1, text(fill: my-bright, slide-info.title))
  } else {
    []
  }

  let default(slide-info, bodies) = {
    if bodies.len() != 1 {
      panic("default variant of metropolis theme only supports one body per slide")
    }
    let body = bodies.first()
    grid(
      rows: (0.2em,2em,1fr),
      column-gutter: 0pt,
      row-gutter: 0pt
    )[
      #locate(loc => {
        let filled = counter("logical-slide").at(loc).first() / counter("logical-slide").final(loc).first()*100%
        grid(columns: (filled,1fr),cell(fill:m-light-brown),cell(fill:m-lighter-brown))
      })
    ][
      #cell(fill:m-dark-teal,inset: (left:.5em))[
        #align(horizon)[
          #text(fill: m-extra-light-gray,size:1.2em)[*#slide-info.title*]
        ]
      ]
    ][
      #cell(fill: m-extra-light-gray,inset: 2em)[
        #align(horizon)[
          #text(fill: m-dark-teal)[#bodies.first()]
        ]
      ]
    ]
  }

  let east(slide-info, bodies) = {
    if bodies.len() != 1 {
      panic("east variant of bipartite theme only supports one body per slide")
    }
    let body = bodies.first()

    box(
      width: 70%, height: 100%, outset: 0em, inset: (x: 1em), baseline: 0em,
      stroke: none, fill: my-bright,
      align(right + horizon, text(fill: my-dark, body))
    )
    box(
      width: 30%, height: 100%, outset: 0em, inset: (x: 1em), baseline: 0em,
      stroke: none, fill: my-dark,
      align( right + horizon, displayed-title(slide-info) )
    )
  }

  let center-split(slide-info, bodies) = {
    if bodies.len() != 2 {
      panic("center split variant of bipartite theme only supports two bodies per slide")
    }
    let body-left = bodies.first()
    let body-right = bodies.last()

    box(
      width: 50%, height: 100%, outset: 0em, inset: (x: 1em), baseline: 0em,
      stroke: none, fill: my-bright,
      align(right + horizon, text(fill: my-dark, body-left))
    )
    box(
      width: 50%, height: 100%, outset: 0em, inset: (x: 1em), baseline: 0em,
      stroke: none, fill: my-dark,
      align(left + horizon, text(fill: my-bright, body-right))
    )
  }

  (
    "title slide": title-slide,
    "default": default,
    "east": east,
    "center split": center-split,
  )
}
