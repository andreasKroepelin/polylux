// =========================================
// Nankai University theme for Typst slides.
// Made By SesameMan.
// =========================================

#import "../slides.typ": *


#let nankai-theme(
    mail: "yourmail@mail.nankai.edu.cn",
    college: "计算机学院",
    usage: "毕业答辩",
    color: rgb("#711A5F"), 
    biglogo: "nk-image/nankai.png", 
    watermark: "nk-image/nankai-10.png", 
    logo: "nk-image/nankai-white.png") = data => {
    // let nklogo = box[
    //     #box(image(biglogo, width: 0.5em))
    // ]
    let white-nklogo = box[
        #box(image(logo, width: .8em))
    ]
    // let nkwatermark = box[
    //     #box(image(watermark, width: 1cm))
    // ]
    let title-slide(slide-info, bodies) = {
        if bodies.len() != 0 {
            panic("title slide of default theme does not support any bodies")
        }
     	place(dx: 50%,
        dy: -13%,
        image(watermark, height: 510pt)
        )
        
        align(center + horizon)[
            #block(
                stroke: ( y: 1mm + black ),
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


  // Next Pages
    let displayed-title(slide-info) = if "title" in slide-info {
        text(fill: rgb("#fafafa"), slide-info.title)
        } else {
        []
    }
    let decoration(position, body) = {
        let border =  color
        let strokes = (
            header: ( bottom: border ),
            footer: ( top: border )
        )
        block(
            stroke: strokes.at(position),
            width: 100%,
            height: 1.1em,
            fill: color,
            outset: 0em, inset: 0em, breakable: false,
            align(left + horizon)[#h(0.2em) 
                #white-nklogo 
                #text(fill: rgb("#fafafa"), 0.5em,body
                )
            ]
        )
    }
    let default(slide-info, bodies) = {
        if bodies.len() != 1 {
            panic("default variant of default theme only supports one body per slide")
        }
        let body = bodies.first()
     	place(dx: 50%,
        dy: -13%,
        image(watermark, height: 510pt)
        )

        // header
        decoration("header", section.display() + h(1fr) +displayed-title(slide-info)+ h(1fr)+ data.date +h(1em)+ usage + h(1em))

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
            #h(1em)
            #data.short-authors #h(4em)
            #mail #h(4em)
            #college #h(1fr)
            #logical-slide.display() #h(1em)
        ]
    }

    let wake-up(slide-info, bodies) = {
        if bodies.len() != 1 {
            panic("wake up variant of default theme only supports one body per slide")
        }
        let body = bodies.first()

        block(
            width: 100%, height: 100%, inset: 2em, breakable: false, outset: 0em,
            fill: color,
            text(size: 1.5em, fill: white, {v(1fr); body; v(1fr);})
        )
    }

    (
        "title slide": title-slide,
        "default": default,
        "wake up": wake-up,
    )
}