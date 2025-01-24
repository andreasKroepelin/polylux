#import "../../../src/polylux.typ": *
#set page(paper: "presentation-16-9")
#set text(size: 50pt, font: "Atkinson Hyperlegible")

#let my-new-section(name) = slide[
  #set align(horizon)
  #set text(size: 2em)
  #toolbox.register-section(name)

  #strong(name)
]

#slide[
  #toolbox.all-sections((sections, current) => {
    enum(..sections)
  })
]

#my-new-section[The beginning]

#slide[
  We are currently in Section "#toolbox.current-section" and I like it so far.
]

#slide[
  Still in the same section.
]

#my-new-section[The middle]

#slide[
  Oh, new section. What comes after "#toolbox.current-section"?
]

#my-new-section[The end]

#slide[
  You might have guessed this, to be honest.
]
