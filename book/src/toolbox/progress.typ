#import "../../../src/polylux.typ": *

#set page(paper: "presentation-16-9")
#set text(size: 50pt, font: "Atkinson Hyperlegible")

#let my-progress = {
  [#toolbox.slide-number / #toolbox.last-slide-number]

  toolbox.progress-ratio(ratio => {
    stack(
      dir: ltr,
      rect(stroke: blue, fill: blue, width: ratio       * 8cm),
      rect(stroke: blue, fill: none, width: (1 - ratio) * 8cm),
    )
  })
}

#set align(horizon)

#for _ in range(6) {
  slide[
    #my-progress
  ]
}
