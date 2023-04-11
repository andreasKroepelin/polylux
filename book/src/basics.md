# Basics

This template allows you to produce presentation slides in
[Typst](https://typst.app), just like you would use the _beamer_ package in LaTeX.
(So far, it is much less advanced than beamer, obviously.)

There are two main building blocks, the functions `slides` and `slide`.
The first one, `slides` allows you to set up a document such that the PDF can
be used as a presentation.
As a rule of thumb, one slide becomes one PDF page, and most PDF viewers can
display PDFs in the form of a slide show (usually by hitting the F5-key).
The second function, `slide`, produces a single slide.
This means that your code will be structured like this when using this template:
```typ
#import "slides.typ": *

#show: slides.with( /* configuration */ )

#slide[
  First slide
]

#slide[
  Second slide
]

#slide[
  Third slide
]

// ...
```