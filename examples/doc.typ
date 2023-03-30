#import "../slides.typ": *    

#set text(
    font: "DejaVu Sans",
)

#show: slides.with(
    data : data(
    author: "Jon Doe and Jane Doe",
    short-author: "J+J Doe",
    title: "Demonstration of a new Typst template for slides",
    short-title: "Slides template demo",
    date: "March 2023"
    )
)

= Introduction

== First Slide
#lorem(10)

== Second slide
#lorem(10)

= Multislides

#slide[
    == A multislide
    Note how the page number does not increase while we are here.

    #only(2)[
        $ integral exp(-(mu - x)^2 / (2 sigma^2) ) dif x $
    ]

    #until(3)[Hurry reading this, it disappears after subslide 3!]

    // #beginning(4)[Huh, pretty empty here #sym.dots.h]
]

#slide[
    == A multislide with list items appearing one by one

    #grid(
        columns: (1fr, 1fr),
        gutter: 1em,
        one-by-one[- abc][- def][- ghi],
        one-by-one(start: 2)[1. jkl][2. mno][3. pqr],
    )
]
