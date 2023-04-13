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

    #uncover(2)[
        $ limits(integral)_(-oo)^oo exp(-(mu - x)^2 / (2 sigma^2) ) dif x = sqrt(2 pi sigma^2) $
    ]

    #uncover("-3")[Hurry reading this, it disappears after subslide 3!]

    #uncover("4-")[Huh, pretty empty here #sym.dots.h]
]

#slide(title: "A multislide with list items appearing one by one")[

    #set enum(numbering: "i)")
    #grid(
        columns: (1fr, 1fr, 1fr),
        gutter: 1em,
        one-by-one[- abc][- def][- ghi],
        one-by-one(start: 2)[1. jkl][2. mno][3. pqr],
        one-by-one(start: 3)[stu][ #sym.dot.c vwx][ #sym.dot.c yza],
    )
]

#slide(title: "Non occupying hidden content")[
    #only(1)[two]
    #only(2)[three]
    #only(3)[four]
    apples
]

#slide(title: "Alternatives")[
    #alternatives(position: right)[two][three][four] bananas

    #alternatives(position: right)[$pi$][$sqrt(2)$][$1/2$]
    is
    #alternatives(position: center)[irrational][irrational][rational]
    and
    #alternatives(position: center)[transcendent][algebraic][algebraic].
]

#slide(title: "Simpler lists")[
    #line-by-line[
        - abc
        - def
        - ghi
        - jkl
    ]

    #line-by-line(start: 2)[
        two
        things
    ]
]

#slide(title: "Complex uncover rules")[
    #box(
        ```typ
        #uncover("1, 3-5, 8-")[blink]
        ```
    )
    produces
    #uncover("1, 3-5, 8-")[blink]
    on subslide
    #alternatives(..range(1, 10).map(str))
]

#slide(title: "Pauses")[
    Some text.
    #pause
    More text.

    1. abc
    #pause
    2. def
    #pause
    3. ghi
]
