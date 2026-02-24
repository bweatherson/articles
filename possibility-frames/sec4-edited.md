# Conditionals {#sec-conditionals}

The only discussion of possibilities (as opposed to worlds) in *The Connectives* is in the chapter on disjunction. But there are several potential connections to conditionals, and in this section I'll go over a couple of them.

One connection concerns Conditional Excluded Middle (as discussed on pages 1008--1013 of *The Connectives*), and more generally the relationship between $A \boxright (B \vee C)$ and $(A \boxright B) \vee (A \boxright C)$. On a Stalnaker–Lewis style approach to conditionals, these are equivalent iff there is a nearest possible world in which $A$ is true, for any possible $A$. It is natural to think about whether that is true in largely metaphysical terms, asking whether there really is guaranteed to be a single nearest world where $A$ is true. And as @Lewis1973a argued, it is natural to answer that question negatively.

To take one striking example of that, consider the discussion by Jeremy @Goodmanms of the example, originally due to Max @Black1952a, of the two spheres alone in space. Black says that the spheres are really two, so this is a counterexample to the Principle of Identity of Indiscernibles. Let's assume, for now, that Black is right, and we can call one sphere $a$ and the other sphere $b$. Goodman asks what we should say about the counterfactual possibility that one of the spheres is heavier. On Lewis's picture, rejecting Conditional Excluded Middle, both (@goodmana) and (@goodmanb) are false.

(@goodmana) If one of the spheres were heavier, it would be $a$.
(@goodmanb) If one of the spheres were heavier, it would be $b$.

A common thought at this point is that this verdict really does follow from Lewis's 'nearest possible world' semantics for conditionals, but that data about the inferential role of conditionals shows that Conditional Excluded Middle must be correct.^[For a recent statement of this last view, with many more citations to similar statements, see @CarianiGoldstein2020.] This is, many think, a problem for the Lewisian view.

One move here, discussed by @Humberstone2011 [1011], is to use supervaluations. Perhaps it is in some sense indeterminate whether the world where $a$ is heavier or the world where $b$ is heavier is more like actuality. A related, but I think preferable, move is to analyse conditionals not in terms of possible worlds, but in terms of possibilities.

Here is one possible way to analyse conditionals, mixing Stalnaker's approach with Humberstone's possibilities. (The particular formulation I'm going to use draws heavily on the theory presented by Andrew @Bacon2023 [382]. The four conditions are directly quoted from his paper, though I mean something different by them since on my version the variables pick out possibilities, not worlds. I'll have more to say about Bacon's paper presently.) Extend a possibility model $\langle W, \leqslant, V \rangle$ to a conditional possibility model by adding a selection function $f$. This is a function $\mathcal{P}(W) \times W \rightarrow \mathcal{P}(W)$, intuitively picking out the 'nearest' possibilities to a world where a particular proposition is true, satisfying these constraints.^[Humberstone uses $R$ rather than $f$ for the same idea; I'm going to follow Bacon, who in turn follows Stalnaker, to highlight the connection to theories that validate Conditional Excluded Middle.]

**MP**
:   $x \in f(A, x)$ whenever $x \in A$

**ID**
:   $f(A, x) \subseteq A$

**CEM**
:   $|f(A, x)| \leq 1$

**AB**
:   If $f(A, x) \subseteq B$ and $f(B, x) \subseteq A$, then $f(A, x) = f(B, x)$

The cardinality constraint **CEM** guarantees that Conditional Excluded Middle will hold. But we don't have to make invidious choices about whether the nearest possibility where one of the spheres is heavier makes $a$ or $b$ heavier. Rather, we just say that the nearest possibility is an unrefined possibility that makes the disjunctive proposition _One of them is heavier_ true, without making either disjunct true. It will have refinements where each is true, but the nearest possibility will not validate either disjunct. This seems like an intuitive treatment of the case.

Goodman uses this example to argue that Black was incorrect, and the spheres are in fact discernible. His argument is that one but not the other will have the property of being the one that would be heavier if they were different. I don't think this argument goes through on the possibilities framework, but settling that would require saying more about how higher-order quantification works in the possibilities framework, and that would take us too far afield. Instead I'll turn to the puzzle that Bacon introduces his conditions to solve. That is a puzzle, introduced by Kit Fine [-@Fine2012a; -@Fine2012b], which is a counterfactual version of a paradox from Jos\'{e} @Bernadete1964.

There is a room that is very dangerous to cross. A man is thinking of crossing it, but he is warned off when he learns that it contains an infinity of gods. God~1~ will kill him if he makes it half-way across the room. God~2~ will kill him if he makes it a quarter of the way across. God~3~ will kill him if he makes it one-eighth of the way across. More generally, God~*n*~ will kill him if he makes it (1/2)^*n*^ of the way across the room. Does he enter? Of course not; he'd be killed! But who would kill him? Presumably not God~1~; how would he make it that far? This generalises. God~*n*~ can't kill him, because God~*n*+1~ would already have done the job. So he would be killed by the gods, but not by any particular god. This doesn't sound very plausible.

