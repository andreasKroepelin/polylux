#import "../../../polylux.typ": *
#set page(paper: "presentation-16-9")
#set text(size: 50pt)

/*
#alternatives-match((
  "1, 3" : [
    Some text
  ],
  "2" : [
    #set text(fill: teal)
    Some text
  ],
))
*/

#polylux-slide[
#alternatives-cases(("1, 3", "2"), case => [
  #set text(fill: teal) if case == 1
  Some text
])
]
