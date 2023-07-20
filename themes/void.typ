#import "../slides.typ": logical-slide

#let void-theme(text-color: black, background-color: white) = data => {

  let color-setup(body) = {
    set text(fill: text-color)
    block(
      width: 100%, height: 100%, inset: 2em, clip: true, fill: background-color,
      body
    )
  }
  
  let title-slide(slide-info, bodies) = {
    if bodies.len() != 0 {
        panic("title slide of void theme does not support any bodies")
    }
    show: color-setup

    align(start+horizon, {
      heading(level: 1, data.title)
      v(1em)
      heading(level: 3, data.subtitle)
      v(1.5em)
      text(size: .7em, {
        data.authors.join(", ")
        linebreak()
        data.date
      })
    })
    
  }

  let default(slide-info, bodies) = {
    show: color-setup

    if "title" in slide-info {
      heading(level: 2, slide-info.title)

    }
    v(1fr)
    grid(
      columns: (1fr,) * bodies.len(),
      column-gutter: 1em,
      ..bodies
    )
    v(2fr)
    
    if "number" not in slide-info or slide-info.number {
      align(right, text(size: 10pt, fill: text-color.lighten(50%), logical-slide.display()))
    }
  }

  ( "title slide": title-slide, "default": default )
}
