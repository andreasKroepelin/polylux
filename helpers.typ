#import "logic.typ"

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

#let polylux-progress(ratio-to-content) = locate( loc => {
  let ratio = logic.logical-slide.at(loc).first() / logic.logical-slide.final(loc).first()
  ratio-to-content(ratio)
})

#let last-slide-number = locate(loc => logic.logical-slide.final(loc).first())