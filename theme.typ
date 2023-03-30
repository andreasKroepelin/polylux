#let base_theme(
    __type : "theme",
    color : teal,
    text-size : 25pt,
    author-text-space : 1.5em,
    title-text-size : 2em,
    title-text-space : 1em,
    decoration : (position, body, color : red) => {
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
            )},
    margin: ( x: 1em, y: 4em ),
    header-ascent: 3em,
    header: (decoration, section) => locate( loc => {
        if counter(page).at(loc).first() > 1 {
            decoration("header", section.at(loc))
        }
    }),
    footer: (decoration, section, short-author, short-title, date, logical-slide) => locate( loc => {
            if counter(page).at(loc).first() > 1 {
                decoration("footer")[
                    #short-author #h(10fr)
                    #short-title #h(1fr)
                    #date #h(10fr)
                    #logical-slide.display()
                ]
            }
        } ),
    footer-descent: 3em,
    max-repetitions : 10,
    inset : 1em,
    radius : 1em,
) = {
        assert(type(color) == type(teal))
        assert(type(text-size) == type(25pt))
        assert(type(decoration ) == "function")
        assert(type(margin) == "dictionary")
        //assert(type(header) == )
        //assert(type(footer) == )
        assert(type(footer-descent) == type(3em) )
        assert(type(max-repetitions) == type(10) )

        (
        __type : __type,
        color : color,
        text-size : text-size,
        author-text-space : author-text-space,
        title-text-size : title-text-size,
        title-text-space : title-text-space,
        decoration : decoration.with(color : color),
        margin: margin,
        header: header.with(decoration),
        header-ascent: header-ascent,
        footer: footer.with(decoration),
        footer-descent: footer-descent,
        max-repetitions : max-repetitions,
        inset : inset,
        radius : radius,
    )}

#let assert_theme(theme) = assert(theme.__type == "theme")
#assert_theme(base_theme())