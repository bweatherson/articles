# Lewis's Argument

## Introduction

In a pair of paper from the second half of his illustrious career, David Lewis argued against a thesis he called "Desire as Belief". The papers had the somewhat unimaginative names "Desire as Belief" [@Lewis1988] and "Desire as Belief II" [@Lewis1996]. The arguments have proven to be rather perplexing. There is nothing like a consensus in the literature on how to formulate the argument, on what its strengths and weaknesses are, or even what the argument would show if it succeeded.

But let's start with a reasonably simple version of the argument. Assume Max is a rational agent, who can be accurately represented as having credence function $C$ and value function $V$. That is, Max 

We will start with Lewis's argument against the idea that how much we desire that a proposition $A$ be true is a function of our beliefs about some related propostion, namely that $A$ is good. We will write that latter proposition as $A°$. Lewis made four large assumptions in setting out his argument, but to state them we need a little formalism.[^I'm presenting here the argument from [#Lewis1996;], not the more complicated argument in [#Lewis1988;] offered. Lewis notes the argument is similar to one offered by [#ArloCostaEtAl1995;]. My presentation draws on the presentations in [#RussellHawthorne2016;] and [#Collins2015;]. I'm using $A°$ for _A is good_ rather than Lewis's notation Å, because I need to talk about lots of propositions being good, and I don't have a good way to extend Lewis's notation to easily say _B is good_. This notational variation is copied from [#BradleyList2009;].] 

In the formalism throughout, $V$ is the agent's value function, $\Pr$ is their credence function, and subscripts represent what those functions are like after updating. So $V_A$ and $\Pr_A$ are the value and credence functions after updating on $A$. I'm also assuming that $A$ is a 'factual' proposition, unlike $A°$. Just what the factual/non-factual distinction amounts to, and whether that terminology is at all helpful, will be something we'll return to. Finally, I'll use $w$ to either denote a single 'world', or as a variable ranging over worlds. We'll say a lot more about worlds in what follows, but for now note that they are things that set the truth value of all propositions that are currently relevant. So they are more fine-grained in some senses, and less fine-grained in others, than Lewisian concreta. They are more fine-grained because we could have a pair of worlds, in this sense, that are alike in descriptive respects, but unlike in evaluative respects. We need these worlds because we are trying to model agents who are uncertain about evaluative claims, but whose actions are sensitive to their beliefs about the evaluative. They are less fine-grained because they only determine the truth values of things that are currently relevant. They are like the 'small worlds' in the sense of XXXX. They don't determine last night's baseball results, let alone the speed of each pitch in each of those games. Because they are small in this sense, we will assume that they are finitely many of them. This is an idealisation, but not much of one. It is rare, if not impossible, that we are interested in more than finitely many things at once. And even if one of those things could in principle take an infinity of values (because, e.g., it is a continuous function like the speed of a pitch), the difference between a continuous function and a finite approximation to it will typically be negligible. All that said, onto the assumptions.

Invariance
:    $V_A(w) = V(w)$

Additivity
:    $V(A) = \sum_w V(w)\Pr(w | A)$

Restricted Conditionalisation
:    $\Pr_A(B) = \Pr(B | A)$

Good-Bad
:    All worlds are either GOOD or BAD. If $w$ is GOOD, then $V(w) = 1$, and otherwise $V(w) = 0$

I will defend Invariance and Additivity at length in the next chapter, and return to Good-Bad shortly. I'll defer discussion of Restricted Conditionalisation for a bit, save to note that I really do mean it to be restricted to the case where $A$ is a factual proposition. 

Note that Good-Bad makes plausible the following principle.

Lewisian Desire-As-Belief
:    $V(A) = \Pr(A°)$

If we didn't have Good-Bad, that wouldn't be plausible at all. Maybe every world where $A$ is true would have value 2, for instance, then it would be very implausible that $V(A)$ could be any kind of probability at all. But if values and probabilities are at least on the same scale, then the thesis passes a minimal threshold of plausibility. 

Nevertheless, it is false. It is false because it leads to some absurd independence results. In particular, the following proof shows that $A$ and $A°$ are probabilistically independent.

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

Although the formal argument for independence I gave is Lewis's, the argument that independence is implausible is not the one he offers. The one he offers strikes me as less compelling. He notes that since we have proven independence from premises that should hold universally, the premises should also hold after updating on the disjunction $A \vee A°$. But if $A \vee A°$ is certain, the only way $A$ and $A°$ can be independent is if one or other has probability 1 or 0. So we get the result that anyone who updates on $A \vee A°$ must come to be certain of one of the disjuncts $A$ or $A°$. That's not great, but I find it so hard to imagine updating on a disjunction like that to feel very confidence about what post-update states should look like. 

There is another argument in the vicinity. Imagine that we didn't just endorse Restricted Conditionalisation, but instead said that all updates on truth-evaluable contents had to be by conditionalisation. Now we get an even stronger result. The only way for $A$ and $A°$ to be independent after conditionalising on $A \vee A°$ is if one or other of them, right now, has probability 1 or 0. So this formal argument, plus the assumption of Unrestricted Conditionalisation, shows that it is wrong to uncertain about both $A$ and $A°$. Now that is an absurd outcome, and some kind of reductio argument beckons here. But Unrestricted Conditionalisation has, as we'll see in subsequent chapters, some unusual consequences. If our argument against Lewisian Desire-as-Belief rested on Unrestricted Conditionalisation, it wouldn't be very strong. But in fact the argument from Restricted Conditionalisation has a bad enough result; we should take it to refute Lewisian Desire-As-Belief.
