In this chapter I'll show that the evidentialist version of desire as belief is consistent. At least, I'll show that it is consistent iff ordinary evidentialist decision theory is consistent. The strategy will be define a class of worlds, and a privileged class of credence-value functions over them. In particular, given the credence function, there will be precisely one value function that is in the privileged class. Then we'll define an interpretation for $\degree$ such that as long as we're in the privileged class, the evidentialist equation $V(A) = \Pr(A\degree | A)$ is bound to be satisfied. Since the underlying model is just familiar evidential decision theory, this shows that evidentialist equation can be trivialised only if ordinary decision theory can be trivialised.

The upside of this is that it shows we can show that there won't be any kind of triviality result for the evidentialist equation, since such a result would also trivialise ordinary decision theory. The downside is that it isn't clear that what the evidentialist calls $\Pr(X)$ is really a credal function; that is, it isn't clear that it really represents a doxastic state. What the formal modelling I do here estabilshes is that there is no technical objection to having actions driven by something with the mathematical properties of a probability function. But there is more to a state being doxastic than that.

The results of the section will be somewhat inconclusive. There are a couple of different ways to model the evidentialist version of desire as belief. And on both versions there are reasons to doubt that $\Pr(X)$ really represents a purely doxastic state. But these are not strong reasons, and ultimately I think these are not reasons to reject evidentialist desire as belief. Still, it's worth clearly accounting for the costs.

## Worlds as Pairs

We're going to look at two models in this chapter, and both of them take an idea set out by Richard Bradley and Christian List as their starting point [#BradleyList2009]. They suggested that the desire as belief theorist should think worlds are ordered pairs. The first member of the pair will be a specification how things are descriptively, and the second member will be a specification of how things are morally. They don't go into much more detail than that about what exactly the nature of the second element should be, and one of the things we'll spend a bit of time on is that question. But the big picture here is taken, in its entirety, from their suggestion.

We'll start with a very simple way of modelling this. Say that a world is a pair $\op{d,m}$, where $d$ is a set of descriptive facts, and $m$ is a number. Intuitively, $m$ represents how good it is that $d$ obtains. Since we're still assuming **Good-Bad**, we'll assume that $m$ is either 0 or 1. 

These pairs are worlds, so credal functions are defined over them, and propositions are sets of them. There are some special propositions within that set. Say that a proposition is **factual** if is a set $S$ such that $\op{d,1} \in S \leftrightarrow \op{d,0} \in S$. That is, if $S$ is consistent with the facts being a certain way, then it is also consistent with any evaluation of those facts. We don't, on this approach, have a nice way to represent a purely moral proposition, but we have the factual propositions, and they will play a special role in what follows.

The privileged classes of credence-value pairs are just those where $V(\op{d,m}) = m$, for any $d, m$. I'm not sure it is right to call this view _Desire by Necessity_, as [#Lewis1996b;] does, since we aren't assuming that all $V$ satisfy this constraint. But we are assuming there is something particularly good about satisfying the constraint. 

The class of credence-value pairs that satisfy the constraint have some other nice properties. If we extend $V$ from a valuation on worlds to a valuation on propositions in the normal way, and assume that updating on factual propositions is by conditionalisation, then we can ensure **Invariance**, **Addition** and **Restricted Conditionalisation** are satisfied. Of course, we get those conditions to be satsified more or less by stipulation. So the fact that they are satisfied in the model is not any kind of evidence that they are good constraints. But if we had independent reason to endorse them, and I think we do, then it is nice that they are satisfied.

There is something else nice we can do with this model. Take any familiar credence-value pair, defined only over 'descriptive' worlds, and with bounded values. That is, the inputs to the familiar pair are factual propositions. Since value functions are only defined up to positive affine transformation, we can rescale the value function so its upper bound is 1, and its lower bound is 0. Call the credal and value functions we now have $\Pr_O$ and $\V_O$, where the $O$ is for 'Old'. We can define new functions $\Pr_N$ and $V_N$ as follows.

\\[
\Pr{_N}(\op{d,1}) = \Pr{_O}(d)V{_O}(d) \\
V{_N}(\op{d,1}) = 1 \\
\Pr{_N}(\op{d,0}) = \Pr{_O}(d)(1-V{_O}(d)) \\
V{_N}(\op{d,0}) = 1 \\
\\]

The new function will be in the privileged class, will keep the value of any descriptive proposition unchanged, and will satisfy **Restricted Conditionalisation** as long as the old functions were updated by conditionalisation. 

And pretty clearly you can do this trick in the reverse direction too. Given a function defined over 
