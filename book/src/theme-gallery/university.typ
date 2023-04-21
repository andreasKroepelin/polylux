#import "../../../slides.typ": *
#import "../../../themes/university.typ": *

#let color-a = rgb("#0C6291")
#let color-b = rgb("#A63446")
#let color-c = rgb("#AAAAAA")

#show: slides.with(
    authors: "Andreas Kröpelin",
    short-authors: "A. Kröpelin",
    title: [`typst-slides`: Easily creating slides in Typst ],
    subtitle: "An overview over all the features",
    short-title: "Slides template demo",
    date: "April 2023",
    theme: university-theme(
        institution-name: "UniversityName",
        logo: image("300x200.svg", width: 60mm)
    )
)

#new-section("Themes")

#slide(title: "How a simple slide looks...")[
    ... is defined by the _theme_ of the presentation.

    This demo uses the `university` theme.

    Because of it, the title slide and the decoration on each slide (with
    section name, short title, slide number etc.) look the way they do.
]

#slide(title: "How another simple slide looks...")[
    When providing multiple bodies, the slide will be automaticalled divided in
    columns of the same size by default...
][
    However, you can specify the columns size by providing the `columns`
    parameter. The `columns` parameter behave just like the `columns` parameter
    of the `grid`. Please refer to the official documentation to learn how to
    use it.
]

#slide[
    This slide is without `title`, just in time to introduce the theme variants...
]

#new-section("Variants")

#slide(theme-variant: "wake up", color: color-b)[
    This one is very minimalist and helps the audience focus on an important point.
]

#slide(theme-variant: "split v", columns: 2)[
    #box(
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

#slide(theme-variant: "split v", columns: 2)[
    #box(
        width: 100%,
        height: 100%,
        inset: 2em,
        fill: color-b,
    )[
        #align(center + horizon, text(fill: white)[
            Or on the other direction...
        ])
    ]
][
    #box(
        height: 100%,
        fill: color-c,
    )[
        #image("1080x1920.svg", fit: "stretch")
    ]
]

#slide(theme-variant: "split h")[
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
        #set align(center + horizon)
        #text(fill: white)[Or even...]
    ]
][
    #box(
        width: 100%,
        height: 100%,
        fill: color-c,
    )[
        #set align(center + horizon)
        #text(fill: white)[...some]
    ]
][
    #box(
        width: 100%,
        height: 100%,
        fill: color-c,
    )[
        #set align(center + horizon)
        #text(fill: white)[...other]
    ]
][
    #box(
        width: 100%,
        height: 100%,
        fill: color-b,
    )[
        #set align(center + horizon)
        #text(fill: white)[...fantasies]
    ]
]
