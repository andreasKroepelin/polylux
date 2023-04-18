#import "../../../slides.typ": *
#import "../../../themes/uob/uob.typ": *

#show: slides.with(
    authors: ("Author A", "Author B"), short-authors: "Short author",
    title: "Title", short-title: "Short title", subtitle: "Subtitle",
    date: "Date",
    theme: uob-theme(),
)

#new-section("section name")

#slide(title: "Slide title")[
  A slide
]

#slide(theme-variant: "wake up")[
  Wake up!
]