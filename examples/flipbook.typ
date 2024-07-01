#import "../polylux.typ": *
#import "@preview/cetz:0.1.0"

#set page(paper: "presentation-16-9", margin: 2em)
#set text(size: 30pt, font: "Kalam")

#polylux-slide[
  == A sunrise on Capri
  #alternatives-fn(count: 30, position: top+left, subslide =>
    cetz.canvas({
      import cetz.draw: *
      stroke(none)
      circle((0, 7), radius: 1pt)
      fill(orange)
      circle((3, subslide * 3. / 30), radius: 3)
    })
  )
]
