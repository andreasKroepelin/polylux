# Sections

To give your audience some orientation where you are in your presentation,
you can use sections.
The [default theme](./theme-gallery/index.html#default) displays the section in
the header of each slide, other themes might use other ways to display it.

To define the current section, simply use `#new-section`:
```typ
#new-section("Introduction")

#slide(title: "First slide of introduction")[
  Look at the header!
]

#slide(title: "Second slide of introduction")[
  Header hasn't changed.
]

#new-section("Motivation")

#slide(title: "And now?")[
  Now, we are in the _motivation_ section.
]
```
