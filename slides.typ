#let section = state("section", none)
#let subslide = counter("subslide")
#let logical-slide = counter("logical-slide")
#let repetitions = counter("repetitions")
#let cover-mode = state("cover-mode", "hide")
#let global-theme = state("global-theme", none)

#let cover-mode-invisible = cover-mode.update("invisible")
#let cover-mode-transparent = cover-mode.update("transparent")
#let new-section(name) = section.update(name)

#let slides-default-theme(color: teal) = data => {
    let title-slide = {
        align(center + horizon)[
            #block(
                stroke: ( y: 1mm + color ),
                inset: 1em,
                breakable: false,
                [
                    #text(1.3em)[*#data.title*] \
                    #{
                        if data.subtitle != none {
                            parbreak()
                            text(.9em)[#data.subtitle]
                        }
                    }
                ]
            )
            #set text(size: .8em)
            #grid(
                columns: (1fr,) * calc.min(data.authors.len(), 3),
                column-gutter: 1em,
                row-gutter: 1em,
                ..data.authors
            )
            #v(1em)
            #data.date
        ]
    }

    let default(slide-info, body) = {
        let decoration(position, body) = {
            let border = 1mm + color
            let strokes = (
                header: ( bottom: border ),
                footer: ( top: border )
            )
            block(
                stroke: strokes.at(position),
                width: 100%,
                inset: .3em,
                text(.5em, body)
            )
        }


        // header
        decoration("header", section.display())

        if "title" in slide-info {
            block(
                width: 100%, inset: (x: 2em), breakable: false,
                outset: 0em,
                heading(level: 1, slide-info.title)
            )
        }
        
        v(1fr)
        block(
            width: 100%, inset: (x: 2em), breakable: false, outset: 0em,
            body
        )
        v(2fr)

        // footer
        decoration("footer")[
            #data.short-authors #h(10fr)
            #data.short-title #h(1fr)
            #data.date #h(10fr)
            #logical-slide.display()
        ]
    }

    let wake-up(slide-info, body) = {
        block(
            width: 100%, height: 100%, inset: 2em, breakable: false, outset: 0em,
            fill: color,
            text(size: 1.5em, fill: white, {v(1fr); body; v(1fr)})
        )
    }

    (
        title-slide: title-slide,
        variants: ( "default": default, "wake up": wake-up, ),
    )
}

#let slide(
    max-repetitions: 10,
    theme-variant: "default",
    override-theme: none,
    ..kwargs,
    body
) = {
    pagebreak(weak: true)
    logical-slide.step()
    locate( loc => {
        subslide.update(1)
        repetitions.update(1)

        let slide-content = global-theme.at(loc).variants.at(theme-variant)
        if override-theme != none {
            slide-content = override-theme
        }
        let slide-info = kwargs.named()

        for _ in range(max-repetitions) {
            locate( loc-inner => {
                let curr-subslide = subslide.at(loc-inner).first()
                if curr-subslide <= repetitions.at(loc-inner).first() {
                    if curr-subslide > 1 { pagebreak(weak: true) }
                    slide-content(slide-info, body)
                }
            })
            subslide.step()
        }
    })
}

#let _slides-cover(body) = {
    locate( loc => {
        let mode = cover-mode.at(loc)
        if mode == "invisible" {
            hide(body)
        } else if mode == "transparent" {
            text(gray.lighten(50%), body)
        } else {
            panic("Illegal cover mode: " + mode)
        }
    })
}

#let _parse-subslide-indices(s) = {
    let parts = s.split(",")
    let parse-part(part) = {
        let match-until = part.match("^-([[:digit:]]+)$")
        let match-beginning = part.match("^([[:digit:]]+)-$")
        let match-range = part.match("^([[:digit:]]+)-([[:digit:]]+)$")
        let match-single = part.match("^([[:digit:]]+)$")
        if match-until != none {
            let parsed = int(match-until.captures.first())
            assert(parsed > 0, "parsed idx is non-positive")
            ( until: parsed )
        } else if match-beginning != none {
            let parsed = int(match-beginning.captures.first())
            assert(parsed > 0, "parsed idx is non-positive")
            ( beginning: parsed )
        } else if match-range != none {
            let parsed-first = int(match-range.captures.first())
            let parsed-last = int(match-range.captures.last())
            assert(parsed-first > 0, "parsed idx is non-positive")
            assert(parsed-last > 0, "parsed idx is non-positive")
            ( beginning: parsed-first, until: parsed-last )
        } else if match-single != none {
            let parsed = int(match-single.captures.first())
            assert(parsed > 0, "parsed idx is non-positive")
            parsed
        } else {
            panic("failed to parse visible slide idx")
        }
    }
    parts.map(parse-part)
}