The case looks like the kind that motivated Lewis to reject what he called the *Limit Assumption*. This says that if $A$ is possible, then relative to any world $w$ there are some closest worlds where $A$ is true. @Humberstone2011 [1014--5] discusses Lewis's rejection of the Limit Assumption, and adopts the position that we shouldn't impose it in general, but can freely talk as if it is true, because it doesn't make a difference to the logic. This is right in the context Humberstone is writing in, but potentially misleading. The Limit Assumption does make a big difference to the logic if we have either quantifiers or infinitary connectives in the language. This fact is what Fine's puzzle turns on.

Stated without the Limit Assumption, Lewis's view is that $A \boxright B$ is true at $w$ if there is some world where $A$ is true such that there is no closer world where $A \wedge \neg B$ is true. If we assume that for any *n*, the world where the man enters and God~*n*+1~ kills him is closer than the world where he enters and
God~*n*~ kills him, then Lewis is committed to both (@lewisgodsome) and (@lewisgodparticular).

(@lewisgodsome) If the man were to enter the room, he would be killed by either God~1~ or God~2~ or $\dots$.
(@lewisgodparticular) For each _n_, it is not the case that if the man were to enter the room, he would be killed by God~*n*~.

As Fine notes, Lewis's theory of counterfactuals is committed to denying a principle he calls **Infinite Conjunction**.

Infinite Conjunction
:    If $A \boxright C_i$ is true for each $i$, then $A \boxright (C_1 \wedge C_2 \wedge \dots)$ is true.

With the Limit Assumption, Lewis's semantics would endorse **Infinite Conjunction**. But it would also have a problem. Which of the gods would kill the man? Any choice seems not only arbitrary, but mistaken. Let's spell this out a bit more carefully. Fine's way of spelling out the paradox makes heavy use of a principle he calls **Disjunction**. (This is called **Subj. Dilemma** by @Humberstone2011 [1015].)

Disjunction
:    If $A \boxright C$ and $B \boxright C$ are true, so is $(A \vee B) \boxright C$.

Then both (@firstkgods) and (@latergods) seem like they should be true.

(@firstkgods) If the man had entered the room, and been killed by one of God~1~ through God~*k*+1~, he wouldn't have been killed by God~*k*~ (because God~*k*+1~ would have killed him first).
(@latergods) If the man had entered the room, and not been killed by one of God~1~ through God~*k*+1~, he wouldn't have been killed by God~*k*~.

Putting these together using **Disjunction**, we get the following sentence. It's a mouthful, but it's important to spell it out for what comes next.

(@longnotk) If either the man had entered the room, and been killed by one of God~1~ through God~*k*+1~, or he had entered the room, and not been killed by one of God~1~ through God~*k*+1~, he wouldn't have been killed by God~*k*~.

To finish off the paradox, let's add a new principle, **Antecedent Substitution**.

Antecedent Substitution
:    If $A$ and $B$ are provably equivalent in classical logic, and $A \boxright C$ is true, so is $B \boxright C$.

Then using **Antecedent Substitution** we can get from (@longnotk) to (@shortnotk).

(@shortnotk) If the man had entered the room, he would not have been killed by God~*k*~.

And since *k* is arbitrary in (@shortnotk), we can derive (@lewisgodparticular), without any appeal to the metaphysics of counterfactuals. It looks like our only options, short of abandoning classical logic, are to give up one of **Infinite Conjunction**, **Disjunction**, or **Antecedent Substitution**. In Fine's original discussion of the paradox he introduces several more principles that could in theory be given up, but Brian @Embry2014 convincingly argues that really it has to be one of these three, and I'm following his lead.

If these are the three options, it isn't obvious which one to take. All three paths forward have their proponents, or at least are consequences of otherwise plausible views. I've already noted that @Lewis1973a is committed to rejecting **Infinite Conjunction**, because he does not endorse the Limit Assumption. This does not look great; it's crucial to reasoning with counterfactuals that if some things would each be true were $A$ the case, then were $A$ the case they would each be true.

@Fine2012a recommends giving up **Antecedent Substitution**. He develops a theory of conditionals that doesn't use possible worlds, but instead uses incomplete states. These are not entirely unlike Humberstone's possibilities, but the resulting theory is quite different. I suspect the key distinction, the one that drives all of the rest of the results, is that Fine takes disjunctions to be true at a state only if a disjunct is true at that state. Anyway, Fine thinks that the misstep in the trilemma above is the derivation of (@shortnotk) from (@longnotk). That step requires substituting $A$ for $(A \wedge B) \vee (A \wedge \neg B)$ in an antecedent, which Fine takes to be illegitimate.

There are a couple of reasons to be unhappy with this way of getting out of the problem. One is that this did not feel like the most controversial step when we were developing the problem. But a bigger one is that Fine's resolution of the trilemma ends up endorsing not just **Disjunction**, but also its converse. This is the principle that @Humberstone2011 [1016] calls *Conv. Subj. Dilemma*, the key being that from $(A \vee B) \boxright C$ one can infer $A \boxright C$. The criticisms of Fine in @Embry2014 largely centre on this aspect of Fine's view, and its consequences. But the key problems with the principle are already pretty clear in @Humberstone2011 [1016--1022]. So I think we shouldn't go that way.

