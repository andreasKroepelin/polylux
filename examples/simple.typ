#import "../slides.typ": *

#show: slides.with(
    authors: "Names of author(s)",
    short-authors: "Shorter author for slide footer",
    title: "Title of the presentation",
    subtitle: "Subtitle of the presentation",
    short-title: "Shorter title for slide footer",
    date: "March 2023",
)

#set text(font: "Inria Sans")

#slide(theme-variant: "title slide")

#new-section("My section name")

#slide(title: "A boring static slide")[
  Some boring static text.

  #lorem(20)
]

#slide[
  A fancy dynamic slide without a title.
  #uncover("2-")[This appears later!]
]

#slide(theme-variant: "wake up")[
  Focus!
]

#new-section("Conclusion")

#slide(title: "Take home message")[
  Read the book!

  Try it out!

  Create themes!
]
