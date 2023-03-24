#import "../slides.typ": *    

#set text(
    font: "DejaVu Sans",
)

#show: slides.with(
    author: "Jon Doe and Jane Doe",
    short-author: "J+J Doe",
    title: "Demonstration of a new Typst template for slides",
    short-title: "Slides template demo",
    date: "March 2023"
)

= Introduction

== First Slide
#lorem(10)

== Second slide
#lorem(10)

= Multislides

#multislide(5, tools => [
    == A multislide
    This slide consists of #tools.amount subslides.
    Note how the page number does not increase while we are here.

    #(tools.only-first)[This is only visible on the first subslide.]

    #(tools.until)(3)[Hurry reading this, it disappears after subslide 3!]

    #(tools.beginning)(4)[Huh, pretty empty here #sym.dots.h]
])

#multislide(4, mode: "mute", tools => [
    == A multislide with list items appearing one by one

    #grid(
        columns: (1fr, 1fr),
        gutter: 1em,
        (tools.one-by-one-list)[abc][def][ghi],
        (tools.one-by-one-enum)(start: 2)[jkl][mno][pqr],
    )

    This slide also demonstrates a variant for "hidden" text: `mode: "mute"`.
])
