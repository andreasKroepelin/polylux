#import "../slides.typ": *

#show: slides.with(
    data : data(  
    author: [Astrale],
    short-author: "J.D",
    title: [A visualisation of the inner values of slides.],
    short-title: "",
    date: [March 2023],
    ),
    theme : base_theme(
      color : red,
      margin: ( x: 1em, y: 4.5em ),
      footer-descent : 3em,
      footer: (data, current-slide) => locate( loc => {
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
        stroke: (top: 1mm + red),
        width: 100%,
        inset: .3em,
        place(right + horizon,rect(inset: .3em, stroke: 1mm, value)) 
      )}
})))

== A slide
Some text

== Another slide
More text

#slide[
  We do not need a special heading here.
  == But we can ...
  ... and it doesn't produce new slides here.
]
