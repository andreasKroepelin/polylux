#import "../polylux.typ": *

#set page(paper: "presentation-16-9")

#polylux-slide[
  == Text like content

  Hello
  #pause
  $a + b$
  #pause
  $ integral f(x) dif x $
  #pause

  - *item1*
  - _item2_
  - `item3`

  #pause
  
  + #underline[item1]
  + #strike[item2]
  + #overline[item3]

  #pause

  / def1: abc
  / def2: ghi

  #pause

  #box(stroke: 2pt + aqua, inset: 2pt)[boxed!]

  #pause

  #block(stroke: 2pt + lime, inset: 2pt)[blocked!]
]

#polylux-slide[
  == Inside grid
  
  #grid(columns: 4 * (1fr,))[
    abc
    #pause
  ][
    def
    #pause
  ][
    ghi
    #pause
  ][
    jkl
  ]
]

#polylux-slide[
  == Visuals

  #pause
  
  // Fails to be hidden as of Typst 0.7.0
  #path(
    fill: teal.lighten(50%), stroke: teal, closed: true,
    (0cm, 0cm), (1cm, 0cm), (1cm, 1cm)
  )

  #rect()

  #square()

  #circle()

  #ellipse()

  // Fails to be hidden as of Typst 0.7.0
  #line()

  // Fails to be hidden as of Typst 0.7.0
  #polygon(
    fill: teal.lighten(50%), stroke: teal,
    (0cm, 0cm), (1cm, 0cm), (1cm, 1cm)
  )

  #image("../assets/logo.png", width: 3em)
]

