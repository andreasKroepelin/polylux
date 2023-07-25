#import "../../../polylux.typ": *

#set page(paper: "presentation-16-9", fill: teal.lighten(90%))
#set text(size: 25pt, font: "Blogger Sans")

#polylux-slide[
  #set align(horizon + center)
  = My fabulous talk

  Jane Doe

  Conference on Advances in Slide Making
]

#polylux-slide[
  == My slide title
  Hello, world!
]

#polylux-slide[
  == A quiz

  What is the capital of the Republic of Benin?

  #uncover(2)[Cotonou]
]
