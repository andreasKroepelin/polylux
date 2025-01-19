#import "../polylux.typ": *

#set page(paper: "presentation-16-9")

#slide[
  #item-by-item[
    + abc
    + def
    + ghi
  ]
]

#slide[
  - abc
  #show: later
  - def
  #show: later
  - ghi
]
