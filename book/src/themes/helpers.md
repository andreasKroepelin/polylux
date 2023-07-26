# Helpers for theme authors

Let us have a look at some common use cases you run into as a theme author and
what solutions are provided by the `helpers`  and `logic` modules inside polylux.
As a theme author, you have access to them due to the imports
```typ
#import "../logic.typ"
#import "../helpers.typ"
```
(see previous page).

## How much longer? 🥱

There are a handfull of features that let you display the progress of the
presentation.

The most simple one is directly displaying the current slide number.
Remember that each slide might produce an arbitrary amount of subslides, i.e.
PDF pages, so we cannot rely on the builtin page counter.
Instead, there is the `logical-slide` counter in the `logic` module.
Therefore, you can use
```typ
#logic.logical-slide.display()
```
to see what the current slide number is.

If you want to put that into relation to how many slides there are in total,
you can also display
```typ
#helpers.last-slide-number
```
which is a short-hand way of getting the final value of `logic.logical-slide`.

Note that both these things are content, though, so you can only display them
and not calculate with the numbers.
A common calculation you might want do to is finding their ratio, i.e. current
slide number divided by total number of slides.
To that end, you can use the function `helpers.polylux-progress`.
You can pass a function to it that turns the current ratio into some content.
For example:
```typ
#helpers.polylux-progress( ratio => [
  You already made it through #calc.round(ratio * 100) #sym.percent of the presentation!
])
```
Some themes utilise this to display a little progress bar, for example.

## Sections
Another way of expressing where we are in a presentation is working with sections.
In your theme, you can incorporate the following features from the `helpers`
module:

First, whenever a user wants to start a new section, you can call
```typ
#helpers.register-section(the-section-name)
```
with whatever name they specify.
It is up to you to decide what kind of interface you provide for the user and
how/if you visualise a new section, of course.

Based on that, you can then display what section the presenter is currently in
by using:
```typ
#helpers.current-section
```
If no section has been registered so far, this is empty content (`[]`).

And finally, you might want to display some kind of overview over all the sections.
This is achieved by:
```typ
#helpers.polylux-outline()
```
Unfortunately, it is hard to get the Typst-builtin `#outline` to work properly
with slides, partly again due to how page numbers are kind of meaningless.
`polylux-outline` is a good alternative to that and will return an `enum` with
all the registered sections (ever, not only so far, so you can safely use it
at the beginning of a presentation).

`polylux-outline` has two optional keyword arguments:
- `enum-args`: pass a dictionary that is propagated to
  [`enum` as keyword arguments](https://typst.app/docs/reference/layout/enum#parameters),
  for example `enum-args: (tight: false)`, default: `(:)`
- `padding`: pass [something that `pad` accepts](https://typst.app/docs/reference/layout/pad#parameters),
  will be used to pad the `enum`, default: `0pt`
