# Themes

As we have already discussed, you can use polylux completely without using
themes.
For most users, themes will simplify their preparation of decent slides quite a
bit, however.
So let's take a look at how they work.

It is important to note that polylux does not define a specific way a theme *has*
to work.
Similarly, if you define your own slide layout, don't feel obliged to do it in 
any way related to how the provided themes do it.
To improve the user experience and avoid having to learn everything anew when
switching to another theme, the existing themes all follow a certain convention,
though.

## The theme convention

First of all, all themes reside in the `themes` module inside polylux.
That means, if you want to employ, say, the `simple` theme, you add the following
to your regular `#import` line at the top:
```typ
#import "@preview/polylux:0.2.0": *
#import themes.simple: *
```

Next, a theme usually provides some **initialisation function** that has a name
ending in `-theme`.
It is supposed to be used in a `#show: ...` rule, i.e. (again for the `simple`
theme):
```typ
#show: simple-theme.with(...)
```
Inside the `with()`, you can set some theme-specific configuration.
Here you find options that concern the whole presentation, such as the aspect
ratio of your slides.

Speaking of which, when you use a theme, you do not have to set the paper size
yourself anymore, such things are handled by the theme (the convention is that
every theme has an `aspect-ratio` keyword for its initialisation function that
can be set to `"16-9"` or `"4-3"`).

The other major feature of themes is that they usually come with **custom slide
functions**.
That means that you will *not* use the `#polylux-slide` function!
It is called under the hood by the wrapper functions from the theme.

To be more accurate:
Nothing stops you from still calling `#polylux-slide` and you can always build
something custom along the "regular" theme-slides if you are not satisfied with
what a theme offers you.
It's just that you usually will not have to do this.

The range of theme-specific slide functions varies from theme to theme but there
is again one convention:
A theme usually has a `#title-slide` function for, well, the title slide and a
`#slide` function that you will use for "normal" slides.

Each of these functions might accept some keyword arguments and/or one or
multiple content blocks to define what is supposed to be seen on the slide.
