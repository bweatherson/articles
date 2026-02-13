In HoPF.qmd, the section "Logics Definable on Humberstone Frames" should include this content

- In Holliday's-question.txt, there is a question about which inclusion is strict. We need to summarise what question Holliday is asking here.
- We are not going to answer the question precisely as asked. But we can answer a related question. If we expand the language to include infintary disjunction, then the first inclusion is strict. That is, there are logics definable on Humberstone frames but not definable on Kripke frames.
- In fact we will just use a single frame. It consists of two copies of the set of finite binary sequences. For each finite binary sequence, say we have a left-handed version and a right-handed version. The refinement relation is that $x \leqslant y$ iff $x$ and $y$ have the same handedness, and $x$ is an initial segment of $y$.
- We now define two infinite classes of accessibility relations.
- The first class goes from left-to-right. $xR^{\rightarrow}_{k}y$ iff $x$ is left-handed, $y$ is right-handed, $y$ is of length at least $k$, and $x$ is either an initial segment of $y$, or the first $k$ elements of $x$ are an initial segment of $y$. This is defined for $k \geqslant 0$. The special case of $k = 0$ just means $x$ is left-handed and $y$ is right-handed.
- Here's how to picture $R^{\rightarrow}_{k}$. Each of the sets of sequences, the left-handed and right-handed, form trees in a familiar way. Imagine there are bridges between the left-handed and right-handed trees when the sequences are identical and of length $k$. Then $xR^{\rightarrow}_{k}y$ if there is a path from the top to bottom of the tree that starts with $x$, takes a bridge, and continues along (and beyond) $y$.
- We need to show this definition satisfies all three Humberstone constraints.
- The second class goes from right-to-left. $xR^{\leftarrow}_{k}y$ if $x$ is right-handed, and does not have 0 in its $k$'th position, either because it is length less than $k$, or because it has one there, and $y$ is left-handed. This is defined for $k > 0$
- We again need to show that this definition also satisfies all three of the Humberstone constraints.
