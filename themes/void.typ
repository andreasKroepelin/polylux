#import "../slides.typ": logical-slide

#let void-theme(dark: false) = data => {
  let my-dark = rgb(20, 20, 20)
  let my-bright = rgb(250, 250, 250)
  let my-in-between = rgb(120, 120, 120)

  let color-setup(body) = {
    let fg-color = if dark { my-bright } else { my-dark }
    let bg-color = if dark { my-dark } else { my-bright }

    set text(fill: fg-color)
    block(
      width: 100%, height: 100%, inset: 2em, clip: true, fill: bg-color,
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

    heading(level: 2, slide-info.title)

    v(1fr)
    grid(
      columns: (1fr,) * bodies.len(),
      column-gutter: 1em,
      ..bodies
    )
    v(2fr)
    
    align(right, text(size: 10pt, fill: my-in-between, logical-slide.display()))
  }

  ( "title slide": title-slide, "default": default )
}
