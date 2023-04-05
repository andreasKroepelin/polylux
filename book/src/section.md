# Sections

In the header of each slide, you can display the current section to give your
audience some orientation where you are in your presentation.

To define the current section, simply use `#new-section`:
```typ
#new-section("Introduction")

#slide[
  == First slide of introduction
  Look at the header!
]

#slide[
  == Second slide of introduction
  Header hasn't changed.
]

#new-slide("Motivation")

#slide[
  == And now?
  Now, we are in the _motivation_ section.
]
```
