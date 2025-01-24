# Succesively uncover code

Since Typst has great builtin support for typesetting code, Polylux wants to
provide a convenience feature for this as well.
Namely, the function `#reveal-code` takes a code block and splits it into
parts shown on different subslides.

As an example:
```typ
{{#include reveal-code.typ:6:16}}
```
![reveal-code](reveal-code.png)

As we can see, the code is revealed up to the first, third, sixth, and then
seventh row on each new subslide.
Every line that has already been previously revealed is shown in gray.
Afterwards, the whole code is shown without alterations.

## Configuration

You can configure a couple of things about `reveal-code`:

### Show the whole code in the end

As demonstrated above, this is the default behaviour.
If you don't want that, use the option `full: false` like so:
````typ
#reveal-code(lines: (2, 4), full: false)[```
  first line
  second line
  third line
  fourth line
  fifth line
```]
````

### What to do with previous and future lines

By default, previously uncovered lines are shown in gray and not yet uncovered
lines are hidden.
This can be controlled using the `before` and `after` options.
Like the [cover mode for other functions](./cover.md), these accept either
`hide` or any color.
The default is thus `before: gray` and `after: hide`.

### First subslide

Similar to [here](./obo-lbl.md), there is also a `start` option to specify the
first subslide where code is revealed.
