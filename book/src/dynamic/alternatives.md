# `#alternatives` to substitute content
The so far discussed helpers `#pause`, `#one-by-one` etc. all build upon `#uncover`.
There is an analogon to `#one-by-one` that is based on `#only`, namely
`#alternatives`.
You can use it to show some content on one subslide, then substitute it by
something else, then by something else, etc.

Consider this example:
```typ
{{#include poor-alternatives.typ:6:11}}
```
Here, we want to display three different sentences with the same structure:
Some person likes some sort of ice cream.

![poor-alternatives](poor-alternatives.png)

As you can see, the positioning of `likes` and `ice cream` moves
around in the produced slide because, for example, `Ann` takes much less space
than `Christopher` when using `#only` for that job.
This somewhat disturbs the perception of the constant structure of the sentence
and that only the names and kinds of ice cream change.

To avoid such movement and only substitute certain parts of content, you can use
the `#alternatives` function.
With it, our example becomes:
```typ
{{#include alternatives.typ:6:11}}
```
resulting in

![alternatives](alternatives.png)

`#alternatives` will put enough empty space around, for example, `Ann` such that
it uses the same amount of space as `Christopher`.
In a sense, it is like a mix of `#only` and `#uncover` with some reserving of
space.

### Repeat last content
In case you have other dynamic content on a slide that happens after the contents
of `#alternatives` are exhausted, you might want to not have the `#alternatives`
element disappear but instead continue to show its last content argument.
To achieve this, you can use the `repeat-last` parameter:
```typ
{{#include alternatives-repeat-last.typ:6:9}}
```
resulting in

![alternatives-repeat-last](alternatives-repeat-last.png)

### Positioning
By default, all elements that enter an `#alternatives` command are aligned at
the bottom left corner.
This might not always be the desired or the most pleasant way to position it, so
you can provide an optional `position` argument to `#alternatives` that takes an
[`alignment` or `2d alignment`](https://typst.app/docs/reference/layout/align/#parameters--alignment).
For example:
```typ
{{#include alternatives-position.typ:6:9}}
```
makes the mathematical terms look better positioned:

![alternatives-position](alternatives-position.png)

All functions described on this page have such a `position` argument.

Similar to `#one-by-one`, `#alternatives` also has an optional `start` argument
that works just the same.

## `#alternatives-match`
`#alternatives` has a couple of "cousins" that might be more convenient in some
situations.
The first one is `#alternatives-match` that has a name inspired by match-statements
in many functional programming languages.
The idea is that you give it a dictionary mapping from subslides to content:
```typ
{{#include alternatives-match.typ:6:9}}
```
resulting in

![alternatives-match](alternatives-match.png)

**Note** that it is your responsibility to make sure that the subslide sets are
mutually disjoint.

## `#alternatives-cases`
You can use this function if you want to have one piece of content that changes
only slightly depending of what "case" of subslides you are in.
So instead of
```typ
{{#include alternatives-cases.typ:6:14}}
```
you can avoid duplication and write
```typ
{{#include alternatives-cases.typ:18:21}}
```
using a function that maps the current "case" to content, resulting in

![alternatives-cases](alternatives-cases.png)

**Note** that the cases are 0-indexed (as are Typst arrays).


## `#alternatives-fn`
Finally, you can have very fine-grained control over the content depending on
the current subslide by using `#alternatives-fn`.
It accepts a function (hence the name) that maps the current subslide index to
some content.

Similar to `#alternatives`, it accepts an optional `start` parameter that has a
default of `1`.
`#alternatives-fn` only knows for how long to display something, though, if you
provide either the number of subslides (`count` parameter) or the last subslide
index (`end` parameter).
So exactly one of them is necessary.

For example:
```typ
{{#include alternatives-fn.typ:6:8}}
```
resulting in

![alternatives-fn](alternatives-fn.png)
