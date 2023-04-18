#import "../slides.typ": *

#show: slides.with(
    authors: "Names of author(s)",
    short-authors: "Shorter author for slide footer",
    title: "Title of the presentation",
    subtitle: "Subtitle of the presentation",
    short-title: "Shorter title for slide footer",
    date: "March 2023",
)

#new-section("My section name")

#slide(title: "Slide title")[
  #lorem(40)
]

#let special-purpose-theme(slide-info, bodies) = align(horizon)[
  #rotate(45deg, heading(level: 2, slide-info.title))
  #scale(x: -100%, bodies.first())
]
#slide(override-theme: special-purpose-theme, title: "This is rotated")[
  #lorem(40)
]
