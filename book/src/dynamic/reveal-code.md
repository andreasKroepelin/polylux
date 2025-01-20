# Succesively uncover code

Since Typst has great builtin support for typesetting code, Polylux wants to
provide a convenience feature for this as well.
Namely, the function `#reveal-code` takes a code block and splits it into
parts shown on different subslides.

As an example:
```typ
{{#include reveal-code.typ:6:16}}
```
![reveal-code](reveal-code.png)

As we can see, the code is revealed up to the first, third, sixth, and then
seventh row on each new subslide.
Every line that has already been previously revealed is shown in gray.
Afterwards, the whole code is shown without alterations.

# Configuration
