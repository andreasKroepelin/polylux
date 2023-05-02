#import "../../../slides.typ": *
#import "../../../themes/void.typ": *

#show: slides.with(
    authors: ("Author A", "Author B"), short-authors: "Short author",
    title: "Title", short-title: "Short title", subtitle: "Subtitle",
    date: "Date",
    theme: void-theme(dark: false),
)

#slide(theme-variant: "title slide")

#slide(title: "Slide title")[
  #lorem(30)
]
