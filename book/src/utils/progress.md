# How much longer? 🥱

There are a handful of features that let you display the progress of the
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
#utils.last-slide-number
```
which is a short-hand way of getting the final value of `logic.logical-slide`.

Note that both these things are content, though, so you can only display them
and not calculate with the numbers.
A common calculation you might want do to is finding their ratio, i.e. current
slide number divided by total number of slides.
To that end, you can use the function `utils.polylux-progress`.
You can pass a function to it that turns the current ratio into some content.
For example:
```typ
#utils.polylux-progress( ratio => [
  You already made it through #calc.round(ratio * 100) #sym.percent of the presentation!
])
```
Some themes utilise this to display a little progress bar, for example.