#let _check-visible(idx, visible-slides) = {
    if type(visible-slides) == "integer" {
        idx == visible-slides
    } else if type(visible-slides) == "array" {
        visible-slides.any(s => _check-visible(idx, s))
    } else if type(visible-slides) == "string" {
        let parts = _parse-subslide-indices(visible-subslides)
        _check-visible(idx, parts)
    } else if type(visible-slides) == "dictionary" {
        let vis = true
        if "beginning" in visible-slides {
            vis = vis or visible-slides.beginning <= idx
        }
        if "until" in visible-slides {
            vis = vis or visible-slides.until >= idx
        }
        vis
    } else {
        panic("you may only provide a single integer, an array of integers, or a string")
    }
}

#let _last-required-subslide(visible-slides) = {
    if type(visible-slides) == "integer" {
        idx
    } else if type(visible-slides) == "array" {
        calc.max(..visible-slides.map(s => _last-required-subslide(s)))
    } else if type(visible-slides) == "string" {
        let parts = _parse-subslide-indices(visible-subslides)
        _last-required-subslide(parts)
    } else if type(visible-slides) == "dictionary" {
        let last = 0
        if "beginning" in visible-slides {
            last = calc.max(last, visible-slides.beginning)
        }
        if "until" in visible-slides {
            last = calc.max(last, visible-slides.until)
        }
        last
    } else {
        panic("you may only provide a single integer, an array of integers, or a string")
    }
}

#let uncover(visible-slides, body) = {
    repetitions.update(rep => calc.max(rep, _last-required-subslide(visible-slides)))
    locate( loc => {
        if _check-visible(subslide.at(loc).first(), visible-slides) {
            body
        } else {
            _slides-cover(body)
        }
    })
}

#let only(visible-slides, body) = {
    repetitions.update(rep => calc.max(rep, _last-required-subslide(visible-slides)))
    locate( loc => {
        if _check-visible(subslide.at(loc).first(), visible-slides) {
            body
        }
    })
}

#let one-by-one(start: 1, ..children) = {
    repetitions.update(rep => calc.max(rep, start + children.pos().len() - 1))
    for (idx, child) in children.pos().enumerate() {
        beginning(start + idx, child)
    }
}

#let alternatives(start: 1, ..children) = {
    repetitions.update(rep => calc.max(rep, start + children.pos().len() - 1))
    style(styles => {
        let sizes = children.pos().map(c => measure(c, styles))
        let max-width = calc.max(..sizes.map(sz => sz.width))
        let max-height = calc.max(..sizes.map(sz => sz.height))
        for (idx, child) in children.pos().enumerate() {
            only-non-occupying(start + idx, box(
                width: max-width,
                height: max-height,
                child
            ))
        }
    })
}

#let slides(
    title: none,
    authors: none,
    subtitle: none,
    short-title: none,
    short-authors: none,
    date: none,
    theme: slides-default-theme(),
    typography: (:),
    body
) = {
    if "text-size" not in typography {
        typography.text-size = 25pt
    }
    if "paper" not in typography {
        typography.paper = "presentation-16-9"
    }
    if "text-font" not in typography {
        typography.text-font = (
            "Inria Sans",
            "Libertinus Sans",
            "Latin Modern Sans",
        )
    }
    if "math-font" not in typography {
        typography.math-font = (
            "GFS Neohellenic Math",
            "Fira Math",
            "TeX Gyre Pagella Math",
            "Libertinus Math",
        )
    }

    set text(
        size: typography.text-size,
        font: typography.text-font,
    )
    show math.equation: set text(font: typography.math-font)

    set page(
        paper: typography.paper,
        margin: 0pt,
    )

    let data = (
        title: title,
        authors: if type(authors) == "array" {
            authors
        } else if type(authors) in ("string", "content") {
            (authors, )
        } else {
            panic("authors must be an array, string, or content.")
        },
        subtitle: subtitle,
        short-title: short-title,
        short-authors: short-authors,
        date: date,
    )
    let the-theme = theme(data)
    global-theme.update(the-theme)

    the-theme.title-slide
    body
}
