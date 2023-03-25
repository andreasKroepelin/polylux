#let section = state("section", none)

#let multislide(amount, mode: "hide", fn) = {
    let modes = ("hide", "mute")
    assert(modes.contains(mode), message: "`mode` must be one of " + repr(modes))
        
    let conditional-display(i) = {
        (subslides, body) => if subslides.contains(i) {
            body
        } else {
            if mode == "hide" {
                hide(body)
            } else {
                text(gray.lighten(50%), body)
            }
        }
    }
    let tools(i) = {
        let cd = conditional-display(i)
        let only(v, body) = cd((v,), body)
        let beginning(v, body) = cd(range(v, amount+1), body)
        let one-by-one(start: 1, ..children) = {
            for idx, child in children.pos() {
                beginning(start + idx, child)
            }
        }
        (
            only-first: body => only(1, body), 
            only-second: body => only(2, body), 
            only-third: body => only(3, body), 
            only: only,
            until: (v, body) => cd(range(1, v+1), body),
            beginning: beginning,
            amount: amount,
            one-by-one: one-by-one,
        )
    }

    locate( loc => {
        let page_before = counter(page).at(loc)
        show heading.where(level: 2): h => h
        for i in range(1, amount + 1) {
            [
                #pagebreak(weak: true)
                #fn(tools(i))
            ]
            counter(page).update(page_before)
        }
    })
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
        let border = 1mm + teal
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
            block(fill: teal, inset: 1em, radius: 1em, breakable: false,
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
