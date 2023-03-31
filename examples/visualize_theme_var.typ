#import "../slides.typ": *

#let theme_visualise = make_theme(
      title-slide : (theme, data) => [
        #align(center + top)[
          This is a title slide for blank visualisation purposes.
          
          title : #data.title\
          short-title : #data.short-title\
          short-author : #data.short-author\
          date : #data.date\
          ]
      ],
      color : red,
      margin: ( x: 1em, y: 4.5em ),
      footer-descent : 3em,
      header: (x,theme,y) => [],
      footer: (data, theme, current-slide) => locate( loc => {
      if counter(page).at(loc).first() > 1 {
      let value = []
      if current-slide.section.at(loc) != none {
        value += [section : #current-slide.section.at(loc)]
      }
      if current-slide.logical-slide.at(loc) != none {
        value += [logical-slide : #current-slide.logical-slide.at(loc)]
      }
      if current-slide.subslide.at(loc) != none {
        value += [subslide : #current-slide.subslide.at(loc)]
      }
      block(
        stroke : (top : 1mm),
        width: 100%,
        inset: .3em,
        place(left + horizon, value) 
      )}
}))


#show: slides.with(
    data : data(  
    author: [Astrale],
    short-author: "J.D",
    title: [A visualisation of the inner values of slides.],
    short-title: "visualisation",
    date: [March 2023],
    ),
    theme : theme_visualise
)

== A slide
Some text

== Another slide
More text

#slide(theme : make_theme())[You can override the theme for only one slide]


= Multislides

#slide[
    == A multislide
    Multislide

    #only(2)[
        Only 2
    ]

    #until(3)[Until 3]

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