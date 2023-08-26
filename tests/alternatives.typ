#import "../polylux.typ": *

#set page(paper: "presentation-16-9")

#polylux-slide[
  == Test that `repeat-last` works

  #alternatives[abc ][def ][ghi ]

  #alternatives(repeat-last: true)[jkl ][mno ][this stays ]

  #uncover(5)[You can go now.]
]

#polylux-slide[
  == Test that `alternatives-match` works

  #alternatives-match(position: center, (
    "-2": [beginning],
    "3, 5": [main part],
    "4": [short break],
    "6-" : [end]
  ))

  #uncover("1-8")[I am always here, for technical reasons.]
]

#polylux-slide[
  == Test that `alternatives-cases` works

  #alternatives-cases(("1,3,4", "2,5", "6"), case => {
    set text(fill: lime) if case == 1
    lorem(10)
  })
]

#polylux-slide[
  == Test that `alternatives-fn` works

  #alternatives-fn(count: 5, subslide => numbering("(i)", subslide))
]
