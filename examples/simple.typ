#import "../polylux.typ": *

#import themes.simple: *

#set text(font: "Inria Sans")

#show: simple-theme.with(
  footer: [Simple slides],
)

#title-slide[
  = A fascinating presentation
  #v(2em)

  Anton #footnote[Uni Augsburg] <uaachen> #h(1em)
  Berta #footnote[Uni Bayreuth] #h(1em)
  Caesar #footnote[Uni Chemnitz] #h(1em)
  Anette @uaachen

  July 23
]

#slide[
  #heading(outlined: false, level: 2)[Outline]
  #outline()
]

#slide[
  == First slide

  #lorem(20)
]

#focus-slide[
  _Focus!_

  This is very important.
]

#centered-slide[
  = Next part
]

#slide[
  == Let's see some sources
  Where have they gone?

  #uncover(2)[
    Ahh here they are:
    @A @B @C @D @E @F @G @H
  ]
]

#slide[
  == Two columns
  #grid(columns: (1fr, 1fr),
    [
      Here we can see content that is
    ],
    [
      split into two columns using `#grid`.
    ]
  )
]

#centered-slide[
  = Appendix

  ... what no one wants to see.
]


#slide[
  == Bibliography
  #bibliography(title: none, "literature.bib")
]

