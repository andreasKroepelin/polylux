// This theme is inspired by https://slidesgo.com/theme/modern-annual-report

#import "../logic.typ"


#let bipartite-dark = rgb("#192e41")
#let bipartite-bright = rgb("#fafafa")
#let bipartite-accent = rgb("#fc9278")

#let bipartite-theme(
  aspect-ratio: "16-9",
  body
) = {
  set page(
    paper: "presentation-" + aspect-ratio,
    margin: 0pt,
  )

  body
}

#let title-slide(title: [], subtitle: none, author: [], date: none) = {
  let title-block(fg, bg, height, body) = block(
    width: 100%, height: height, outset: 0em, inset: 0em, breakable: false,
    stroke: none, spacing: 0em, fill: bg,
    align(center + horizon, text(fill: fg, body))
  )
  let content = {
    title-block(bipartite-dark, bipartite-bright, 60%, text(1.7em, title))
    title-block(bipartite-bright, bipartite-dark, 40%, {
      if subtitle != none {
        text(size: 1.2em, subtitle)
        parbreak()
      }

      text(size: .9em, { author; if date != none { h(1em); sym.dot.c; h(1em); date } })
    })
    place(
      center + horizon, dy: 10%,
      rect(width: 6em, height: .5em, radius: .25em, fill: bipartite-accent)
    )
  }
  logic.polylux-slide(content)
}

#let _bipartite-content-box(fg, bg, width, alignment, body) = box(
  width: width, height: 100%, outset: 0em, inset: (x: 1em), baseline: 0em,
  stroke: none, fill: bg,
  align(alignment + horizon, text(fill: fg, body))
)

#let west-slide(title: none, body) = {
  let content = {
    _bipartite-content-box(
      bipartite-bright, bipartite-dark, 30%, left,
      if title != none { heading(level: 2, title) } else { [] }
    )
    _bipartite-content-box(bipartite-dark, bipartite-bright, 70%, left, body)
  }
  logic.polylux-slide(content)
}

#let east-slide(title: none, body) = {
  let content = {
    _bipartite-content-box(bipartite-dark, bipartite-bright, 70%, right, body)
    _bipartite-content-box(
      bipartite-bright, bipartite-dark, 30%, right,
      if title != none { heading(level: 2, title) } else { [] }
    )
  }
  logic.polylux-slide(content)
}

#let split-slide(body-left, body-right) = {
  let content = {
    _bipartite-content-box(bipartite-dark, bipartite-bright, 50%, right, body-left)
    _bipartite-content-box(bipartite-bright, bipartite-dark, 50%, left, body-right)
  }
  logic.polylux-slide(content)
}
