// This theme is inspired by https://github.com/matze/mtheme
// The polylux-port was performed by https://github.com/Enivex

// Consider using:
// #set text(font: "Fira Sans", weight: "light", size: 20pt)
// #show math.equation: set text(font: "Fira Math")
// #set strong(delta: 100)
// #set par(justify: true)

#import "../logic.typ"

#let m-dark-teal = rgb("#23373b")
#let m-light-brown = rgb("#eb811b")
#let m-lighter-brown = rgb("#d6c6b7")
#let m-extra-light-gray = white.darken(2%)

#let m-sections = state("m-sections", ())
#let m-footer = state("m-footer", [])

#let m-cell = block.with(
  width: 100%,
  height: 100%,
  above: 0pt,
  below: 0pt,
  breakable: false
)

#let m-progress-bar = locate(loc => {
  let filled = logic.logical-slide.at(loc).first() / logic.logical-slide.final(loc).first() * 100%
  grid(columns: (filled, 1fr), m-cell(fill: m-light-brown), m-cell(fill: m-lighter-brown))
})

#let metropolis-theme(
  aspect-ratio: "16-9",
  footer: [],
  body
) = {
  set page(
    paper: "presentation-" + aspect-ratio,
    margin: 0em,
    header: none,
    footer: none,
  )

  m-footer.update(footer)

  body
}

#let title-slide(
  title: [],
  subtitle: none,
  author: none,
  date: none,
  extra: none,
) = {
  let content = {
    set text(fill: m-dark-teal)
    set align(horizon)
    block(width: 100%, inset: 2em, {
      text(size: 1.3em, strong(title))
      if subtitle != none {
        linebreak()
        text(size: 0.9em, subtitle)
      }
      line(length: 100%, stroke: .05em + m-light-brown)
      set text(size: .8em)
      if author != none {
        block(spacing: 1em, author)
      }
      if date != none {
        block(spacing: 1em, date)
      }
      set text(size: .8em)
      if extra != none {
        block(spacing: 1em, extra)
      }
    
    })
  }

  logic.polylux-slide(content)
}

#let slide(title: none, body) = {
  let header = {
    set align(top)
    if title != none {
      show: m-cell.with(fill: m-dark-teal, inset: 1em)
      set align(horizon)
      set text(fill: m-extra-light-gray, size: 1.2em)
      strong(title)
    } else { [] }
  }

  let footer = {
    set text(size: 0.8em)
    show: pad.with(.5em)
    set align(bottom)
    text(fill: m-dark-teal.lighten(40%), m-footer.display())
    h(1fr)
    text(fill: m-dark-teal, logic.logical-slide.display())
  }

  set page(
    header: header,
    footer: footer,
    margin: (top: 3em, bottom: 1em),
    fill: m-extra-light-gray,
  )

  let content = {
    show: align.with(horizon)
    show: pad.with(2em)
    set text(fill: m-dark-teal)
    body 
  }

  logic.polylux-slide(content)
}

#let new-section-slide(name) = {
  let content = {
    locate( loc => {
      m-sections.update(sections => {
        sections.push((body: name, loc: loc))
        sections
      })
    })
    set align(horizon)
    show: pad.with(20%)
    set text(size: 1.5em)
    name
    block(height: 2pt, width: 100%, spacing: 0pt, m-progress-bar)
  }
  logic.polylux-slide(content)
}

#let focus-slide(body) = {
  set page(fill: m-dark-teal, margin: 2em)
  set text(fill: m-extra-light-gray, size: 1.5em)
  logic.polylux-slide(align(horizon + center, body))
}

#let alert = text.with(fill: m-light-brown)

#let metropolis-outline = locate( loc => {
  let sections = m-sections.final(loc)
  for section in sections [
    + #link(section.loc, section.body)

  ]
})
