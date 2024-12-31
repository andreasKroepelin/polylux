#import "@local/polylux:0.3.0": *
#import themes.estonia: *

#show: estonia-theme

#set text(font: "Fira Sans", size: 20pt)
#show math.equation: set text(font: "Fira Math", weight: "regular")
#set strong(delta: 100)
#set par(justify: true)

#let dslide(raw-font-size: 20pt, ..args) = {
  show raw: set text(font: "Inconsolata", weight: "semibold", size: raw-font-size)
  slide(..args)
}

#set footnote.entry(
  separator: rect(width:50%, height: .5mm, fill: black),
  clearance: 1em,
  indent: 0em,
)

#show link: v => underline(text(v, fill: est-blue))

#let plain-slide = slide.with(body-args: (margin: 0mm))
#let focus-slide(body) = {
  let content = {
    set align(horizon + center)
    set text(size: 1.5em, fill: white)
    body
  }
  slide(body-args: (bg-color: est-blue), content)
}
#let new-section-slide(name) = {
  let content = {
    utils.register-section(name)
    strong(name)
  }
  focus-slide(content)
}

#dslide({
  show: pad.with(2em)
  grid(columns: 1, row-gutter: 1fr,
    {
      text(size: 1.3em, strong[The #text(fill: est-blue, [Estonia]) polylux theme])
      v(1mm)
      text(size: 1em, [Simple and customizable])
      line(length: 100%, stroke: .13em + est-blue)
    },
    align(center, { block(width:60%, { grid(columns: 3, column-gutter: 2fr, [Author A], [Author B], [Author C]) })}),
    align(bottom+center)[Date]
  )
})

#dslide(title: "Table of contents")[
  #estonia-outline
]

#new-section-slide("Showcase")

#dslide(title: "Maths")[
  A slide with some equations

  #set align(center+horizon)
  $ sum_(k=0)^n k
    &= 1 + ... + n \
    &= (n(n+1)) / 2 $

  #set align(left)
  more equations
  $ 7.32 beta +
    sum_(i=0)^nabla
      (Q_i (a_i - epsilon)) / 2 $
]

#dslide(title: "Footnotes")[
  Footnotes #footnote[https://typst.app/docs/reference/meta/footnote/] can be added to your Typst #footnote[Mädje, L. (2022). A Programmable Markup Language for Typesetting (Master's thesis, TU Berlin). #link("https://www.user.tu-berlin.de/laurmaedje/programmable-markup-language-for-typesetting.pdf", [pdf])] slides.

  #v(2cm)
  #grid(columns: (10%, 1fr),
    text(fill: red, size: 40pt, emoji.warning),
    [
      Your slide content must have enough remaining vertical space. \
      Otherwise, footnotes will not be shown.
    ]
  )
]

#dslide(title:"Code blocks")[
  #set raw(theme: "mpoquet.tmTheme")
  #let code = [
    ```c
    // comment
    int main()
    {
        printf("Hello, world!\n");
        if (42 == 6*7 && 0+0 == 0)
            return 0;
        return 1;
    }
    ```
  ]

  You can of course show code blocks too!
  #v(2cm)
  #code
]

#dslide(title: "Titles can contain line breaks\nSuch as this one\nOr this one...")[
  Title bar height should be adjusted automatically.
]

#new-section-slide("Usage & slide API")

#dslide(title: "The slide function", raw-font-size: 18pt)[
  #set align(top+left)
  This theme is essentially a `slide` function.
  #uncover("2-")[It is called like this:]

  #uncover("2-")[
    ```typst
    #slide(title: "The slide title")[
      The slide content
    ]
    ```
  ]

  #uncover("3-")[
    //#v(1cm)
    `slide` has many parameters that enables customization.
    For example to hide the progress bar, show the title bar and the bottom bar with a slide number:

    ```typst
    #slide(title: "Title", progress-bar: false, title-bar: true,
      bottom-bar: true,
      bottom-bar-args: (
        func-args: (
          show-slide-number: true
        )
      )
    )
    ```
  ]
]

