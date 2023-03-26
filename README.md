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
With that setup, you can create slides in two ways:
### 2nd level headings:
```typ
== A slide
Some text

== Another slide
More text
```
Every heading of level 2 starts a new slide, simple as that.

### `#slide` function
```typ
#slide[
  We do not need a special heading here.
  == But we can ...
  ... and it doesn't produce new slides here.
]

#slide[
  Another slide
]
```
So far, both options behave just the same.

And that's all in principle!
If you'd like, there are two more features for you to use, however.

## Sections

To give your audience some orientation where you currently are in your talk,
you can use 1st level headings to introduce sections:
```typ
= Introduction
```
These are not displayed themselves but update a small text on each slide's header.

## Dynamic slides
This template offers basic support for dynamic slides with changing content.
That means you can show or hide parts of a slide at different points in time.
Using this feature requires using the `#slide` function.
To restrict the visiblity of content to certain "subslides", use one of the
following function:

- `#only(2)[content]`: content is only visible on 2nd subslide
- `#until(3)[content]`: content is only visible on 1st, 2nd, and 3rd subslide
- `#beginning(2)[content]`: content is visible from the 2nd subslide onwards
- `#one-by-one(start: 2)[one][two][three]`: uncover `one` on the 2nd slide, then
  `two` on the 3rd slide, and then `three` on the 4th slide. You can specify an
   arbitrary number of contents. The `start` argument is optional.
   `#one-by-one[x][y]` will uncover `x` on the first subslide.

Let's see this in action:
```typ
#slide[
  always visible
  #only(1)[only visible on the first subslide]
  #beginning(2)[only visible on the second subslide]
]
```

The number of subslides (number of PDF pages produced) one logical slide is
converted two depends on the highest subslide index you specified content to
appear or disappear.


Note that in the produces slides in the PDF the page number does not change during
a multislide.

## Expample
An example document using this template can be found [here](examples/doc.typ).
Its output should look like this:

![title slide](assets/title-slide.png)
![first slide](assets/first-slide.png)
![multislide](assets/multislide.png)
