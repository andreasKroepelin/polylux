
#let decoration(position, body, color : red) = {
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
)}
    

#let data(
    author: none,
    title: none,
    short-author: none, 
    short-title: none, 
    date: none, 
) = {
    if none in (short-author,short-title,date,title) {panic()}
    (
    short-author: short-author, 
    short-title: short-title, 
    date:date, 
    author: author,
    title: title,
)}

#let current-slide(
    section: none, 
    logical-slide: none,
    subslide: none,
) = {
    if none in (section, logical-slide, subslide) {panic()}
    (
    section: section, 
    logical-slide: logical-slide,
    subslide : subslide,
)}


#let make_theme(
    __type: "theme",
    color: teal,
    text-size: 25pt,
    author-text-space: 1.5em,
    title-slide: (theme, data) => {
        align(center + horizon,
            block(fill: theme.color, inset: theme.inset, radius: theme.radius, breakable: false,
                [
                    #text(theme.title-text-size)[*#data.title*] \
                    #v(theme.title-text-space)
                    #text(theme.author-text-space)[#data.author] \
                    #v(theme.title-text-space)
                    #data.date
                ]
            )
        )
    },
    title-text-size: 2em,
    title-text-space: 1em,
    margin: ( x: 1em, y: 4em ),
    header-ascent: 3em,
    header: (data, theme, current-slide) => locate( loc => {
        if counter(page).at(loc).first() > 1 {
            decoration("header", current-slide.section.at(loc))
        }
    }),
    footer: (data, theme, current-slide) => locate( loc => {
            if counter(page).at(loc).first() > 1 {
                decoration("footer")[
                    #data.short-author #h(10fr)
                    #data.short-title #h(1fr)
                    #data.date #h(10fr)
                    #current-slide.logical-slide.display()
                ]
            }
        } ),
    footer-descent: 3em,
    inset: 1em,
    radius: 1em,
) = {
        //assert(type(color) == type(teal))
        //assert(type(text-size) == type(25pt))
        //assert(type(decoration ) == "function")
        //assert(type(margin) == "dictionary")
        //assert(type(header) == )
        //assert(type(footer) == )
        //assert(type(footer-descent) == type(3em) )
        //assert(type(max-repetitions) == type(10) )

        (
        __type: __type,
        color: color,
        text-size: text-size,
        author-text-space: author-text-space,
        title-slide: title-slide,
        title-text-size: title-text-size,
        title-text-space: title-text-space,
        margin: margin,
        header: header,
        header-ascent: header-ascent,
        footer: footer,
        footer-descent: footer-descent,
        inset: inset,
        radius: radius,
    )}

#let is_theme(theme) = theme.__type == "theme"

#let assert_theme(theme) = assert(theme.__type == "theme")
#assert_theme(make_theme())