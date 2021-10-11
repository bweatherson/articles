title:              Desire as Belief
author:             Brian Weatherson
date:               May 22, 2018
base header level:	3
LaTeX Mode:          Article
latex leader:         ../styles/handout-leader
latex begin:         ../styles/handout-begin

# Overview

* Why this all matters
* Lewis's second argument
* A Newcomb-like case for moral uncertaintists
* Three interpretations of V; and why Lewis's argument fails on all of them
* Defending Invariance
* Modelling DAB
* What makes something a belief, not a desire

# Things I Will Happily Discuss, But Don't Have on Today's Schedule

1. Russell and Hawthorne's argument from structural facts about updating. (Short version - I've come around to thinking the puzzles here are mostly on the probability side; it's folks who think we should use beliefs about probabilities where probabilities are called for who are threatened by their argument.)
2. Ittay's argument from chance. (Short version - I think I can live with independence of goodness and truth in cases where chances are well defined.)

# Why This Matters

* Moral uncertaintists say that good action (of a certain kind) is sensitive solely to doxastic states.
* In particular, they say that beliefs about the goodness of certain acts/outcomes is sufficient to determine which act should be taken.
* Lewis's argument _looks_ like it is an argument against anyone who tries to have beliefs and beliefs only (i.e., not desires) suffice for action.

# Lewis's Second Argument

* I'm not going to go over the 1988 argument, which relies on some really controversial assumptions. Instead I'll go over the 1996 argument. There are some interpolations here, but I think I've got the basic structure.
* Assume that we have a finite set of _worlds_. We will use _w_ as a variable over worlds. A world, in this sense, is a specification of the truth value of all the truth-apt things that are relevant to a particular decision.
* They are more coarse grained than Lewisian concreta in that they only specify relevant truth values, not all truth values. That's why we can assume that there are finitely many of them.
* But they are more fine grained than Lewisian concreta in that we'll allow for moral uncertainty, even though metaphysically there cannot be worlds that differ morally without differing factually.

## Terminology

* $A$ is an arbitrary factual proposition; i.e., it is silent on moral questions.
* For any such factual proposition, we can construct a distinct proposition $A°$, meaning that $A$ is good.
* $V$ is the agent's value function, $\Pr$ is their credence function, and subscripts represent what those functions are like after updating. So $V_A$ and $\Pr_A$ are the value and credence functions after updating on $A$. Strictly speaking, it is sets of worlds that get values, but I'll often write $V(w)$ for $V({w})$.
* Lewis's target is the equation $V(A) = \Pr(A°)$

## Assumptions

Invariance
:    $V_A(w) = V(w)$

Additivity
:    $V(A) = \sum_w V(w)\Pr(w | A)$

Restricted Conditionalisation (Restricted because it only applies to updating on factual propositions)
:    $\Pr_A(B) = \Pr(B | A)$

Good-Bad (To be dropped soon - but very convenient)
:    All worlds are either GOOD or BAD. If $w$ is GOOD, then $V(w) = 1$, and otherwise $V(w) = 0$

## The Argument

``
\begin{align*}
\Pr(A°) &= V(A) \\
        &= \sum_w V(w) \Pr(w | A) && \text{(Additivity)} \\
        &= \sum_w V_A(w) \Pr(w | A) && \text{(Invariance)} \\
        &= \sum_w V_A(w) \Pr_A(w | A) && \text{(Restricted Conditionalisation)} \\
        &= V_A(A) && \text{(Additivity), applied to updated values} \\
        &= \Pr_A(A°) \\
        &= \Pr(A° | A) && \text{(Restricted Conditionalisation)} 
\end{align*}
``{=latex}

But it is absurd that $A°$ and $A$ are independent. At least, it's absurd if evaluative uncertainty is coherent. The following situation seems perfectly coherent. H, a hero, is facing a tricky moral dilemma. They have to choose between respecting rights and maximising welfare. Let $A$ be the proposition that they respect rights in this situation, and $A°$ be that it is good for them to do so. It is coherent to not know what H will do, and not know what it would be good for them to do, but think that if they do $A$, that will be evidence for $A°$. It may not be conclusive evidence, even heroes make mistakes, but it is coherent to think that it is some evidence. Lewisian Desire-As-Belief implies it is no evidence at all, and this is absurd.

* Lewis doesn't in fact stop at this point, but offers another argument about how absurd this would be after updating on $A \vee A°$. I don't think that argument is very good, and we can go over why if you like.

# A Puzzle

