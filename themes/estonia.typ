// This theme is inspired by the flag of Estonia

// Consider using:
// #set text(font: "Fira Sans", size: 20pt)
// #show math.equation: set text(font: "Fira Math", weight: "regular")
// #set strong(delta: 100)
// #set par(justify: true)
// show raw: set text(font: "Inconsolata", weight: "semibold", size: raw-font-size)

#import "../logic.typ"
#import "../utils/utils.typ"

#let est-blue = rgb("#0072ce")

#let est-cell = block.with(
  width: 100%,
  height: 100%,
  above: 0pt,
  below: 0pt,
  breakable: false
)

#let est-progress-bar(
  width,
  height,
  inset: 1cm,
  show-slide-number: true,
  bg-color: black,
  text-size: 0.8em,
  alignment: horizon,
  before-slide: loc => {circle(radius: .075em, fill: white.darken(50%))},
  current-slide: loc => {circle(radius: .15em, fill: white)},
  after-slide: loc => {circle(radius: .075em, fill: white.darken(50%))},
  slide-number: loc => {block(width: 1em, align(right, text(fill:white, logic.logical-slide.display())))}
) = {
  show: est-cell.with(
    fill: bg-color,
    width: width,
    height: height,
    inset: inset,
  )

  set text(size: text-size)
  set align(alignment)
  locate(loc => {
    let current_circle = logic.logical-slide.at(loc).first() - 1
    let nb_circles = logic.logical-slide.final(loc).first()

    let circles = range(nb_circles).map(x => {
      if x < current_circle { before-slide(loc) }
      else if x == current_circle { current-slide(loc) }
      else { after-slide(loc) }
    })

    if show-slide-number { grid(
      columns: nb_circles + 1,
      gutter: 1fr,
      ..circles,
      slide-number(loc)
    )} else { grid(
      columns: nb_circles,
      gutter: 1fr,
      ..circles
    )}
  })
}

#let est-title-bar(
  title,
  width,
  height,
  bg-color: est-blue,
  inset: 1cm,
  alignment: left+horizon,
  text-fill-color: white,
  text-size: 1.2em,
) = {
  show: est-cell.with(
    width: width,
    height: height,
    fill: bg-color,
    inset: inset,
  )

  set align(alignment)
  set text(fill: text-fill-color, size: text-size)
  if title != none {title} else []
}

#let est-speaker-slide-reminder-bar(
  width,
  height,
  show-slide-number: false,
  text-size: .8em,
  alignment: center+horizon,
  author-text-fill-color: white,
  author-bg-color: black,
  presentation-title-text-fill-color: white,
  presentation-title-bg-color: est-blue,
  slide-number-text-fill-color: black,
  slide-number-bg-color: white,
  author: [Speaker],
  presentation-title: [Presentation title],
  slide-number: {logic.logical-slide.display()}
) = {
  set text(size: text-size)
  set align(alignment)

  let contents = (
    block(fill: author-bg-color, width: 100%, height: height, text(fill: author-text-fill-color, author)),
    block(fill: presentation-title-bg-color, width: 100%, height: height, text(fill: presentation-title-text-fill-color, presentation-title)),
    block(fill: slide-number-bg-color, width:100%, height: height, text(fill: slide-number-text-fill-color, slide-number)),
  )

  block(width:100%, height: height, breakable:false, {
    if show-slide-number {
      grid(columns: (width * 30%, width * 65%, width * 5%), gutter: 0cm,
        ..contents
      )
    } else {
      grid(columns: (width * 30%, width * 70%), gutter: 0cm,
        ..contents.slice(0, 2)
      )
    }
  })
}

#let estonia-theme(
  aspect-ratio: "16-9",
  body
) = {
  set page(
    paper: "presentation-" + aspect-ratio,
    margin: 0cm,
    header: none,
    footer: none,
  )

  body
}

#let slide(
  title: none,
  title-bar: auto,
  title-bar-args: (
    height-per-line: 1.5em,
    func: est-title-bar,
    func-args: (:),
  ),
  progress-bar: true,
  progress-bar-args: (
    height: 1em,
    func: est-progress-bar,
    func-args: (:),
  ),
  bottom-bar: false,
  bottom-bar-args: (
    height: 6mm,
    func: est-speaker-slide-reminder-bar,
    func-args: (:)
  ),
  body-args: (
    margin: 1cm,
    alignment: left+horizon,
    text-fill-color: black,
    bg-color: white),
  body
) = {
  let show_progress_bar = progress-bar
  let show_title_bar = if title-bar == auto {title != none} else { title-bar }
  let show_bottom_bar = bottom-bar

  let margin-value(name, margin) = {
    if type(margin) == "length" { margin }
    else if type(margin) == "dictionary" {
      let val = margin.at(name, default: "unset")
      if val != "unset" { val } else {
        let rest = margin.at("rest", default: "unset")
        if rest != "unset" { rest } else { panic("bad body-margin: should define all top/bottom/left/right keys or define a rest key") }
      }
    } else { panic("body-margin should be a length or a dictionary") }
  }

  let body-margin = body-args.at("margin", default: 1cm)
  let body-margin-top = margin-value("top", body-margin)
  let body-margin-bottom = margin-value("bottom", body-margin)
  let body-margin-left = margin-value("left", body-margin)
  let body-margin-right = margin-value("right", body-margin)

  let titles_nb_lines = if title == none {1} else { title.split("\n").len()}
  let progress_bar_height = if progress-bar {progress-bar-args.at("height", default: 1em)} else {0em}
  let title_bar_height = if show_title_bar {titles_nb_lines * title-bar-args.at("height-per-line", default: 1.5em)} else {0em}

  let header_bars_height = progress_bar_height + title_bar_height
  let top_margin = header_bars_height + body-margin-top

  let bottom_bar_height = if bottom-bar != false {bottom-bar-args.at("height", default: 6mm)} else {0em}
  let footer_bars_height = bottom_bar_height
  let bottom_margin = footer_bars_height + body-margin-bottom

  set page(
    header: none,
    footer: none,
    margin: (
      top: top_margin,
      bottom: bottom_margin,
      left: body-margin-left,
      right: body-margin-right,
    ),
    fill: body-args.at("bg-color", default: white),
  )

  let page_width = body-margin-left + 100% + body-margin-right

  let content = {
    if show_progress_bar { place(top+left, dx: -body-margin-left, dy: -top_margin, {
      progress-bar-args.at("func", default: est-progress-bar)(
        page_width,
        progress_bar_height,
        ..progress-bar-args.at("func-args", default: (:))
      )
    })}
    if show_title_bar { place(top+left, dx: -body-margin-left, dy: -top_margin + progress_bar_height, {
      title-bar-args.at("func", default: est-title-bar)(
        title,
        page_width,
        title_bar_height,
        ..title-bar-args.at("func-args", default: (:))
      )
    })}
    if show_bottom_bar { place(top+left,
                               dx: -body-margin-left,
                               dy: -top_margin + header_bars_height + body-margin-top + 100% + body-margin-bottom, {
      bottom-bar-args.at("func", default: est-speaker-slide-reminder-bar)(
        page_width,
        bottom_bar_height,
        ..bottom-bar-args.at("func-args", default: (:))
      )
    })}

    set align(body-args.at("alignment", default: left+horizon))
    set text(fill: body-args.at("text-fill-color", default: black))
    body
  }

  logic.polylux-slide(content)
}

#let estonia-outline = {
  utils.polylux-outline(enum-args: (tight: false,))
}