#dslide(title: "The slide function: custom call")[
    Typst makes it convenient to customize the function call for all your slides

    ```typst
    #let my-slide = slide.with(/*args you want to customize*/)
    ```

    #uncover("2-")[
      #v(10mm)
      You can also create your own wrapper around the function,
      which is very convenient to change some parameter for specific slides only.
      For example this wrapper that sets the font size of code blocks has been used heavily to generate the #text(fill:est-blue, [Estonia]) slides:

      ```typst
      #let dslide(raw-font-size: 20pt, ..args) = {
        show raw: set text(font: "Inconsolata",
                           weight: "semibold",
                           size: raw-font-size)
        slide(..args)
      }
      ```
    ]
]

#new-section-slide("Title bar customization")

#dslide(title: "Title bar")[
  #grid(columns: (auto, auto), gutter: 3cm,
    [
      `slide` API related with title (bar):
      #v(5mm)
      ```typst
      #let slide(
        title: none,
        title-bar: auto,
        title-bar-args: (
          height-per-line: 1.5em,
          func: est-title-bar,
          func-args: (:),
        ),
        // (other args hidden)
      ) = { /* ... */ }
      ```
    ],
    [
      `title`: `none` or a string
      #v(5mm)
      `title-bar`:
      - `auto`: shown iff `title` is set
      - `true/false`: always shown/hidden
      #v(5mm)
      inside `title-bar-args` dict:
      - `height-per-line` is the height of a line. This is multiplied by the number of lines in `title`
      - `func` is the function that generates the title bar (default `func` is presented on next slide)
      - `func-args` are the additional arguments given to `func` when it is called

    ]
  )
]

#dslide(title: "Title bar: default function")[
  #grid(columns: (auto, auto), gutter: 3cm,
    [
      ```typst
      #let est-title-bar(
        title,
        width,
        height,
        bg-color: est-blue,
        inset: 1cm,
        alignment: left+horizon,
        text-fill-color: white,
        text-size: 1.2em,
      )
      ```
    ],
    [
      Arguments always set by `slide` at call time:
      - `title`: the slide title (`string`)
      - `width`: the page width (`length`)
      - `height`: the title bar height (`length`)

      #v(1mm)

      The other arguments enable cutomization of the bar.
      Their names should be enough to explain what they do ;).
    ]
  )
]

#let critical-slide = dslide.with(
  title-bar: true,
  title-bar-args: (
    height-per-line: 3cm,
    func: est-title-bar,
    func-args: (
      bg-color: red,
      alignment: center+horizon,
      text-fill-color: white,
      text-size: 1.5em,
    )
  )
)

#critical-slide(title: "Title bar: customize default function call", raw-font-size: 18pt)[
  #grid(columns: (auto, auto), gutter: 5cm,
    [
      ```typst
      #let critical-slide = slide.with(
        title-bar: true,
        title-bar-args: (
          height-per-line: 3cm,
          func: est-title-bar,
          func-args: (
            bg-color: red,
            alignment: center+horizon,
            text-fill-color: white,
            text-size: 1.5em,
          )
        )
      )
      ```
    ],
    [
      #set align(top)
      ```typst
      #critical-slide(title: "...")[
        /* content */
      ]
      ```
    ]
  )
]

#let my-title-bar-func(title, width, height, inset: 3cm, nb-tilde: 10) = {
  show: block.with(
    width: width, height: height,
    above: 0pt, below: 0pt,
    breakable: false,
    fill: est-blue,
    inset: inset,
  )
  set align(horizon+center)
  set text(fill: white, size: 1.2em)
  if title == none [] else {
    for _ in range(nb-tilde) [\~]
    h(3mm)
    smallcaps(title)
    h(3mm)
    for _ in range(nb-tilde) [\~]
  }
}

#dslide(title: "Title bar: your own function", raw-font-size: 18pt,
  title-bar-args: (
    func: my-title-bar-func,
    func-args: (
      nb-tilde: 7,
    )
  )
)[
  #grid(columns: (auto, auto), gutter: 2cm,
    [
      ```typst
      #let my-title-bar-func(title, width, height,
                             inset: 3cm, nb-tilde: 10) = {
        show: block.with(
          width: width, height: height,
          above: 0pt, below: 0pt,
          breakable: false,
          fill: est-blue, inset: inset,
        )
        set align(horizon+center)
        set text(fill: white, size: 1.2em)
        if title == none [] else {
          for _ in range(nb-tilde) [\~]
          h(3mm) smallcaps(title) h(3mm)
          for _ in range(nb-tilde) [\~]
        }
      }
      ```
    ],
    [
      ```typst
      #slide(title: "...",
        func: my-title-bar-func,
        func-args: (nb-tilde: 7)
      )[
        /* content */
      ]
      ```
    ]
  )
]

