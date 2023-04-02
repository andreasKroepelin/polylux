#import "../slides.typ": *

#let example-theme = make_theme(
      color : red,
      header: (..args) => [],
      footer: (data, theme, current-slide) => locate( loc => {
            if counter(page).at(loc).first() > 1 {
                block(
                    stroke: (top:  1mm + teal),
                    width: 100%,
                    inset: .3em,
                    text(.5em)[
                    #data.short-author #h(10fr)
                    #data.short-title #h(1fr)
                    #data.date #h(10fr)
                    #current-slide.logical-slide.display()
                ])
                
            }
        } ),
)

#show: slides.with(
    data : data(
    author: [Joan Doe],
    short-author: "J.D",
    title: [A showcase of what #strike[beamer] themes can accomplish.],
    short-title: "Shorter version for slide footer",
    date: [March 2023],
    ),
    theme :example-theme
  )

== A slide
Some text

== Another slide
More text

#slide(theme : make_theme())[
Theme override for this slide only
]

== Another normal slide