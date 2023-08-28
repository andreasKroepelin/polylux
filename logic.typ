#let subslide = counter("subslide")
#let pause-counter = counter("pause-counter")
#let logical-slide = counter("logical-slide")
#let repetitions = counter("repetitions")
#let handout-mode = state("handout-mode", false)

#let enable-handout-mode(flag) = handout-mode.update(flag)

#let _slides-cover(mode, body) = {
  if mode == "invisible" {
    hide(body)
  } else if mode == "transparent" {
    text(gray.lighten(50%), body)
  } else {
    panic("Illegal cover mode: " + mode)
  }
}

#let _parse-subslide-indices(s) = {
  let parts = s.split(",").map(p => p.trim())
  let parse-part(part) = {
    let match-until = part.match(regex("^-([[:digit:]]+)$"))
    let match-beginning = part.match(regex("^([[:digit:]]+)-$"))
    let match-range = part.match(regex("^([[:digit:]]+)-([[:digit:]]+)$"))
    let match-single = part.match(regex("^([[:digit:]]+)$"))
    if match-until != none {
      let parsed = int(match-until.captures.first())
      // assert(parsed > 0, "parsed idx is non-positive")
      ( until: parsed )
    } else if match-beginning != none {
      let parsed = int(match-beginning.captures.first())
      // assert(parsed > 0, "parsed idx is non-positive")
      ( beginning: parsed )
    } else if match-range != none {
      let parsed-first = int(match-range.captures.first())
      let parsed-last = int(match-range.captures.last())
      // assert(parsed-first > 0, "parsed idx is non-positive")
      // assert(parsed-last > 0, "parsed idx is non-positive")
      ( beginning: parsed-first, until: parsed-last )
    } else if match-single != none {
      let parsed = int(match-single.captures.first())
      // assert(parsed > 0, "parsed idx is non-positive")
      parsed
    } else {
      panic("failed to parse visible slide idx:" + part)
    }
  }
  parts.map(parse-part)
}

#let _check-visible(idx, visible-subslides) = {
  if type(visible-subslides) == "integer" {
    idx == visible-subslides
  } else if type(visible-subslides) == "array" {
    visible-subslides.any(s => _check-visible(idx, s))
  } else if type(visible-subslides) == "string" {
    let parts = _parse-subslide-indices(visible-subslides)
    _check-visible(idx, parts)
  } else if type(visible-subslides) == "dictionary" {
    let lower-okay = if "beginning" in visible-subslides {
      visible-subslides.beginning <= idx
    } else {
      true
    }

    let upper-okay = if "until" in visible-subslides {
      visible-subslides.until >= idx
    } else {
      true
    }

    lower-okay and upper-okay
  } else {
    panic("you may only provide a single integer, an array of integers, or a string")
  }
}

#let _last-required-subslide(visible-subslides) = {
  if type(visible-subslides) == "integer" {
    visible-subslides
  } else if type(visible-subslides) == "array" {
    calc.max(..visible-subslides.map(s => _last-required-subslide(s)))
  } else if type(visible-subslides) == "string" {
    let parts = _parse-subslide-indices(visible-subslides)
    _last-required-subslide(parts)
  } else if type(visible-subslides) == "dictionary" {
    let last = 0
    if "beginning" in visible-subslides {
      last = calc.max(last, visible-subslides.beginning)
    }
    if "until" in visible-subslides {
      last = calc.max(last, visible-subslides.until)
    }
    last
  } else {
    panic("you may only provide a single integer, an array of integers, or a string")
  }
}

#let _conditional-display(visible-subslides, reserve-space, mode, body) = {
  locate( loc => {
    let vs = if reserve-space and handout-mode.at(loc) {
      (:)
    } else {
      visible-subslides
    }
    repetitions.update(rep => calc.max(rep, _last-required-subslide(vs)))
    if _check-visible(subslide.at(loc).first(), vs) {
      body
    } else if reserve-space {
      _slides-cover(mode, body)
    }
  })
}

#let uncover(visible-subslides, mode: "invisible", body) = {
  _conditional-display(visible-subslides, true, mode, body)
}

#let only(visible-subslides, body) = {
  _conditional-display(visible-subslides, false, "doesn't even matter", body)
}

#let one-by-one(start: 1, mode: "invisible", ..children) = {
  for (idx, child) in children.pos().enumerate() {
    uncover((beginning: start + idx), mode: mode, child)
  }
}

