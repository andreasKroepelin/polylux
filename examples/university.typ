#import "../slides.typ": *
#import "../themes/university.typ": *

#let color-a = rgb("#0C6291")
#let color-b = rgb("#A63446")
#let color-c = rgb("#7E1946")

#show: slides.with(
    authors: "Andreas Kröpelin",
    short-authors: "A. Kröpelin",
    title: [`typst-slides`: Easily creating slides in Typst ],
    subtitle: "An overview over all the features",
    short-title: "Slides template demo",
    date: "April 2023",
    theme: university-theme(
        university-name: "UniversityName",
        color-a: color-a,
        color-b: color-b,
        color-c: color-c,
        logo: "../examples/300x200.svg"
    )
)

#new-section("Themes")

#slide(title: "How a slide looks...")[
    ... is defined by the _theme_ of the presentation.

    This demo uses the `university` theme.

    Because of it, the title slide and the decoration on each slide (with
    section name, short title, slide number etc.) look the way they do.

    Themes can also provide variants, for example ...
]

#slide(theme-variant: "wake up")[
    ... this one!

    It's very minimalist and helps the audience focus on an important point.
]

#slide(theme-variant: "split 2 v")[
      #box(
        width: auto,
        height: 100%,
        fill: color-a,
    )[
        #image("1080x1920.svg", fit: "stretch")
    ]
][
      #box(
        width: 100%,
        height: 100%,
        inset: 2em,
        fill: color-a,
    )[
        #align(center + horizon, text(fill: white)[
            Or a split slide with some content on the left and some on the
            right...
        ])
    ]
]

#slide(theme-variant: "split 2 v")[
      #box(
        width: 100%,
        height: 100%,
        inset: 2em,
        fill: color-a,
    )[
        #align(center + horizon, text(fill: white)[
            Or on the other direction...
        ])
    ]
][
      #box(
        width: auto,
        height: 100%,
        fill: color-a,
    )[
        #image("1080x1920.svg", fit: "stretch")
    ]
]

#slide(theme-variant: "split 2 h")[
      #box(
        width: 100%,
        height: 100%,
        fill: color-a,
    )[
      #align(center + horizon, text(fill: white)[
        Or even some content on the top...
      ])
    ]
][
    #box(
        width: 100%,
        height: 100%,
        fill: color-b,
    )[
        #align(center + horizon, text(fill: white)[
            ...and some in the bottom!
        ])
    ]
]
#slide(theme-variant: "four split")[
    #box(
        width: 100%,
        height: 100%,
        fill: color-a,
    )[
        #text(fill: white)[Or even...]
    ]
][
    #box(
        width: 100%,
        height: 100%,
        fill: color-c,
    )[
        #text(fill: white)[...some]
    ]
][
    #box(
        width: 100%,
        height: 100%,
        fill: color-c,
    )[
        #text(fill: white)[...other]
    ]
][
    #box(
        width: 100%,
        height: 100%,
        fill: color-b,
    )[
        #text(fill: white)[...fantasies]
    ]
]

#slide(title: "Your own theme?")[
    If you want to create your own design for slides, you can define custom
    themes!

    #link("https://andreaskroepelin.github.io/typst-slides/book/themes.html#create-your-own-theme")[The book]
    explains how to do so.
]

#new-section("Conclusion")

#slide(title: "That's it!")[
    Hopefully you now have some kind of idea what you can do with this template.

    Consider giving it
    #link("https://github.com/andreasKroepelin/typst-slides")[a GitHub star #text(font: "OpenMoji")[#emoji.star]]
    or open an issue if you run into bugs or have feature requests.
]