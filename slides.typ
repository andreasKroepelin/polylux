#let section = state("section", none)
#let subslide = counter("subslide")
#let repetitions = counter("repetitions")

#let slides-custom-hide(mode: "hide", body) = {
    if mode == "hide" {
        hide(body)
    } else {
        text(gray.lighten(50%), body)
    }
}

#let slide(max-repetitions: 10, cover-mode: "hide", body) = {
    locate( loc => {
        subslide.update(1)
        repetitions.update(1)
        let page_before = counter(page).at(loc)
        show heading.where(level: 2): h => h

        for _ in range(max-repetitions) {
            locate( loc-inner => {
                if subslide.at(loc-inner).first() <= repetitions.at(loc-inner).first() {
                    pagebreak(weak: true)
                    body
                }
            })
            subslide.step()
            counter(page).update(page_before)
        }
    })
}

#let only(visible-slide-number, body) = {
    repetitions.update(rep => calc.max(rep, visible-slide-number))
    locate( loc => {
        if subslide.at(loc).first() == visible-slide-number {
            body
        } else {
            slides-custom-hide(body)
        }
    })
}

#let beginning(first-visible-slide-number, body) = {
    repetitions.update(rep => calc.max(rep, first-visible-slide-number))
    locate( loc => {
        if subslide.at(loc).first() >= first-visible-slide-number {
            body
        } else {
            slides-custom-hide(body)
        }
    })
}

#let until(last-visible-slide-number, body) = {
    repetitions.update(rep => calc.max(rep, last-visible-slide-number))
    locate( loc => {
        if subslide.at(loc).first() <= last-visible-slide-number {
            body
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
    short-title: none,
    short-author: none,
    date: none,
    color: teal,
    document_body
) = {
    show heading.where(level: 1): h => {
        section.update(h.body)
    }

    show heading.where(level: 2): h => [
        #pagebreak(weak: true)
        #h
    ]

    set text(
        size: 25pt,
    )

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

    set page(
        paper: "presentation-16-9",
        margin: ( x: 1em, y: 4em ),
        header: locate( loc => {
            if counter(page).at(loc).first() > 1 {
                decoration("header", section.at(loc))
            }
        } ),
        header-ascent: 3em,
        footer: locate( loc => {
            if counter(page).at(loc).first() > 1 {
                decoration("footer")[
                    #short-author #h(10fr)
                    #short-title #h(1fr)
                    #date #h(10fr)
                    #counter(page).display()
                ]
            }
        } ),
        footer-descent: 3em,
    )

    [
        #align(center + horizon,
            block(fill: color, inset: 1em, radius: 1em, breakable: false,
                [
                    #text(2em)[*#title*] \
                    #v(1em)
                    #text(1.5em)[#author] \
                    #v(1em)
                    #date
                ]
            )
        )
        #document_body
    ]
}
