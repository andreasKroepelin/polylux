#import "../polylux.typ": *
#set page(paper: "presentation-16-9")
#set text(size: 50pt)

#polylux-slide[
  == `alternatives-fn`
  #alternatives-fn(start: 1, end: 8, subslide => [#subslide])

  #uncover(3)[only on 3]

  #uncover("10,11-")[from 10 on]
]

#polylux-slide[
  == `pause`
  a
  #pause

  a
  #pause

  a
]

#polylux-slide[
  Can you see me?
]
