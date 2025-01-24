# How much longer? 🥱

There are a handful of features that let you display the progress of the
presentation.

The most simple one is directly displaying the current slide number.
Remember that each slide might produce an arbitrary amount of subslides, i.e.
PDF pages, so we cannot rely on the builtin page counter.
Instead, there is `#toolbox.slide-number` to see what the current slide number
is.

If you want to put that into relation to how many slides there are in total,
you can also display `#toolbox.last-slide-number`.

Note that both these things are content, though, so you can only display them
and not calculate with the numbers.
A common calculation you might want do to is finding their ratio, i.e. current
slide number divided by total number of slides.
To that end, you can use the function `toolbox.progress`.
You can pass a function to it that turns the current ratio into some content.
You might utilise this to display a little progress bar, for example:

```typ
{{#include progress.typ:6:24}}
```
![progress](progress.png)
