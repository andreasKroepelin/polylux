#import "../../../slides.typ": *
#import "../../../themes/bristol.typ": *

#show: slides.with(
    authors: ("Author A", "Author B"), short-authors: "Short author",
    title: "Title", short-title: "Short title", subtitle: "Subtitle",
    date: "Date",
    theme: bristol-theme(),
)

#slide(theme-variant: "title slide")

#new-section("section name")

#slide(title: "Slide title")[
  A slide
]

#slide(title: "Two column")[
Column A goes on the left...
][
And column B goes on the right!
]

#slide(title: "Variable column sizes", colwidths: (2fr, 1fr, 3fr))[
This is a medium-width column
][
This is a rather narrow column
][
This is a quite a wide column
]

#slide(theme-variant: "wake up")[
  Wake up!
]