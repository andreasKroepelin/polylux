#import "logic.typ"

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

      let mutable-height = get-pts(height, "h")
      let size = measure(boxed-content, styles)
      let h-ratio = mutable-height / size.height
      let w-ratio = mutable-width / size.width
      let ratio = calc.min(h-ratio, w-ratio) * 100%

      // If not boxed, the content can overflow to the next page even though it will fit.
      // This is because scale doesn't update the layout information.
      // Boxing in a container without clipping will inform typst that content
      // will indeed fit in the remaining space
      let new-width = size.width * ratio
      box(
        width: new-width,
        height: mutable-height,
        scale(x: ratio, y: ratio, origin: top + left, boxed-content)
      )
    })
  })
}

#let fill-remaining-height(
  margin: 0%,
  content,
  ..fit-kwargs
) = {
  // Place a label that can be queried below to know exactly where to start placing this
  // content, and how much remaining space is available. The label must be attached to 
  // content, so we use a show rule that doesn't display anything as the anchor.
  let before-label = label("fit-remaining-marker")
  [
    #show before-label: []
    this-will-be-hidden#before-label
  ]
  locate(loc => {
    let prev = query(selector(before-label).before(loc), loc)
    let prev-pos = prev.last().location().position()
    layout(container-size => {
      style(styles => {
        let mutable-margin = _size-to-pt(margin, styles, container-size.height)
        let available-height = container-size.height - prev-pos.y - mutable-margin

        fit-to-height(available-height, ..fit-kwargs, content)
      })
    })
  })
}

