# Cover mode
Covered content (using `#uncover`, `#one-by-one`, `#item-by-item`, or
`#show: later`) is completely invisible, by default.
You can decide to make it visible but less prominent using the optional `mode`
argument to each of those functions.
The `mode` argument takes two kinds of values: `hide` (the default) or any
color.
When using a color as the mode, text is printed in that color.

Use it as follows:
```typ
{{#include cover.typ:6:16}}
```
resulting in

![cover](cover.png)

**Warning!**
The "color mode" really only wraps the covered content in a
```typ
#text(fill: mode)[...]
```
so it has only limited control over the actual display.
Especially
- text that defines its own color (e.g. syntax highlighting),
- visualisations,
- images

will not be affected by that.
This makes the color mode only somewhat useful today.
([Relevant GitHub issue](https://github.com/andreasKroepelin/polylux/issues/17))