#new-section-slide("Progress bar customization")

#dslide(title: "Progress bar")[
  #grid(columns: (auto, auto), gutter: 3cm,
    [
      `slide` API related with progress bar:
      #v(5mm)
      ```typst
      #let slide(
        progress-bar: true,
        progress-bar-args: (
          height: 1em,
          func: est-progress-bar,
          func-args: (:),
        ),
        // (other args hidden)
      ) = { /* ... */ }
      ```
    ],
    [
      `progress-bar`:
      - `true/false`: always shown/hidden
      #v(5mm)
      inside `progress-bar-args` dict:
      - `height` is the height of the progress bar
      - `func` is the function that generates the progress bar (default `func` is presented on next slide)
      - `func-args` are the additional arguments given to `func` when it is called

    ]
  )
]

#dslide(title: "Progress bar: default function", raw-font-size: 16pt)[
  #grid(columns: (auto, auto), gutter: 3cm,
    [
      ```typst
      #let est-progress-bar(
        width, height, inset: 1cm,
        show-slide-number: true,
        bg-color: black, text-size: 0.8em,
        alignment: horizon,
        current-slide: loc =>
          {circle(radius: .15em, fill: white)},
        before-slide: loc =>
          {circle(radius: .075em,
                  fill: white.darken(50%))},
        after-slide: loc =>
          {circle(radius: .075em,
                  fill: white.darken(50%))},
        slide-number: loc =>
          {block(width: 1em, align(right, text(
            fill:white,
            logic.logical-slide.display())))}
      )

      ```
    ],
    [
      Arguments always set by `slide` at call time:
      - `width`: the page width (`length`)
      - `height`: the progress bar height (`length`)

      #v(1mm)

      The other arguments enable cutomization of the bar.
      - `before-slide`, `current-slide` and `after-slide` are functions that generate contents inside the bar.
        By default they generate disks of various size/color.
      - `slide-number` is a function that generate contents inside the bar.
        By default it simply writes the current slide number.
    ]
  )
]

#let pacman-progress-slide = dslide.with(progress-bar-args: (
  func: est-progress-bar,
  func-args: (
    show-slide-number: false,
    inset: 5mm,
    before-slide: loc => {circle(radius: .075em, fill: white.darken(60%))},
    after-slide: loc => {circle(radius: .075em, fill: white)},
    current-slide: loc => { text(size: 12pt, fill: yellow, weight: "bold")[<] }
  )
))

#pacman-progress-slide(title: "Progress bar: customize default function call")[
  ```typst
  #let pacman-progress-slide = slide.with(progress-bar-args: (
    func: est-progress-bar,
    func-args: (
      show-slide-number: false,
      inset: 5mm,
      before-slide: loc => {circle(radius: .075em, fill: white.darken(60%))},
      after-slide: loc => {circle(radius: .075em, fill: white)},
      current-slide: loc => { text(size: 12pt, fill: yellow, weight: "bold")[<] }
    )
  ))

  #pacman-progress-slide(title: "...")[
    /* content */
  ]
  ```
]

