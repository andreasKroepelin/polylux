all: only-uncover rule-array

only-uncover:
	typst --root ../../.. compile only-uncover.typ only-uncover-{n}.png
	montage ./only-uncover-*.png -geometry +50+50 -background LightGray ./only-uncover.png
	rm ./only-uncover-*.png

rule-array:
	typst --root ../../.. compile rule-array.typ rule-array-{n}.png
	montage -pointsize 60 -label 'subslide %p' ./rule-array-*.png -geometry +50+50 -background LightGray ./rule-array.png
	rm ./rule-array-*.png
