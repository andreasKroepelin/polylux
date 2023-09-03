#import "../logic.typ"
#import "../utils/utils.typ"

#let rpd-base = rgb(250, 244, 237)
#let rpd-surface = rgb(255, 250, 243)
#let rpd-overlay = rgb(242, 233, 222)
#let rpd-pine = rgb(40, 105, 131)
#let rpd-subtle = rgb(121, 117, 147)
#let rpd-muted = rgb(152, 147, 165)
#let rpd-text = rgb(87, 82, 121)
#let rpd-highlight-high = rgb(206, 202, 205)
#let rpd-love = rgb(180, 99, 122)
#let rpd-gold = rgb(234, 157, 52)
#let rpd-rose = rgb(215, 130, 126)
#let rpd-iris = rgb(144, 122, 169)
#let rpd-foam = rgb(86, 148, 159)

#let _rpd-footer = state("_rpd-footer", none)

#let rose-pine-dawn-theme(
  aspect-ratio: "16-9",
  footer: none,
  body
) = {
  set page(
    paper: "presentation-" + aspect-ratio,
    fill: rpd-base,
    margin: 1cm,
  )

  _rpd-footer.update(footer)
  
  body
}

#let title-slide(
  title: [],
  subtitle: none,
  author: [],
  extra: none,
) = {
  let body = {
    let sun-radius = 7cm
    let sun-color = color.mix((rpd-rose, 1), (rpd-base, 3))
    place(bottom + right, dx: 0.8 * sun-radius, dy: 0.8 * sun-radius, circle(radius: sun-radius, stroke: none, fill: sun-color))
    // set align(center)
    v(1fr)
    block(
      width: 80%, inset: 1cm, stroke: none, fill: rpd-overlay, radius: 5mm,
      {
        set text(size: 40pt, fill: rpd-text)
        strong(title)
        if subtitle != none {
          parbreak()
          // v(.01em)
          set text(size: 20pt, fill: rpd-subtle, style: "italic")
          subtitle
        }
      }
    )

    v(.5fr)
    set text(size: 25pt, fill: rpd-text)
    pad(left: 1cm, author)

    if author != none {
      parbreak()
      set text(size: 18pt, fill: rpd-subtle)
      pad(left: 1cm, extra)
    }
    v(1fr)
  }

  logic.polylux-slide(body)
}

#let slide(title: none, body) = {
  set text(size: 25pt, fill: rpd-text)
  set page(
    margin: 1cm,
    footer: {
      let sun-radius = 1cm
      let sun-color = color.mix((rpd-rose, 1), (rpd-base, 3))
      utils.polylux-progress(ratio => {
        place(bottom + right, dy: 1cm + (1 - ratio) * sun-radius, circle(radius: sun-radius, stroke: none, fill: sun-color))
      })

      set text(size: 15pt, fill: rpd-muted)
      _rpd-footer.display()
      h(1fr)
      // sym.brace.l
      logic.logical-slide.display()
      // sym.space
      set text(size: 12pt)
      sym.slash
      // sym.space
      utils.last-slide-number
      // sym.brace.r
    }
  )

  let body = {
    if title != none {
      // show heading: set block(inset: (bottom: 2pt), stroke: (bottom: 2pt + _highlight-high))
      show heading: set block(below: 10pt)
      heading(level: 2, title)
      line(length: 50%, stroke: 2pt + rpd-highlight-high)
    }
    v(.1fr)
    body
    v(.2fr)
  }
  logic.polylux-slide(body)
}

#let focus-slide(body) = {
  set page(fill: rpd-pine, margin: (x: 1cm))
  set text(size: 40pt, fill: rpd-surface)

  let body = {
    let sun-radius = 8cm
    let sun-color = rpd-pine.lighten(5%)
    place(bottom + left, dx: -0.7 * sun-radius, dy: sun-radius, circle(radius: sun-radius, stroke: none, fill: sun-color))
    v(.1fr)
    body
    v(.1fr)
  }
  logic.polylux-slide(body)
}

#let alert-love = text.with(fill: rpd-love)
#let alert-gold = text.with(fill: rpd-gold)
#let alert-rose = text.with(fill: rpd-rose)
