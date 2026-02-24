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



Quantifiers Section

There are two distinctive features of the way that I introduced quantifiers in @sec-formal. First, I introduced the universal quantifier as basic, and simply defined $\exists$ as $\neg \forall \neg$. Second, I introduced the universal quantifier as _possibilist_, at least in the sense that it ranges over all objects in a possibility and all its refinements. As I noted, there is a passing remark in "From Worlds to Possibilities" where Humberstone suggests that is how he would do it. It's worth going over why this ends up being the best way to do things.

The aim here, as it was in @sec-formal, was to keep classical logic while still using things, like incomplete possibilities, which are usually taken to be incompatible with classical logic. But in this section the primary contrast is not with non-classical propositional logics, but with free logics. In classical logic, this argument looks fairly compelling.

\begin{align*}
1. && a = a && \text{=Intro} \\
2. && \exists x(x = a) && \exists\text{-Introduction} \\
3. && \Box \exists x(x = a) && \text{Necessitation} \\
4. && \forall y \Box \exists x(x = y) && \forall-\text{Introduction}
5. && \Box \forall y \Box \exists x(x = y) && \text{Necessitation}
\end{align*}

That is, for every thing, necessarily every object is such that necessarily, something is identical to it. If we are working in a possible worlds framework, and assume that the modal logic we're using is at least as strong as **KTB**, that just about implies that all worlds have the same domain. Strictly speaking, it's consistent with there being worlds with distinct domains which are not connected by the ancestral of $R$, but any world that could be relevant to the truth of any sentence, must have the same domain.

In the possibilities framework, we have a bit more flexibility while still making claims like $\Box \forall y \Box \exists x(x = y)$ come out true. One option would be to say that all refinements, and indeed all accessible possibilities, have the same domain, and have quantifiers just range over objects within a possibility. This would be a nice way to handle quantifiers, but having all possibilities have the same domain would be seriously unintuitive. Some stories have more characters than others. It feels 

