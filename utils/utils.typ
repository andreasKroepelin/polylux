#import "../logic.typ"

#import "pdfpc.typ"

// SECTIONS

#let sections-state = state("polylux-sections", ())
#let register-section(name) = locate( loc => {
  sections-state.update(sections => {
    sections.push((body: name, loc: loc))
    sections
  })
})

#let current-section = locate( loc => {
  let sections = sections-state.at(loc)
  if sections.len() > 0 {
    sections.last().body
  } else {
    []
  }
})

#let polylux-outline(enum-args: (:), padding: 0pt) = locate( loc => {
  let sections = sections-state.final(loc)
  pad(padding, enum(
    ..enum-args,
    ..sections.map(section => link(section.loc, section.body))
  ))
})


// PROGRESS

#let polylux-progress(ratio-to-content) = locate( loc => {
  let ratio = logic.logical-slide.at(loc).first() / logic.logical-slide.final(loc).first()
  ratio-to-content(ratio)
})

#let last-slide-number = locate(loc => logic.logical-slide.final(loc).first())


// HEIGHT FITTING

#let _size-to-pt(size, styles, container-dimension) = {
  let to-convert = size
  if type(size) == "ratio" {
    to-convert = container-dimension * size
  }
  measure(v(to-convert), styles).height
}

#let _limit-content-width(width: none, body, container-size, styles) = {
  let mutable-width = width
  if width == none {
    mutable-width = calc.min(container-size.width, measure(body, styles).width)
  } else {
    mutable-width = _size-to-pt(width, styles, container-size.width)
  }
  box(width: mutable-width, body)
}

#let fit-to-height(height, width: none, prescale-width: none, body) = {
  // Place two labels with the requested vertical separation to be able to
  // measure their vertical distance in pt.
  // Using this approach instead of using `measure` allows us to accept fractions
  // like `1fr` as well.
  // The label must be attached to content, so we use a show rule that doesn't
  // display anything as the anchor.
  let before-label = label("polylux-fit-height-before")
  let after-label = label("polylux-fit-height-after")
  [
    #show before-label: none
    #show after-label: none
    #v(1em)
    hidden#before-label
    #v(height)
    hidden#after-label
  ]

  locate(loc => {
    let before = query(selector(before-label).before(loc), loc)
    let before-pos = before.last().location().position()
    let after = query(selector(after-label).before(loc), loc)
    let after-pos = after.last().location().position()

    let available-height = after-pos.y - before-pos.y

    style(styles => {
      layout(container-size => {
        // Helper function to more easily grab absolute units
        let get-pts(body, w-or-h) = {
          let dim = if w-or-h == "w" {container-size.width} else {container-size.height}
          _size-to-pt(body, styles, dim)
        }

        // Provide a sensible initial width, which will define initial scale parameters.
        // Note this is different from the post-scale width, which is a limiting factor
        // on the allowable scaling ratio
        let boxed-content = _limit-content-width(
          width: prescale-width, body, container-size, styles
        )

        // post-scaling width
        let mutable-width = width
        if width == none {
          mutable-width = container-size.width
        }
        mutable-width = get-pts(mutable-width, "w")

        let size = measure(boxed-content, styles)
        let h-ratio = available-height / size.height
        let w-ratio = mutable-width / size.width
        let ratio = calc.min(h-ratio, w-ratio) * 100%

        let new-width = size.width * ratio
        v(-available-height)
        // If not boxed, the content can overflow to the next page even though it will fit.
        // This is because scale doesn't update the layout information.
        // Boxing in a container without clipping will inform typst that content
        // will indeed fit in the remaining space
        box(
          width: new-width,
          height: available-height,
          scale(x: ratio, y: ratio, origin: top + left, boxed-content)
        )
      })
    })
  })
}

// SIDE BY SIDE

#let side-by-side(columns: none, gutter: 1em, ..bodies) = {
  let bodies = bodies.pos()
  let columns = if columns ==  none { (1fr,) * bodies.len() } else { columns }
  if columns.len() != bodies.len() {
    panic("number of columns must match number of content arguments")
  }

  grid(columns: columns, gutter: gutter, ..bodies)
}
