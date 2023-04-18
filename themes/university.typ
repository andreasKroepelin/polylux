// University theme
//
// By Pol Dellaiera - https://github.com/drupol
//
// Please feel free to improve this theme
// by submitting a PR in https://github.com/andreasKroepelin/typst-slides
//
#let university-theme(
    university-name: "University",
    color-a: none,
    color-b: none,
    color-c: none,
    logo: none
) = data => {
    let color-title = color-a
    let color-subtitle = color-a
    let color-section = color-a.lighten(85%)
    let color-authors = black

    let color-footer-fill-short-authors = color-a
    let color-footer-fill-short-title = color-b
    let color-footer-fill-date = color-b
    let color-footer-fill-slide-counter = color-b

    let color-footer-short-authors = white
    let color-footer-short-title = white
    let color-footer-date = white
    let color-footer-slide-counter = white

    let section = state("section", none)
    let logical-slide = counter("logical-slide")
    let subslide = counter("subslide")
    let total-slides = counter("slide")
    let last-slide-number = locate(loc => logical-slide.final(loc).first())

    let title-slide = {
        align(right)[
            #block(
            )[
                #image(logo, width: 60mm)
            ]
        ]
        align(center + horizon)[
            #block(
                inset: 0em,
                breakable: false,
                [
                    #text(2em, color-a)[*#data.title*] \
                    #{
                        if data.subtitle != none {
                            parbreak()
                            text(1.2em, color-subtitle)[#data.subtitle]
                        }
                    }
                ]
            )
            #set text(size: .8em)
            #grid(
                columns: (1fr,) * calc.min(data.authors.len(), 3),
                column-gutter: 1em,
                row-gutter: 1em,
                text(color-authors)[#data.authors.join()]
            )
            #v(1em)
            #{
                parbreak()
                text(.9em)[#university-name]
            }
            #{
                parbreak()
                text(.8em)[#data.date]
            }
        ]
    }

    let default(slide-info, bodies) = {
        if bodies.len() != 1 {
            panic("default variant of university theme only supports one body per slide")
        }
        let body = bodies.first()

        let header-deco() = {
            let cell = rect.with(
                width: 100%,
                stroke: none,
                outset: 2mm
            )
            grid(
                rows: (1mm, auto),
                block(fill: color-b, width:100%)[
                    #locate(loc => {
                        let ratio = logical-slide.at(loc).first() / logical-slide.final(loc).first() * 100%
                        grid(
                            columns: (ratio, auto),
                            cell(fill: color-a, height: 1mm)[],
                        )
                    }
                    )
                ],
                block(fill: color-c.lighten(90%))[
                    #grid(
                        columns: (60%, 40%),
                        cell[
                            #if "title" in slide-info {
                              heading(level: 2, text(color-title)[#slide-info.title])
                            }
                        ],
                        cell[
                            #align(right)[
                                #heading(level: 2, text(color-section)[#section.display()])
                            ]
                        ]
                    )
                ],
            )
        }

        let footer-deco() = {
            let cell = rect.with(
                width: 100%,
                inset: 1mm,
                outset: 0mm
            )
            set text(
                size: 10pt
            )
            set align(center)
            grid(
                columns: (25%, 1fr, 15%, 10%),
                rows: (5mm, auto),
                cell(
                    height: 100%,
                    fill: color-footer-fill-short-authors
                )[#text(color-footer-short-authors)[#data.short-authors]],
                cell(
                    height: 100%,
                    fill: color-footer-fill-short-title
                )[#text(color-footer-short-title)[#data.short-title]],
                cell(
                    height: 100%,
                    fill: color-footer-fill-date
                )[#text(color-footer-date)[#data.date]],
                cell(
                    height: 100%,
                    fill: color-footer-fill-slide-counter
                )[#text(color-footer-slide-counter)[#logical-slide.display() / #last-slide-number]]
            )
        }

        // header
        header-deco()

        v(1fr)
        block(
            width: 100%, inset: (x: 1em), breakable: false, outset: 0em,
            body
        )
        v(2fr)

        // footer
        footer-deco()
    }

    let wake-up-a(slide-info, bodies) = {
        if bodies.len() != 1 {
            panic("wake-up-a variant of university theme only supports one body per slide")
        }

        let body = bodies.first()

        block(
            width: 100%,
            height: 100%,
            inset: 2em,
            breakable: false,
            outset: 0em,
            fill: color-a,
            text(size: 2em, fill: white, {v(1fr); body; v(1fr)})
        )
    }

    let wake-up-b(slide-info, bodies) = {
        if bodies.len() != 1 {
            panic("wake-up-b variant of university theme only supports one body per slide")
        }

        let body = bodies.first()

        block(
            width: 100%,
            height: 100%,
            inset: 2em,
            breakable: false,
            outset: 0em,
            fill: color-b,
            text(size: 2em, fill: white, {v(1fr); body; v(1fr)})
        )
    }

    let wake-up-c(slide-info, bodies) = {
        if bodies.len() != 1 {
            panic("wake-up-c variant of university theme only supports one body per slide")
        }

        let body = bodies.first()

        block(
            width: 100%,
            height: 100%,
            inset: 2em,
            breakable: false,
            outset: 0em,
            fill: color-c,
            text(size: 2em, fill: white, {v(1fr); body; v(1fr)})
        )
    }

    let split-2-h(slide-info, bodies) = {
        if bodies.len() != 2 {
            panic("split-2-h variant of theme only supports 2 bodies per slide")
        }

        let body-top = bodies.first()
        let body-bottom = bodies.last()

        let gridBox = box.with(
            width: 100%,
            height: 100%,
            outset: 0em,
            inset: (x: 0em),
            baseline: 0em,
            stroke: none,
        )

        grid(
            rows: (1fr, 1fr),
            gridBox(
                align(center + horizon, body-top)
            ),
            gridBox(
                align(center + horizon, body-bottom)
            ),
        )
    }

    let split-2-v(slide-info, bodies) = {
        if bodies.len() != 2 {
            panic("split-2-v variant of theme only supports 2 bodies per slide")
        }

        let body-left = bodies.first()
        let body-right = bodies.last()

        let gridBox = box.with(
            width: auto,
            height: 100%,
            outset: 0em,
            inset: (x: 0em),
            baseline: 0em,
            stroke: none,
        )

        grid(
            columns: (auto, auto),
            gridBox(
                body-left
            ),
            gridBox(
                body-right
            ),
        )
    }

    let four-split(slide-info, bodies) = {
        if bodies.len() != 4 {
            panic("four-split variant of theme only supports 4 bodies per slide")
        }

        let body-top-left = bodies.at(0)
        let body-top-right = bodies.at(1)
        let body-bottom-left = bodies.at(2)
        let body-bottom-right = bodies.at(3)

        let gridBox = box.with(
            width: 100%,
            height: 100%,
            outset: 0em,
            inset: (x: 0em),
            baseline: 0em,
            stroke: none,
        )

        grid(
            columns: (1fr, 1fr),
            rows: (1fr, 1fr),
            gridBox(
                align(center + horizon, body-top-left)
            ),
            gridBox(
                align(center + horizon, body-top-right)
            ),
            gridBox(
                align(center + horizon, body-bottom-left)
            ),
            gridBox(
                align(center + horizon, body-bottom-right)
            )
        )
    }

    (
        title-slide: title-slide,
        variants: (
            "default": default,
            "wake up": wake-up-a,
            "wake up a": wake-up-a,
            "wake up b": wake-up-b,
            "wake up c": wake-up-c,
            "split 2 h": split-2-h,
            "split 2 v": split-2-v,
            "four split": four-split
        ),
    )
}
