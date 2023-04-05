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
        align(center + horizon,
            block(fill: color, inset: 1em, radius: 1em, breakable: false,
                [
                    #text(1.7em)[*#data.title*] \
                    #v(1em)
                    #text(1.5em)[#data.author] \
                    #v(1em)
                    #data.date
                ]
            )
        )
    }

    let default(body) = {
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
        locate( loc => {
            if counter(page).at(loc).first() > 1 {
                decoration("header", section.at(loc))
            }
        } )

        v(1fr)
        block(
            width: 100%, inset: 2em, breakable: false, outset: 0em,
            body
        )
        v(1fr)

        // footer
        locate( loc => {
            if counter(page).at(loc).first() > 1 {
                decoration("footer")[
                    #data.short-author #h(10fr)
                    #data.short-title #h(1fr)
                    #data.date #h(10fr)
                    #logical-slide.display()
                ]
            }
        } )
    }

    let wake-up(body) = {
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

#let slide(max-repetitions: 10, theme-variant: "default", body) = {
    pagebreak(weak: true)
    logical-slide.step()
    locate( loc => {
        subslide.update(1)
        repetitions.update(1)

        let slide-content = global-theme.at(loc).variants.at(theme-variant)

        for _ in range(max-repetitions) {
            locate( loc-inner => {
                let curr-subslide = subslide.at(loc-inner).first()
                if curr-subslide <= repetitions.at(loc-inner).first() {
                    if curr-subslide > 1 { pagebreak(weak: true) }
                    slide-content(body)
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
    for idx, child in children.pos() {
        beginning(start + idx, child)
    }
}

#let slides(
    title: none,
    author: none,
    subtitle: none,
    short-title: none,
    short-author: none,
    date: none,
    theme: slides-default-theme(),
    body
) = {
    set text(
        size: 25pt,
    )

    set page(
        paper: "presentation-16-9",
        margin: 0pt,
    )

    let data = (
        title: title,
        author: author,
        subtitle: subtitle,
        short-title: short-title,
        short-author: short-author,
        date: date,
    )
    let the-theme = theme(data)
    global-theme.update(the-theme)

    the-theme.title-slide
    body
}
