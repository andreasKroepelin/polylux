#import "../slides.typ": *

#let my-easy-layout = layout-tools.builder((
  "title slide": (
    required-bodies: (exactly: 0),
    layout: (
      mod: layout-tools.aligner(center + horizon),
      chidren: (
        ( heading.with(level: 1), "title" ),
        "authors",
        1em,
        ( text.with(size: .8em), "date" ),
      )
    )
  )

))

#let my-layout(data) = (
  "title slide": (slide-info, bodies) => {
    layout-tools.require-bodies(exactly: 0, name: "title slide", bodies)
    layout-tools.full-block(
      background: gray.lighten(50%),
      children-align: center + horizon,
      dir: ttb,

      [= #data.title],
      layout-tools.authors-list(data.authors),
      1em,
      text(.8em, data.date),
    )
  },

  "default": (slide-info, bodies) => {
    layout-tools.require-bodies(min: 1, name: "default", bodies)
    layout-tools.full-block(
      inset: 0pt,

      // layout-tools.wide-block(
        // inset: .5em,
        // dir: ltr,
        text(.5em, section.display()),
      // ),
      
      layout-tools.wide-block(
        [== #slide-info.title],
        1fr,
        layout-tools.tall-block(inset: (x: 0pt, y: 1em), dir: ltr, ..bodies),
        2fr,
      )
    )
  }
)

#show: slides.with(
  authors: "Author",
  title: "My own layout",
  date: "today",
  theme: my-layout
)

#slide(theme-variant: "title slide")

#new-section("My section")

#slide(title: "My title")[
  #lorem(30)
][
  #lorem(15)
]
