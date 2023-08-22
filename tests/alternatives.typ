#import "../polylux.typ": *

#set page(paper: "presentation-16-9")

#polylux-slide[
  == Test that `repeat-last` works

  #alternatives[abc ][def ][ghi ]

  #alternatives(repeat-last: true)[jkl ][mno ][this stays ]

  #uncover(5)[You can go now.]
]
