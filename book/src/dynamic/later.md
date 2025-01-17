# `show: later` to reveal content piece by piece
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
Features of the kind "everything after this" are handled in Typst using the
`#show:` feature.
Namely, `#show: some-function` uses the following content as an argument to
`some-function`.
Polylux provides the `later` function that makes its argument appear on the
next subslide.
So, we can equivalently write the above code as:
```typ
{{#include later.typ:6:10}}
```
This results in

![later](later.png)

`#show: later` should mainly be used when you want to distribute a lot of code
onto different subslides.
For smaller pieces of code, consider one of the functions described next.