#let alternatives-match(subslides-contents, position: bottom + left) = {
  let subslides-contents = if type(subslides-contents) == "dictionary" {
    subslides-contents.pairs()
  } else {
    subslides-contents
  }

  let subslides = subslides-contents.map(it => it.first())
  let contents = subslides-contents.map(it => it.last())
  style(styles => {
    let sizes = contents.map(c => measure(c, styles))
    let max-width = calc.max(..sizes.map(sz => sz.width))
    let max-height = calc.max(..sizes.map(sz => sz.height))
    for (subslides, content) in subslides-contents {
      only(subslides, box(
        width: max-width,
        height: max-height,
        align(position, content)
      ))
    }
  })
}

#let alternatives(
  start: 1,
  repeat-last: false,
  ..args
) = {
  let contents = args.pos()
  let kwargs = args.named()
  let subslides = range(start, start + contents.len())
  if repeat-last {
    subslides.last() = (beginning: subslides.last())
  }
  alternatives-match(subslides.zip(contents), ..kwargs)
}

#let alternatives-fn(
  start: 1,
  end: none,
  count: none,
  ..kwargs,
  fn
) = {
  let end = if end == none {
    if count == none {
      panic("You must specify either end or count.")
    } else {
      start + count
    }
  } else {
    end
  }

  let subslides = range(start, end)
  let contents = subslides.map(fn)
  alternatives-match(subslides.zip(contents), ..kwargs.named())
}

#let alternatives-cases(cases, fn, ..kwargs) = {
  let idcs = range(cases.len())
  let contents = idcs.map(fn)
  alternatives-match(cases.zip(contents), ..kwargs.named())
}

#let line-by-line(start: 1, mode: "invisible", body) = {
  let items = if repr(body.func()) == "sequence" {
    body.children
  } else {
    ( body, )
  }

  let idx = start
  for item in items {
    if repr(item.func()) != "space" {
      uncover((beginning: idx), mode: mode, item)
      idx += 1
    } else {
      item
    }
  }
}


#let _items-one-by-one(fn, start: 1, mode: "invisible", ..args) = {
  let kwargs = args.named()
  let items = args.pos()
  let covered-items = items.enumerate().map(
    ((idx, item)) => uncover((beginning: idx + start), mode: mode, item)
  )
  fn(
    ..kwargs,
    ..covered-items
  )
}

#let list-one-by-one(start: 1, mode: "invisible", ..args) = {
  _items-one-by-one(list, start: start, mode: mode, ..args)
}

#let enum-one-by-one(start: 1, mode: "invisible", ..args) = {
  _items-one-by-one(enum, start: start, mode: mode, ..args)
}

#let terms-one-by-one(start: 1, mode: "invisible", ..args) = {
  let kwargs = args.named()
  let items = args.pos()
  let covered-items = items.enumerate().map(
    ((idx, item)) => terms.item(
      item.term,
      uncover((beginning: idx + start), mode: mode, item.description)
    )
  )
  terms(
    ..kwargs,
    ..covered-items
  )
}

#let pause = {
  pause-counter.step()
  locate( loc => {
    repetitions.update(rep => calc.max(rep, pause-counter.at(loc).first() + 1))
  })
}

#let paused-content(body) = locate( loc => {
  let current-subslide = subslide.at(loc).first()
  let current-pause-counter = pause-counter.at(loc).first()

  if current-subslide > current-pause-counter {
    body
  } else {
    hide(body)
  }
})

#let polylux-slide(max-repetitions: 10, body) = {
  locate( loc => {
    if counter(page).at(loc).first() > 1 {
      pagebreak(weak: true)
    }
  })
  logical-slide.step()
  subslide.update(1)
  repetitions.update(1)

  show par: paused-content
  show math.equation: paused-content
  show box: paused-content
  show block: paused-content
  show path: paused-content
  show rect: paused-content
  show square: paused-content
  show circle: paused-content
  show ellipse: paused-content
  show line: paused-content
  show polygon: paused-content
  show image: paused-content

  for _ in range(max-repetitions) {
    pause-counter.update(0)
    locate( loc => {
      let curr-subslide = subslide.at(loc).first()
      if curr-subslide <= repetitions.at(loc).first() {
        if curr-subslide > 1 { pagebreak(weak: true) }
        set heading(outlined: false) if curr-subslide > 1

        [
          #metadata((t: "NewSlide")) <pdfpc>
          #metadata((t: "Idx", v: counter(page).at(loc).first() - 1)) <pdfpc>
          #metadata((t: "Overlay", v: curr-subslide - 1)) <pdfpc>
          #metadata((t: "LogicalSlide", v: logical-slide.at(loc).first())) <pdfpc>
        ]

        body
      }
    })
    subslide.step()
  }
}
