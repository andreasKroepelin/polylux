#let section = state("section", none)
#let subslide = counter("subslide")
#let logical-slide = counter("logical-slide")
#let repetitions = counter("repetitions")
#let cover-mode = state("cover-mode", "hide")
#let global-theme = state("global-theme", none)

#let cover-mode-hide = cover-mode.update("hide")
#let cover-mode-mute = cover-mode.update("mute")
#let new-section(name) = section.update(name)

// avoid "#set" interferences
#let full-box(obj) = {
    box(
        width: 100%, height: auto, baseline: 0%, fill: none,
        stroke: none, radius: 0%, inset: 0%, outset: 0%,
        obj
    )
}

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

#let slides-custom-hide(body) = {
    locate( loc => {
        let mode = cover-mode.at(loc)
        // wrap in box to avoid hiding issues with list, equation and other types
        if mode == "hide" {
            hide(full-box(body))
        } else if mode == "mute" {
            text(gray.lighten(50%), full-box(body))
        } else {
            panic("Illegal `cover-mode`: " + mode)
        }
    })
}

#let only(visible-slide-number, body) = {
    repetitions.update(rep => calc.max(rep, visible-slide-number))
    locate( loc => {
        if subslide.at(loc).first() == visible-slide-number {
            full-box(body)
        } else {
            slides-custom-hide(body)
        }
    })
}

#let beginning(first-visible-slide-number, body) = {
    repetitions.update(rep => calc.max(rep, first-visible-slide-number))
    locate( loc => {
        if subslide.at(loc).first() >= first-visible-slide-number {
            full-box(body)
        } else {
            slides-custom-hide(body)
        }
    })
}

#let until(last-visible-slide-number, body) = {
    repetitions.update(rep => calc.max(rep, last-visible-slide-number))
    locate( loc => {
        if subslide.at(loc).first() <= last-visible-slide-number {
            full-box(body)
        } else {
            slides-custom-hide(body)
        }
    })
}

#let one-by-one(start: 1, ..children) = {
    repetitions.update(rep => calc.max(rep, start + children.pos().len() - 1))
    for (idx, child) in children.pos().enumerate() {
        beginning(start + idx, child)
    }
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
