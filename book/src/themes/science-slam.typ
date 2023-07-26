#import "../../../polylux.typ": *

// ANCHOR: init
#let science-slam-theme(aspect-ratio: "16-9", darkness: "dark", body) = {
  let background-color = if darkness == "dark" {
    navy
  } else if darkness == "very dark" {
    navy.darken(50%)
  } else if darkness == "ultra dark" {
    black
  } else {
    panic("illegal darkness, must be one of dark, very dark, ultra dark")
  }

  set page(
    paper: "presentation-" + aspect-ratio,
    fill: background-color,
  )
  set text(fill: white.darken(10%), size: 40pt, font: "Fira Sans")

  body
}
// ANCHOR_END: init

// ANCHOR: title-slide
#let title-slide(title: [], author: []) = {
  polylux-slide({
    set align(center + horizon)
    smallcaps(strong(title))
    parbreak()
    text(size: .7em, author)
  })
}
// ANCHOR_END: title-slide

// ANCHOR: slide
#let slide(title: [], body) = {
  polylux-slide({
    strong(title)
    set align(horizon)
    body
  })
}
// ANCHOR_END: slide

// ANCHOR: use-init
#show: science-slam-theme.with(darkness: "very dark")
// ANCHOR_END: use-init

// ANCHOR: use-title-slide
#title-slide(title: [My awesome topic], author: [A really funny guy])
// ANCHOR_END: use-title-slide

// ANCHOR: use-slide
#slide(title: "A hilarious slide")[
  You didn't expect that!
]
// ANCHOR_END: use-slide

