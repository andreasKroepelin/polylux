#import "../slides.typ": *    

#set text(
    font: "DejaVu Sans",
)

#show: slides.with(
    authors: ("John Doe", "Jane Doe"),
    short-authors: "J+J Doe",
    title: "Demonstration of a new Typst template for slides",
    short-title: "Slides template demo",
    date: "March 2023"
)

#new-section("Introduction")

#slide(title: "First slide")[
    #lorem(10)
]

#slide[
    Second slide, without a title

    #lorem(10)
]

#new-section("Multislides")

#slide(title: "A multislide")[
    Note how the page number does not increase while we are here.

    #only(2)[
        $ limits(integral)_(-oo)^oo exp(-(mu - x)^2 / (2 sigma^2) ) dif x = sqrt(2 pi sigma^2) $
    ]

    #until(3)[Hurry reading this, it disappears after subslide 3!]

    #beginning(4)[Huh, pretty empty here #sym.dots.h]
]

#slide(title: "A multislide with list items appearing one by one")[

    #grid(
        columns: (1fr, 1fr, 1fr),
        gutter: 1em,
        one-by-one[- abc][- def][- ghi],
        one-by-one(start: 2)[1. jkl][2. mno][3. pqr],
        one-by-one(start: 3)[stu][ #sym.dot.c vwx][ #sym.dot.c yza],
    )
]

#slide(title: "Non occupying hidden content")[
    #only-non-occupying(1)[two]
    #only-non-occupying(2)[three]
    #only-non-occupying(3)[four]
    apples
]

#slide(title: "Alternatives")[
    #alternatives[two][three][four] bananas

    #alternatives[$pi$][$sqrt(2)$][$1/2$]
    is
    #alternatives[irrational][irrational][rational]
    and
    #alternatives[transcendent][algebraic][algebraic].
]

#let obo-list(body) = {
    if repr(body.func()) != "sequence" {
        panic("expected a sequence!")
    }

    // panic(body.children.map(c => repr(c.func())).join(" "))

    let items = body.children.filter(
        c => repr(c.func()) != "space"
    )

    enum(
        ..items.enumerate().map((idx_item) => beginning(idx_item.first() + 1, idx_item.last().body))
    )

    /*
    for (idx, item) in items.enumerate() {
        beginning(idx + 1, item)
    }
    */
}

#slide(title: "Simpler lists")[
    #obo-list[
        + abc def
        + ghi
        + jkl
    ]

    #v(1em)
    #block(width: 100%, fill: teal.lighten(50%), inset: 1em)[
        - hi
        #only(2)[- hello]
    ]

    - one
    #hide[- two]
    - three
]
