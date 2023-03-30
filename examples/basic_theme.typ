#import "../slides.typ": *

#show: slides.with(
    author: "Names of author(s)",
    short-author: "Shorter version for slide footer",
    title: "Title of the presentation",
    short-title: "Shorter version for slide footer",
    date: "March 2023",
    theme : base_theme(
      color : red,
      decoration : (position, body, color : red) => {
        let border = 2mm
        let strokes = (
            header: ( bottom: border ),
            footer: ( top: border )
        )
        block(
            stroke: strokes.at(position),
            width: 100%,
            inset: .3em,
            text(.5em, body)
        )},
        margin: ( x: 1em, y: 4.5em ),
        footer-descent : 3em,
            footer: (decoration, section, short-author, short-title, date, logical-slide) => locate( loc => {
            if counter(page).at(loc).first() > 1 {
              rect(width: 100%, inset: .3em,)
//                decoration("footer")[
//                    #short-author #h(10fr)
//                    #short-title #h(1fr)
//                    #date #h(10fr)
//                    #logical-slide.display()
//                ]
            }
        } ),

    )
)

== A slide
Some text

== Another slide
More text

#slide[
  We do not need a special heading here.
  == But we can ...
  ... and it doesn't produce new slides here.
]
