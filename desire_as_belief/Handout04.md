title:              Russell and Hawthorne’s Argument
author:             Brian Weatherson
date:               May 27, 2018
base header level:	3
LaTeX Mode:          Article
latex leader:         ../styles/handout-leader
latex begin:         ../styles/handout-begin

Let's assume that we want moral uncertainty to play an important role in decision making. We should be able to provide some kind of semantics for claims about moral uncertainty. In particular, we would like a semantics for claims of the form _A is better than B_ that satisfies the following four constraints.

1. Claims like _A is better than B_ should be the kind of thing that can be believed, and that one can have higher or lower credences in. So that claim should be associated with a set of worlds, or a set of n-tuples, where the first member of that tuple is a world. (The latter disjunction is relevant if one thinks, perhaps following Lewis on de se belief, that the objects of belief are something like centred worlds.)
2. These attitudes in moral 'propositions' (or whatever else is picked out by _A is better than B_) should be updated in the way that credal attitudes are usually updated. Ideally that would be by conditionalisation, or by some other update rule that can be given independent motivation.
3. The semantics should associate with _A is better than B_ a set of worlds (or tuples or whatever) that at least roughly corresponds with what those words ordinarily mean in English.
4. The claim should be action guiding, so (perhaps barring exceptional circumstances) conditional on _A  is better than B_, _A_ should be more choice-worthy than _B_.

And it turns out to be incredibly hard to find a semantics that satisfies these four constraints. In fact, there are principled reasons to think that no such semantics is possible. 

There is one technical complication that we need to address first. Whether _A_ is better than _B_ depends on one's evidence. So if _A_ is that I get a (typical) lottery ticket, and _B_ is that I get a penny, then _A_ is better than _B_, from my perspective, iff I don't know that _A_ is a losing ticket. It is far from trivial to represent claims about what one's evidence is in a semantic model. That's in part because facts about what one's evidence is are 'first-personal' facts that are tricky to represent in standard models, and in part because what one's evidence is changes over time, and it's hard to represent changes over time in standard models. 

Here's how I'll try to deal with, or at least sidestep, these problems. Instead of thinking of beliefs as attitudes to sets of worlds, we'll think of them as attitudes to world-evidence-morality triples: $\langle w, k, m \rangle$. And we'll assume that $k$ determines (perhaps among many other things) a function from times to one's evidence at that time. Just how it does that, and just how it attitudes distributed over $k$ are updated, will be left as a black-box. 

I'll assume $m$ is just a number, perhaps subject to enough constraints that we don't end up in the paradoxes of unbounded utility. And what we want is that the value of a proposition is the expected value of $m$ given that the proposition is true. So _A_ is better than _B_, given some evidence, just in case the expected value of $m$ given _A_ and that evidence is greater than the expected value of $m$ given _B_ and that evidence. But expected values change with evidence, and evidence changes with time, so this doesn't settle what $m$ should be. It turns out that while there are a few ways one could go here, any choice ends up violating one of the four constraints I proposed.

Assume, first, that the evidence is highly malleable. I mean two things by that. One is that when we conditionalise on some factual proposition $C$, then $C$ gets added to the evidence. The other is that the time in question (and remember that $k$ is a function from times to evidence sets) is the time any relevant decision has to be made. This pair of assumptions has a very nice feature - it guarantees that the fourth constraint is met. (This turns out to be harder to do than you might think.) Conditional on _A is better than B_, thus interpreted, I should choose _A_ over _B_, no matter what the other evidence is.

The problem with this assumption is that it violates the third constraint rather dramatically. The following example is a version of the objection that Russell and Hawthorne (2016) make to the principle they call **Comparative Value**. Consider the following substitutions for _A_ and _B_.

A1
:    I get a can of frosty ice-cold Foster's Lager in five minutes time.

B1
:    I get a poke in the eye with a burnt stick in five minutes time.

I think that **A1** is better than **B1**. And I even think that conditional on them both being true, which I hope they aren't. But on this model, we can't have that. Because conditional on them both being true, the expected value of $m$ conditional on either of them is the same as the expected value $m$ simpliciter. So conditional on their both being true, it isn't true that **A1** is better than **B1**.

This is already a violation of constraint 3. But as Russell and Hawthorne go on to point out, a lot of strange things start to follow if we don't want to violate constraint 2 as well. We just proved that conditional on **A1** $\wedge$ **B1**, it must be false that **A1** is better than **B1**. That is, conditional on **A1** $\wedge$ **B1**, the probability of **A1** is better than **B1** must be 0. If the way to update on **A1** $\wedge$ **B1** is by conditionalisation, it follows that the current probability of the conjunction of **A1**, **B1** and **A1** is better than **B1** must be 0. So conditional on **A1** is better than **B1**, which is surely true, the conjunction of **A1** and **B1** must have probability 0. And that's true for any _A, B_ such that right now it's known that _A_ is better than _B_. This is all absurd. Now perhaps this isn't a violation of constraint 2, because I'm assuming here that update is by conditionalisation, and maybe there is a principled way to reject that in cases like this. In any case, this option for how to understand $k$ fails constraint 3, so it must be wrong.

The way this option failed suggested a distinct move. What's true about **A1** and **B1** is not that given they are both true, **A1** will make the world better than **B1** will. After all, given they are both true, they won't make any (further) difference to the world. So perhaps when assessing **A1** and **B1** for value, we should look at their initial value, or their value given the (absolutely) prior probability. 

The problem with this approach is that it doesn't allow learning. Assume we learn _C_, than if I get poked in the eye with a burnt stick in five minutes, then malaria will be cured. Then it would be false that **A1** is better than **B1**, and indeed true that **B1** is better than **A1**. (Although, owww!) So this approach also violates constraint 3. And, for the same reason, it violates constraint 4.

Maybe the approach is to rigidify. What it means to say that _A is better than B_ is that given the actual evidence I currently have, _A_ has a higher expected $m$ value than _B_. This will handle the the Foster's/poke case fairly well. But it leads to other problems. The following is a simple variant of the Rembrant case Russell and Hawthorne (2016, 331) offer.

Imagine we're in a simple dart case. (I’ll go over these on the board.) When a dart lands on $\langle x, y \rangle$, then each of the five possibilities that it is on that very spot, or that it is one spot up, down, left or right are equally likely. And the dart did in fact land on $\langle 8, 3 \rangle$. At the same time, two fair coins have been tossed, although the results of them are hidden. Now compare the following options:

A2
:    I get a Vegemite sandwich if the dart landed on $\langle 8, 4 \rangle$, $\langle 8, 2 \rangle$, $\langle 7, 3 \rangle$ or $\langle 9, 3 \rangle$, and nothing otherwise.

B2
:    I get a Vegemite sandwich if at least one of the coins landed heads, and nothing otherwise.

Right now **A2** is better than **B2**. That's because given my evidence, **A2** gets me a 0.8 chance of a Vegemite sandwich, and **B2** gets me a 0.75 chance. (Assuming, as is completely obvious, that more Vegemite sandwiches are better than fewer.) But conditional on **A2** is better than **B2**, I should prefer **B2**. That's because the only worlds where **A2** is better than **B2** are worlds where the dart landed on $\langle 8, 3 \rangle$. And in those worlds, I don't get a Vegemite sandwich from **A2**.

So this rigid interpretation of 'better' violates constraint 4: it makes betterness judgments not be action guiding. I prefer **A2** to **B2**, but conditional on **A2** being better than **B2**, I prefer **B2**. Personally, I think this is the best interpretation of 'better', but that's because I think our choices shouldn't be guided by our beliefs about, or our evidence about, what's better than what. 

I haven't given a watertight proof here that there is no way to interpret 'better' in this kind of model, or any other kind of model, that satisfies the four constraints. But philosophers who think moral uncertainty matters for decision making haven't typically appreciated how hard it is to get a model that does satisfy these constraints. The 'desire as belief' results are fairly surprising, and when combined with anti-luminosity principles, they make it very hard to see how moral uncertainty could be relevant to decision making.
