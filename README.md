# Slides in Typst
This is a template for creating slides in [Typst](https://typst.app/).

It is pretty easy to get started:
```typ
#import "slides.typ": *

#show: slides.with(
    author: "Names of author(s)",
    short-author: "Shorter version for slide footer",
    title: "Title of the presentation",
    short-title: "Shorter version for slide footer",
    date: "March 2023",
    color: teal // teal is the default value, you can use any other color
)
```
With that setup, you can create slides by defining 2nd level headings:
```typ
== A slide
Some text

== Another slide
More text
```

That's all in principle!
If you'd like, there are two more features for you to use, however.

## Sections

To give your audience some orientation where you currently are in your talk,
you can use 1st level headings to introduce sections:
```typ
= Introduction
```
These are not displayed themselves but update a small text on each slide's header.

## Multislides
This template even offers basic support for dynamic slides with changing content.
That means you can show or hide parts of a slide at different points in time.
To create such a "multislide" (named as such because one logical slides is compiled
into multiple PDF pages), you can use the `#multislide` function:
```typ
#multislide(2, tools => [
    == A multislide

    #(tools.only-first)[This is only visible on the first subslide.]
    #(tools.only-second)[This is only visible on the second subslide.]
])
```
The first argument to `#multislide` is the number of "subslides" you want it to
produce (`2` in this case).
Afterwards you specify an anonymous function that returns the slide's content.
Its argument (which you can call as you like, I find `tools` sensible) provides
you with different functions that you can use to define the visibility of elements.
These are your options:

- `#(tools.only)(13)[content]`: shows content only on the 13th subslide
- `#(tools.only-first)[content]`, `#(tools.only-second)[content]`, and
  `#(tools.only-first)[content]`: convenience abbreviations for `only`
- `#(tools.until)(5)[content]`: shows content for the subslides 1 to 5
- `#(tools.beginning(2)[content]`: shows content from the 2nd subslide on
- `#(tools.one-by-one-list)[one][two][three]`: shows bullet list with items `one`,
  `two`, and `three` and uncovers one at a time
- `#(tools.one-by-one-enum)[one][two][three]`: like the one above, but produces
   an enumeration (Both implicitly uncover the first item on the first subslide,
   you can specify `#(tools.one-by-one-enum)(start: 3)[one][two][three]`) to make
   the first item be uncovered on the third subslide.)
- `#tools.amount`: returns the total number of subslides in this multislide as
   specified by the user

`#multislide` has an optional argument `mode` that can be either `"hide"` (default)
or `"mute"`.
With `mode` set to `"mute"` the hidden content is not really hidden but instead
displayed in a light gray.
Use it as follows:
```typ
#multislide(3, mode: "mute", tools => [
    slide content
])
```

Note that in the produces slides in the PDF the page number does not change during
a multislide.

## Expample
An example document using this template can be found [here](examples/doc.typ).
Its output should look like this:
