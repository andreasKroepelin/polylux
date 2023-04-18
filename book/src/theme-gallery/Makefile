all: default bipartite uob

default:
	pdftoppm ./default.pdf ./default -png
	montage ./default-* -geometry +50+50 -background LightGray ./default.png
	rm ./default-*

bipartite:
	pdftoppm ./bipartite.pdf ./bipartite -png
	montage ./bipartite-* -geometry +50+50 -background LightGray ./bipartite.png
	rm ./bipartite-*

uob:
	pdftoppm ./uob.pdf ./uob -png
	montage ./uob-* -geometry +50+50 -background LightGray ./uob.png
	rm ./uob-*