I think moral uncertaintists should be happy with a notion of 'moral hope'. (Some of the discussion Tuesday made me worry about this, but let's go with it.) De Re motivation theorists don't just use thick moral notions to guide our own actions, we also hope others are fair, kind, honest etc. A moral uncertaintist can, more simply, hope that others are good. But how should we implement this?

* Hero faces a choice between $A, B$ and some less attractive options.
* Right now, we think $A°$ has probability 0.5, and $B°$ has probability 0.9.
* But we know Hero is very good at making $A$-type actions. If she does $A$, we will be certain it is Good. That is $\Pr(A° | A) = 1$. But we don't think she's any kind of expert about $B$-type actions. So $\Pr(B° | B) = \Pr(B°) = 0.9$.
* What should we hope Hero does?
* I think (speaking for the moral uncertaintist), we should hope she does $A$. Then we'll be sure that a Good thing has happened.

Now run this puzzle 'from the inside'. Imagine Hero herself knows all these facts, and has to choose on the basis of this knowledge. What should she choose?

* I have literally no idea what the moral uncertaintist should say here. I think it's a super hard case.
* But let's keep our options open.
* Say the _evidentialist_ moral uncertaintist thinks that Hero should choose A, because once chosen, she'll be happy with that choice.
* And the _causal_ moral uncertaintist thinks that Hero should choose B, because that's most likely to be Good choice.

So we have three possible interpretations of Lewis's $V$.

1. As a measure of moral hopefulness.
2. As a measure of choice-worthiness given evidential moral uncertaintism.
3. As a measure of choice-worthiness given causal moral uncertaintism.

# Why the Argument Fails

* If $V$ measures moral hopefulness, then we want $V(A)$ to equal $\Pr(A° | A)$, not $\Pr(A°)$. After all, we want $V(A) > V(B)$.
* If $V$ measures evidential choice-worthiness, then we want $V(A)$ to equal $\Pr(A° | A)$, not $\Pr(A°)$. After all, we want $V(A) > V(B)$.
* If $V$ measures causal choice-worthiness, then I think we don't want the Addition rule. As Lewis himself notes, this rule is not designed to work for theories of choice that deny the fact that a choice is made modifies our views on how good that choice was.

# Defending Invariance

Bradley and Stefánsson argue that the problem with the argument is the Invariance assumption. I don't know how we'd do game theory if Invariance were false. What would we write at terminal nodes? Would it be $V(w)$ or $V_w(w)$? So I'm really loathe to give that up. And I don't think that we should. They give two arguments, neither of which is convincing.

## Their First Argument

1. Invariance is inconsistent with $V(\top)$ being constant.
2. If $V$ measures 'news-worthiness', then $V(\top)$ should be constant, with $\top$ is never valuable news.
3. The intended interpretation of $V$ is that it is news-worthiness.
4. So, Invariance is false (on the intended interpretation of $V$).

I think premise 2 fails. What $V(A)$ measures is not how much good news $A$ is, but how good the background news, plus $A$, is. In a slogan, it would be better to call it _contentedness_ with the news that $A$, not how pleased one is with the news. (Put yet another way, it's the absolute value of the news that $A$, not the marginal value.) I hadn't realised this about the interpretation of $V$ until I worked through Bradley and Stefánsson's paper, so I thought that was pretty interesting.

## Their Second Argument

I don't quite know how to put this in an argument, but here's the dialectic.

* Lewis: Invariance (at least for worlds) must be true, because by hypothesis a world fixes the truth value of every truth-apt thing that is relevant, and (also by hypothesis) how valuable things are is determined by truths about value.
* Bradley and Stefánsson: But worlds shouldn't include things like _It is good that it is good that A_, because these things don't make sense. So they can't fix all value.
* Me (on behalf of Lewis): Let's grant that _It is good that it is good that A_ doesn't make much sense. Indeed, let's grant as a generalisation that only non-moral propositions have propositions about their value that make sense. Still, it should be uncontroversial that a world fixes the (relevant) concrete facts, and uncontroversial that a world fixes the value of _those concrete facts_, and given that, I'm not sure what's left open.

# Modelling DAB

One frustrating thing about the DAB literature is that even when people argue that Lewis's arguments against DAB do not work, they rarely provide a full working model for what a theory endorsing DAB might look like. So I wanted to spend a bit of time going over that, because there turns out to be a really interesting choice point. Neither choice is awful - I'm really not arguing against DAB or moral uncertaintism here - but the choice isn't an obvious one.

I'll start with an idea from Bradley and List. Say that worlds are ordered pairs of some descriptive stuff and some evaluative stuff. So our typical world will be written $\langle d, e \rangle$. Bradley and List don't say much about what should go into $e$, so let's start working that out. We want $e$ to be such that it settles the value of the world. But, as we saw in discussing Bradley and Stefánsson's second argument, we don't want that to mean that $e$ is self-referential. Rather, we want $e$ to be such that given $d$, a value for $\langle d, e \rangle$ is obtained. There are a bunch of ways to do that. I'm just going to look at two that seem especially interesting, but I'm more than happy to go over a bunch more.

1. $e$ is just a number (which will be 0 or 1 given that Good-Bad is still in effect), and $V(\langle d, e \rangle) = e$.
2. $e$ is a function from descriptive states to values, so $V(\langle d, e \rangle) = e(d)$.

# $e$ is a Value

This is a nice reasonably simple way to do things. We can then make some nice identifications (though some of these get less nice looking once Good-Bad is dropped).

* Let $G$, the proposition that things are Good, be the set $\{\langle d, e \rangle: e = 1\}$
* Then $A°$ can be any proposition that is entailed by $A \wedge G$ and entails $A \supset G$, and we'll have $V(A) = \Pr(A° | A)$.

There is one really striking thing about this kind of model though. Start with literally the simplest case possible - there is only one atomic proposition that we're interested in, so there are just two worlds. I'll call those worlds $T$ and $F$, for the atomic proposition being true and false. And there are two values. So we get four worlds:

* $w_1 = \langle T, 1 \rangle$
* $w_2 = \langle T, 0 \rangle$
* $w_3 = \langle F, 1 \rangle$
* $w_4 = \langle F, 0 \rangle$

Imagine that we start out thinking each of these four worlds is equally probable. Then we learn something. We hear a good philosophical argument, and we decide that it would be Good if the atomic proposition were true. This isn't to say it would be Good only if the atomic proposition were true, just that $w_2$ is ruled out. 

The usual way we update probabilistic beliefs is by conditionalisation. That is, we set the probability of everything that's ruled out to 0, and multiply the probabilities of everything else by a constant so that they sum to 1 again. If we do this here, we get the following outcome.

* $\Pr(w_1) = \frac{1}{3}$
* $\Pr(w_2) = 0$
* $\Pr(w_3) = \frac{1}{3}$
* $\Pr(w_4) = \frac{1}{3}$

And a consequence of that is that $\Pr(T)$ has gone from $\frac{1}{2}$ to $\frac{1}{3}$. And that's absurd. So if we use this model, we can't update by conditionalisation.

Maybe that's ok. We could update by imaging. (Maybe we can talk about this in class if anyone is interested.) Or maybe we can use some of the tricks that have been developed for updating centred worlds propositions. There are things to do. But it's interesting that we can't conditionalise. And it is especially interesting if we're worried that these aren't really beliefs after all, but just some artificial construction out of beliefs and desires. After all, maybe we could take it as constitutive of beliefs that they are updated by conditionalisation. But that would be a very bold claim - remember the centred worlds cases. So there are interesting puzzles here.

# $e$ is a Function

At the other extreme, $e$ is a function that maps every descriptive state onto a value. Once we start going this way, there are a _lot_ of worlds. In the case where there is just one atomic proposition, we have eight 'worlds'. Each world has to say three things: whether the atomic is true or false; what is of it being true; and what the value is of it being false. If there are two atomic propositions, then all of a sudden there are 64 worlds. This is really strange, but I guess we knew there were a lot of worlds. (Even in the infinitary case, there will be more worlds on this approach than on the previous approach.)

Now on this approach the worry about conditionalisation won't arise. As far as I can tell, conditionalisation is safe on this model. (Though I'm a little worried about the Russell and Hawthorne argument that I've set aside for today. This approach also lets us model some _weird_ possible belief states. For instance, on this model (but not the previous one) we can represent the person who is sure that things are Good, and is sure that if things were other than they are, things would be Bad, but is completely unsure about which descriptive state we are in. Maybe that's ok; maybe it's even good if you want to be able to represent things like that.

The big problem, I think, is that it requires us to represent doxastic states that could not, in principle, make any difference to any kind of action. (Or, at least, it doesn't on the evidentialist model; the causal model might be different.) I'm enough of a functionalist to be a little sceptical of such a doxastic distinction. If all that matters for decisions are our beliefs about how value a world would be if it were actualised, then distinctions that a world makes about how valuable other descriptive states would be don't seem to have much meaning.