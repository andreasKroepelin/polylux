#import "../../../../polylux.typ": *

#import themes.university: *

#show: university-theme.with(
  short-author: "Short author",
  short-title: "Short title",
  short-date: "Short date",
)

#title-slide(
  authors: ("Author A", "Author B"),
  title: "Title",
  subtitle: "Subtitle",
  date: "Date",
  institution-name: "University Name",
  logo: image("dummy-logo.png", width: 60mm)
)

#slide(title: [Slide title], new-section: [The section])[
  #lorem(40)
]


#slide(title: "A longer slide title with 2 columns")[
  #lorem(30)
][
  #lorem(30)
]

#focus-slide(background-img: image("background.svg"))[
  *Another variant with an image in background...*
]

#matrix-slide[
  left
][
  middle
][
  right
]

#matrix-slide(columns: 1)[
  top
][
  bottom
]

#matrix-slide(columns: (1fr, 2fr, 1fr), ..(lorem(8),) * 9)
