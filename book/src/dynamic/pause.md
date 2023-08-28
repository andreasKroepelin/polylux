# `pause` to reveal content piece by piece
Consider some code like the following:
```typ
#uncover("1-")[first]

#uncover("2-")[second]

#uncover("3-")[third]
```
The goal here is to uncover parts of the slide one by one, so that an increasing
amount of content is shown, but we don't want to specify all subslide indices
manually, ideally.

If you have used the LaTeX beamer package before, you might be familiar with the
`\pause` command.
It makes everything after it on that slide appear on the next subslide.
In Polylux, this works very similar with `#pause`, so we can equivalently write
the above code as:
```typ
{{#include pause.typ:6:10}}
```
This results in

![pause](pause.png)

`#pause` should mainly be used when you want to distribute a lot of code onto
different subslides.
Note that it does not affect content in the same paragraph as itself, for example.
For smaller pieces of code, consider one of the functions described next.
