#import "../../../slides.typ": *
#import "../../../themes/university.typ": *

#show: slides.with(
    authors: ("Author A", "Author B"), short-authors: "Short author",
    title: "Title", short-title: "Short title", subtitle: "Subtitle",
    date: "Date",
    theme: university-theme(
        institution-name: "UniversityName",
        logo: image("300x200.svg", width: 60mm)
    )
)

#slide(theme-variant: "title slide")

#new-section("section name")

#slide(title: "A longer slide title")[
  #lorem(40)
]

#slide(title: "A longer slide title with 2 columns")[
  #lorem(40)
][
  #lorem(40)
]

#slide(theme-variant: "wake up", background: "../book/src/theme-gallery/background.svg")[
    *Another variant with an image in background...*
]

#slide(theme-variant: "split v", columns: 2, fill: rgb("#0000ff"))[
    #box(
        height: 100%,
    )[
        #image("1080x1920.svg", fit: "stretch")
    ]
][
    #box(
        width: 100%,
        height: 100%,
        inset: 2em,
        fill: rgb("#ff0000"),
    )[
        #align(center + horizon, text(fill: white)[
            Or a split slide with some content on the left and some on the
            right...
        ])
    ]
]

#slide(theme-variant: "split v")[
  left side
][
  right side
]

#slide(theme-variant: "split h")[
  top side
][
  bottom side
]

#slide(theme-variant: "split matrix")[
  top left box
][
  top right box
][
  bottom left box
][
  bottom right box
]
