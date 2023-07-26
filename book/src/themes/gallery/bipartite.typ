#import "../../../../polylux.typ": *

#import themes.bipartite: *

#show: bipartite-theme

#set text(size: 25pt)

#title-slide(
  author: [Author],
  title: [Title],
  subtitle: [Subtitle],
  date: [Date],
)

#west-slide(title: "A longer slide title")[
  #lorem(40)
]

#east-slide(title: "On the right!")[
  #lorem(40)
]

#split-slide[
  #lorem(40)
][
  #lorem(40)
]
