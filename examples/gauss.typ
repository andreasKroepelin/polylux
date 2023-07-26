#import "../polylux.typ": *    

#import themes.clean: *

#set text(font: "Source Sans 3")
#show math.equation: set text(font: "GFS Neohellenic Math")

#show: clean-theme.with(
	footer: [Sum of natural numbers, CF Gauß],
)

#title-slide(
	authors: "Carl Friedrich Gauß",
	title: [On a revolutionary way to \ sum up natural numbers],
	subtitle: "What they won't teach you in school",
	date: "1784",
)

#new-section-slide("Introduction")

#slide(title: "Problem statement")[
	Let $n in NN$.
	We are interested in sums of the form
	$ 1 + ... + n = sum_(i=1)^n i $
]

#slide(title: "The theorem")[

	I discovered that
	$ sum_(i=1)^n i = n(n+1)/2 $

	Let's prove that!
]

#new-section-slide("Proof")

#slide(title: "Method of proof")[
	We will prove the theorem by induction, following these steps:

	+ base case
	+ induction hypothesis
	+ induction step
]

#slide(title: "Proof")[
	#set text(.7em)

	#one-by-one[
		*base case:* Let $n = 1$. Then $sum_(i=1)^1 i = (1 dot.c 2)/2 = 1$ $checkmark$

	][
		*ind. hypothesis:* Let $sum_(i=1)^k i = k(k+1)/2$ for some $k >= 1$.

	][
		*ind. step:* Show that
		$sum_(i=1)^(k+1) i = ((k+1)(k+2))/2$

		$sum_(i=1)^(k+1) i = sum_(i=1)^k i quad + quad (k+1)$
	][
		$= k(k+1)/2 + (k+1)$
	][
		$= (k+1) dot.c (k/2 + 1)
		= (k+1) dot.c (k/2 + 2/2)
		= ((k+1)(k+2))/2
		#h(1em) checkmark$
	]
]

#focus-slide[
	Proof is over, wake up!
]

#new-section-slide("Conclusion")

#slide(title: "That's it!")[

	Now you know how to calculate those sums more quickly. Nice!
]