#let my-progress-bar(width, height) = {
  locate(loc => {
    let current_slide = logic.logical-slide.at(loc).first() - 1
    let nb_slides = logic.logical-slide.final(loc).first()
    let ratio = current_slide / nb_slides
    set align(left+horizon)
    grid(columns: (width * ratio, width * (1 - ratio)), gutter: 0mm,
      est-cell(fill: white, height: height, text(fill: est-blue, size: .8em, [#current_slide / #nb_slides])),
      est-cell(fill: black, height: height)
    )
  })
}

#dslide(title: "Progress bar: your own function", raw-font-size: 18pt,
  progress-bar-args: (
    func: my-progress-bar
  ))[
  ```typst
  #let my-progress-bar(width, height) = {
    locate(loc => {
      let current_slide = logic.logical-slide.at(loc).first() - 1
      let nb_slides = logic.logical-slide.final(loc).first()
      let ratio = current_slide / nb_slides
      set align(left+horizon)
      grid(columns: (width * ratio, width * (1 - ratio)), gutter: 0mm,
        est-cell(fill: white, height: height, text(fill: est-blue, size: .8em,
                                                   [#current_slide / #nb_slides])),
        est-cell(fill: black, height: height)
      )
    })
  }
  #slide(title: "...", progress-bar-args: (func: my-progress-bar))[
    /* content */
  ]
  ```
]

#new-section-slide("Bottom bar customization")

#dslide(title: "Bottom bar", raw-font-size: 18pt)[
  #grid(columns: (auto, auto), gutter: 1cm,
    [
      `slide` API related with bottom bar:
      #v(5mm)
      ```typst
      #let slide(
        bottom-bar: false,
        bottom-bar-args: (
          height: 6mm,
          func: est-speaker-slide-reminder-bar,
          func-args: (:)
        ),
        // (other args hidden)
      ) = { /* ... */ }
      ```
    ],
    [
      `bottom-bar`:
      - `true/false`: always shown/hidden
      #v(5mm)
      inside `title-bar-args` dict:
      - `height` is the height of the bottom bar. \
        #text(fill: red, emoji.warning)
        using `em` units here can be tedious
      - `func` is the function that generates the title bar (default `func` is presented on next slide)
      - `func-args` are the additional arguments given to `func` when it is called
    ]
  )
]

#dslide(title: "Bottom bar: default function", raw-font-size: 16pt)[
  #grid(columns: (auto, auto), gutter: 2cm,
    [
      ```typst
      #let est-speaker-slide-reminder-bar(
        width, height,
        show-slide-number: false,
        text-size: .8em,
        alignment: center+horizon,
        author-text-fill-color: white,
        author-bg-color: black,
        presentation-title-text-fill-color: white,
        presentation-title-bg-color: est-blue,
        slide-number-text-fill-color: black,
        slide-number-bg-color: white,
        author: [Speaker],
        presentation-title: [Presentation title],
        slide-number:
           {logic.logical-slide.display()}
      ) = { /*...*/ }
      ```
    ],
    [
      Arguments always set by `slide` at call time:
      - `width`: the page width (`length`)
      - `height`: the bottom bar height (`length`)

      #v(1mm)

      The other arguments enable cutomization of the bar.
      Their names should be enough to explain what they do ;).
    ],
  )
]

#let struts-slide = dslide.with(
  bottom-bar: true,
  bottom-bar-args: (
    func: est-speaker-slide-reminder-bar,
    func-args: (
      author: [Jane Doe],
      presentation-title: [Estonia],
      show-slide-number: true,
    )
  )
)

#struts-slide(title: "Bottom bar: customize default function call", raw-font-size: 18pt)[
  ```typst
  #let struts-slide = slide.with(
    bottom-bar: true,
    bottom-bar-args: (
      func: est-speaker-slide-reminder-bar,
      func-args: (
        author: [Jane Doe],
        presentation-title: [Estonia],
        show-slide-number: true,
      )
    )
  )

  #struts-slide(title: "...")[
    /* content */
  ]
  ```
]

#let my-bottom-bar(width, height, font-size: .8em) = {
  block(width: width, height: height, breakable:false, inset: 3mm, {
    set align(horizon+right)
    set text(size: font-size)
    locate(loc => {
      let current_slide = logic.logical-slide.at(loc).first() - 1
      let nb_slides = logic.logical-slide.final(loc).first()
      [ #current_slide / #nb_slides ]
    })
  })
}

#dslide(title: "Bottom bar: your own function", raw-font-size: 16pt,
  bottom-bar: true,
  bottom-bar-args: (func: my-bottom-bar)
)[
  ```typst
  #let my-bottom-bar(width, height, font-size: .8em) = {
    block(width: width, height: height, breakable:false, inset: 3mm, {
      set align(horizon+right)
      set text(size: font-size)
      locate(loc => {
        let current_slide = logic.logical-slide.at(loc).first() - 1
        let nb_slides = logic.logical-slide.final(loc).first()
        [ #current_slide / #nb_slides ]
      })
    })
  }

  #slide(title: "...", bottom-bar: true, bottom-bar-args: (func: my-bottom-bar))[
    /* content */
  ]
  ```
]

