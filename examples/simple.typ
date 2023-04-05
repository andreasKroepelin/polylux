#import "../slides.typ": *

#show: slides.with(
    author: "Names of author(s)",
    short-author: "Shorter author for slide footer",
    title: "Title of the presentation",
    short-title: "Shorter title for slide footer",
    date: "March 2023",
)

#new-section("My section name")

#slide(title: "A boring static slide")[
  Some boring static text.
]

#slide[
  A fancy dynamic slide without a title.
  More text.
  #only(2)[This appears later!]
]
