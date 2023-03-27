#import "../slides.typ": *    

#set text(
    font: "DejaVu Sans",
)

#show: slides.with(
    author: "Carl Friedrich Gauß",
    short-author: "CF Gauß",
    title: "On a revolutionary way to sum up natural numbers",
    short-title: "Sum of natural numbers",
    date: "1784"
)

= Introduction

#slide[
	== Problem statement
	Let $n in NN$.
	We are interested in sums of the form
	$ 1 + ... + n = sum_(i=1)^n i $
]

#slide[
	== The theorem

	I disvovered that
	$ sum_(i=1)^n = n(n+1)/2 $

	Let's prove that!
]

= Prove

#slide[
	== Method of proof
	We will prove the theorem by induction, following these steps:

	+ base case
	+ induction hypothesis
	+ induction step
]

#slide[
	#set text(.7em)
	== Proof

	#one-by-one[
		*base case:* Let $n = 1$. Then $sum_(i=1)^1 i = (1 dot.c 2)/2 = 1$ #emoji.checkmark.heavy
	][
		*ind. hypothesis:* Let $sum_(i=1)^k i = k(k+1)/2$ for some $k >= 1$.
	][
		*ind. step:* Show that $sum_(i=1)^(k+1) i = ((k+1)(k+2))/2$
		$
			sum_(i=1)^(k+1) i &= sum_(i=1)^k i quad + quad (k+1) \
			&= k(k+1)/2 + (k+1)
			&= (k+1) dot.c (k/2 + 1)
			&= (k+1) dot.c (k/2 + 2/2)
			&= ((k+1)(k+2))/2
			#h(1em) #emoji.checkmark.heavy
		$
	]
]

= Conclusion

#slide[
	== That's it!

	Now you know how to calculate those sums more quickly, nice!
]
