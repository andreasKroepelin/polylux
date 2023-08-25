#import "../polylux.typ": *    

#import themes.clean: *

#set text(font: "Source Sans 3")
#show math.equation: set text(font: "GFS Neohellenic Math")

#show: clean-theme.with(
	footer: [Sum of natural numbers, CF Gauß],
)

#pdfpc.config(
	duration-minutes: 15,
	start-time: datetime(hour: 8, minute: 15, second: 0),
	note-font-size: 5,
	default-transition: (type: "push", duration-seconds: 0.3),
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
	#pdfpc.speaker-note("Remember to explain Sigma notation!")
]

#slide(title: "The theorem")[

	I discovered that
	$ sum_(i=1)^n i = n(n+1)/2 $

	Let's prove that!
	#pdfpc.save-slide
]

#new-section-slide("Proof")

#slide(title: "Method of proof")[
	We will prove the theorem by induction, following these steps:

	+ base case
	+ induction hypothesis
	+ induction step

	#pdfpc.hidden-slide
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

	#pdfpc.speaker-note(```md
# How the last steps work
We use _basic algebra_ rules for the last steps.
	```)
]

#focus-slide[
	Proof is over, wake up!
]

#new-section-slide("Conclusion")

#slide(title: "That's it!")[

	Now you know how to calculate those sums more quickly. Nice!

	#pdfpc.end-slide
]

#slide(title: [Further references])[
	If you want to learn more about this cool kind of math, you can start your
	investigation here: https://en.wikipedia.org/wiki/Carl_Friedrich_Gauss
]