So that leaves **Disjunction**. This is the step that Andrew @Bacon2023 rejects, and it's what I'll reject as well. I think there are two key reasons to worry about giving up **Disjunction**, and they are pretty hard worries to address in the possible worlds framework. But they both seem more or less manageable in the possibilities framework.

The first worry is that without **Disjunction**, we have to give up the idea that the selection function $f$ is in any sense a measure of similarity, or really any kind of nearness. Here is how Bacon puts it:

> The second consideration in favour of **Disjunction** is that its validity is predicted by the now dominant account of counterfactuals, prominently defended by Lewis and Stalnaker, based on similarity semantics. For roughly, if the closest $A$ worlds are $C$ worlds, and the closest $B$ worlds are $C$ worlds, then the closest $A \vee B$ worlds are $C$ worlds. [@Bacon2023 374]

Now for Bacon, this isn't a worry, because he thinks there are independent reasons to reject the picture of similarity or nearness as being foundational to counterfactuals. I don't find those reasons convincing, and basically agree with the response to them that @Fine2023 gives. But it's not just critics of **Disjunction** who connect it to the similarity picture. The same connection is drawn by Humberstone, who does endorse **Disjunction**. He first notes that, by analogy with other maximal relations, we should expect that the nearest $A \vee B$-world will be either the nearest $A$-world or the nearest $B$-world [@Humberstone2011, 1015]. He then argues more formally that if the set of nearest $A$-worlds is generated by an underlying three-place similarity relation $S_wxy$, meaning $x$ is at least as similar to $w$ as $y$ is, and if for any $w$, $S_w$ is a total preorder on worlds, then **Disjunction** is guaranteed to hold [@Humberstone2011, 1025--6].

That argument seems irrefutable if, *but only if*, we're working in a possible worlds framework. If we're in a possibilities framework, it doesn't look right. It could be that the nearest possibility in which $A \vee B$ is true is not identical to either the nearest possibility in which $A$ is true or the nearest possibility in which $B$ is true, but is instead a coarsening of one of those possibilities.

How could **Disjunction** fail on the possibilities picture? We must fail to have the nearest $A \vee B$-possibility be a $C$-possibility. But that's impossible if the nearest $A$-possibility is a $C$-possibility, and the nearest $B$-possibility is a $C$-possibility, and all $A \vee B$-possibilities are $A$-possibilities or $B$-possibilities. On the possibilities picture, that last clause fails. It might be that the nearest possibility that makes $A \vee B$ true does not make either $A$ true or $B$ true; it just guarantees that a sequence of refinements will eventually make one or the other true. Also note that we don't require that the nearest $A \vee B$ possibility makes $\neg C$ true; it could be that **Disjunction** fails because $C$ is true at some refinements of the nearest $A \vee B$ possibility and $\neg C$ is true at others.

That's what happens with our man who wisely doesn't enter the room. What's the nearest possibility in which he does enter the room? It's the incomplete possibility where he is killed by one of the gods. For each *i*, *j* with *i* > *j*, the possibility where he is killed by God~*i*~ is closer than the one where he is killed by God~*j*~. But the indeterminate possibility where he is killed, without specifying which god kills him, is closer to actuality than any complete possibility that specifies the homicidal divinity.

So rejecting **Disjunction** is compatible with the similarity approach to counterfactuals, as long as we use possibilities. The other worry about rejecting **Disjunction**, one @Fine2023 stresses in his response to Bacon, is that we use **Disjunction** a lot in ordinary counterfactual reasoning. We should be cautious about giving it up. Of course, there are plenty of rules that we use in ordinary reasoning that work in all but a few edge cases. If we could show that **Disjunction** was truth-preserving in all but some rare exceptional cases, we could justify using it as a rule of inference. After all, we don't think that the failure of Axiom V in full generality means that it's always a mistake to infer from the existence of some things to the existence of a set containing all and only them.

As Fine stresses, it's hard to see how on Bacon's view **Disjunction** would even count as typically fine. The reason Bacon says that it fails in the paradoxical case from Bernadete generalises to more humdrum uses.

But that's not true for the possibilities model. You need to have some very unusual relationships between Humberstone's family of similarity relations $S_w$ and $\leqslant$ in order for **Disjunction** to fail. For one thing, you need the nearest possibility $x$ where $A \vee B$ holds to be an incomplete possibility where neither $A$ nor $B$ holds. Clearly $x$ has to have refinements where $A$ is true, and refinements where $B$ is true. To get a **Disjunction** failure, you need one of the refinements of $x$ where one of the disjuncts is true to not be (a refinement of) the closest possibility to actuality where that disjunct obtains. I can't construct an intuitive case where that happens that doesn't involve infinite sequences like in Bernadete's case, though I also don't have a proof that no such case can be constructed. This is all far from conclusive, but it seems plausible that on the possibilities model, failures of **Disjunction** will be rare. And that would be enough to explain the fact Fine appeals to, that we are usually happy using it in everyday inferences.