#new-section-slide("Layout and margins")

#let blank-progress-bar(width, height) = {
  block(width: width, height: height, breakable: false, inset: 3mm, {
    set align(center+horizon)
    est-cell(fill:black, width:width, height: height, text(fill: white, size: .8em, [progress bar]))
  })
}

#let blank-title-bar(title, width, height) = {
  block(width: width, height: height, breakable: false, inset: 3mm, {
    set align(center+horizon)
    est-cell(fill: est-blue, width:width, height: height, text(fill: white, size: 1.2em, [title bar]))
  })
}

#let blank-bottom-bar(width, height) = {
  block(width: width, height: height, breakable: false, inset: 3mm, {
    set align(center+horizon)
    est-cell(fill:black, width:width, height: height, text(fill: white, size: .8em, [bottom bar]))
  })
}

#let my-pink = rgb("#a0ffa0")

#dslide(progress-bar: true, title-bar: true, bottom-bar: true,
  progress-bar-args: (func: blank-progress-bar),
  title-bar-args: (func: blank-title-bar),
  bottom-bar-args: (func: blank-bottom-bar)
)[
  #show: rect.with(width: 100%, height: 100%, fill: my-pink)
  #show: set align(center+horizon)
  The layout of this theme is the one presented on this slide. \
  Bars can be disabled but cannot be placed at a different position for now.

  #v(5mm)
  The green rectangle is your content bounding box. \
  Your content is by default surrounded by a 1cm border on all sides.

  #v(5mm)
  From the Typst point of view, \
  everything around your content bounding box are page margins.
]

#dslide(progress-bar: false, title-bar: false, bottom-bar: false)[
  #show: rect.with(width: 100%, height: 100%, fill: my-pink)
  #set align(left+horizon)

  If you generate a slide without any bar, your content still has borders by default.
  #v(1cm)

  ```typst
  #slide(progress-bar: false, title-bar: false, bottom-bar: false)[
    /* content */
  ]
  ```
]

#dslide(title: "slide body & margin customization")[
  #grid(columns: (auto, auto), gutter: 2cm,
    [
      Here are the remaining `slide` arguments:
      ```typst
      #let slide(
        body-args: (
          margin: 1cm,
          alignment: left+horizon,
          text-fill-color: black,
          bg-color: white),
        body
      ) = { /* ... */ }
      ```
    ],
    [
      `margin`:
      - if (`length`): all body margins set to the given value
      - if (`dict`): specify the body margin value for each margin
        - `top`, `bottom`, `left`, or `right`
        - `rest` is used if a specific value is not set
    ]
  )
]

#dslide(title: "Disable all margins", body-args: (margin: 0cm))[
  #show: rect.with(width: 100%, height: 100%, fill: my-pink)
  #show: set align(center)
  ```typst
  #slide(body-args: (margin: 0cm))[
    /* content */
  ]
  ```
]

#dslide(title: "Disable a single margin", body-args: (
  margin: (top: 0cm,
           rest: 1cm)
))[
  #show: rect.with(width: 100%, height: 100%, fill: my-pink)
  #show: set align(center)
  ```typst
  #slide(body-args: (margin: (top: 0cm,
                              rest: 1cm))
  )[
    /* content */
  ]
  ```
]

#dslide(title: "Customize all margins", bottom-bar:true, body-args: (
  margin: (top: 0cm,
           bottom: 0cm,
           left: 1cm,
           right: 2cm),
))[
  #show: rect.with(width: 100%, height: 100%, fill: my-pink)
  #show: set align(center)
  ```typst
  #slide(title: "...",
    bottom-bar: true,
    body-args: (margin: (top: 0cm,
                bottom: 0cm,
                left: 1cm,
                right: 2cm))
  )[
    /* content */
  ]
  ```
]

#focus-slide()[
  That's all folks!
]

