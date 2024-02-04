#import "../../../../polylux.typ": *

#import themes.rectangles: *

#set text(font: "Fira Sans", weight: "regular")

#show: rectangles-theme.with(
  authors: ("Author A", "Author B"),
  title: "Title",
  subtitle: "Subtitle",
  date: "Date",
)

#title-slide()

#new-section("First section")

#slide[
  = First slide

  #lorem(20)
]

#slide[
  = Second slide

  - Bullet points...
  - They are using the accent color!
]

#slide[
  = Third slide
  Did you know that...

  #pause
  ...you can see the current section at the top of the slide?
]
