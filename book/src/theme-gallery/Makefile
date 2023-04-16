all: default bipartite

default:
	pdftoppm ./default.pdf ./default -png
	montage ./default-* -geometry +50+50 -background LightGray ./default.png
	rm ./default-*

bipartite:
	pdftoppm ./bipartite.pdf ./bipartite -png
	montage ./bipartite-* -geometry +50+50 -background LightGray ./bipartite.png
	rm ./bipartite-*
