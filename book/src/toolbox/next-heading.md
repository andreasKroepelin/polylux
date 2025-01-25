# Find next heading

It can be very convenient to specify something like slide titles using headings
as they have a dedicated Typst syntax.
While it might suffice to just style how a heading is displayed using a show
rule, this is not feasible when the slide title is supposed to be part of the
page header, for example.

For these situations, the toolbox provides `#toolbox.next-heading`.
It takes a function mapping the body of the first heading on the same page (if
it exists) to some content.

The intended use is as such:

```typ
{{#include next-heading.typ:4:100}}
```
![next-heading](next-heading.png)

Note the extra show rule for level-one headings making them invisible.

You can make `#toolbox.next-heading` look for headings of other levels as well,
just specify the optional `level` argument that defaults to `1`.
