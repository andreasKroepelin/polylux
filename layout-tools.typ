#let custom-block(
  width: none,
  height: none,
  background: none,
  background-align: center + horizon,
  dir: ttb,
  radius: 0pt,
  inset: 2em,
  children-align: top + start,
  ..children
) = {
  let fill = if type(background) == "color" {
    background
  } else {
    none
  }

  if type(background) == "content" {
    place(background-align, background)
  }

  let spacer = if dir in (ttb, btt) { v } else { h }

  let blocked = children.pos().map( child => {
    if type(child) in ("fraction", "length", "relative length", "ratio") {
      spacer(child)
    } else {
      if dir in (ttb, btt) {
        block(width: 100%, height: auto, child)
      } else {
        box(width: 1fr, height: 100%, child)
      }
    }
  })

  let combined = blocked.zip((spacer(0pt),) * blocked.len() + (none,)).flatten().sum()

  block(
    width: width,
    height: height,
    breakable: false,
    fill: fill,
    stroke: 1mm + red,
    radius: 0pt,
    outset: 0pt,
    inset: inset,
    spacing: 0pt,
    clip: true,
    align(children-align, combined)
  )
}

#let full-block = custom-block.with(width: 100%, height: 100%)
#let wide-block = custom-block.with(width: 100%, height: auto)
#let tall-block = custom-block.with(width: auto, height: 100%)

#let side-by-side(
  widths: none,
  ..children
) = {
  block(
    width: 100%,
    height: 100%,
    breakable: false,
    fill: none,
    stroke: none,
    radius: 0pt,
    inset: 0em,
    outset: 0pt,
    spacing: 0pt,
    clip: true,
    grid(
      columns: if widths == none {
        (1fr,) * children.pos().len()
      } else {
        widths
      },
      rows: (1fr,),
      column-gutter: 1em,
      row-gutter: 0pt,
      ..children
    )
  )
}

#let decoration(
  ..chilldren
) = {
  
}

#let authors-list(authors) = authors.join(", ")

#let require-bodies(min: none, max: none, exactly: none, name: none, bodies) = {
  let variant-specifier = if name == none {
    "this theme variant"
  } else {
    "\"" + name + "\" variant"
  }
  let err-msg(relation, value) = {
    "Required " + relation + " " + str(value) + " bodies for " + variant-specifier + "."
  }

  if min != none {
    if bodies.len() < min {
      panic(err-msg("at least", min))
    }
  }
  if max != none {
    if bodies.len() > max {
      panic(err-msg("at most", max))
    }
  }
  if exactly != none {
    if bodies.len() != exactly {
      panic(err-msg("exactly", exactly))
    }
  }
}

#let aligner(alignment) = it => align(alignment, it)

#let _check-keys(dict, allowed-keys) = {
  for key in dict.keys() {
    if key not in allowed-keys {
      panic("Found illegal key " + key + ", expected one of " + allowed-keys)
    }
  }
}

#let builder(variants) = data => {
  let theme = (:)

  for variant-name in variants.keys() {
    let declaration = variants.at(variant-name)
    let specific-require-bodies = if "required-bodies" in declaration {
      let rb = declaration.required-bodies
      _check-keys(rb, ("min", "max", "exactly"))
      bodies => require-bodies(..rb, name: variant-name, bodies)
    } else {
      bodies => {}
    }

    let layout = declaration.layout

    let variant = (slide-info, bodies) => {
      specific-require-bodies(bodies)

    }
    theme.insert(variant-name, variant)
  }

  theme
}
