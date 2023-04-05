#import "../../../slides.typ": *

#show: slides.with(
    author: "Author", short-author: "Short author",
    title: "Title", short-title: "Short title", subtitle: "Subtitle",
    date: "Date",
)

#new-section("section name")

#slide[
  A slide
]

#slide(theme-variant: "wake up")[
  Wake up!
]
