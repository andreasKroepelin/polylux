# Sections
Another way of expressing where we are in a presentation is working with sections.
Usually, this is a topic that a theme will/should handle so **this page is
addressed more towards theme authors**.

In your theme, you can incorporate the following features from the `utils`
module:

First, whenever a user wants to start a new section, you can call
```typ
#utils.register-section(the-section-name)
```
with whatever name they specify.
It is up to you to decide what kind of interface you provide for the user and
how/if you visualise a new section, of course.

Based on that, you can then display what section the presenter is currently in
by using:
```typ
#utils.current-section
```
If no section has been registered so far, this is empty content (`[]`).

And finally, you might want to display some kind of overview over all the sections.
This is achieved by:
```typ
#utils.polylux-outline()
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
