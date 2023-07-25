all: helloworld titleslide slidetitle quiz

helloworld:
	typst --root ../../.. compile hello-world.typ hello-world.png
	montage ./hello-world.png -geometry +50+50 -background LightGray ./hello-world.png

titleslide:
	typst --root ../../.. compile title-slide.typ title-slide-{n}.png
	montage ./title-slide-*.png -geometry +50+50 -background LightGray ./title-slide.png
	rm ./title-slide-*.png

slidetitle:
	typst --root ../../.. compile slide-title.typ slide-title-{n}.png
	montage ./slide-title-*.png -geometry +50+50 -background LightGray ./slide-title.png
	rm ./slide-title-*.png

quiz:
	typst --root ../../.. compile quiz.typ quiz-{n}.png
	montage ./quiz-*.png -geometry +50+50 -background LightGray ./quiz.png
	rm ./quiz-*.png
