simple:
	typst --root .. compile ../examples/simple.typ ./simple-{n}.png
	montage ./simple-* -geometry +50+50 -background LightGray ./simple.png
	rm ./simple-*

minimal:
	typst --root .. compile ../examples/minimal.typ ./minimal-{n}.png
	montage ./minimal-* -geometry +50+50 -background LightGray ./minimal.png
	rm ./minimal-*
