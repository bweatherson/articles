This chapter is about the evidentialist response to the moral Newcomb problem. It says that the thing to do under moral uncertainty is to maximise $\Pr(A\degree | A)$. More precisely, it says that the value of a choice $A$ is given by the equation $V(A) = \Pr(A\degree | A)$. Here's what I cover in the chapter.

First, I show that the view is consistent and non-trivial. At least, I show that the view is consistent if a fairly orthodox approach to decision theory is consistent and non-trivial. It is obvious that Lewis's argument doesn't undermine this view; since the view doesn't endorse $V(A) = \Pr(A\degree)$ it can't be undermined by any argument against that equation. But the plan here is to show something stronger, namely that no such formal argument can refute it.

Second, I raise a worry about how updating works on this model. At least given some plausible judgments about how updating should work in particular cases, it follows that the model is not consistent with the rule that all updating is by conditionalisation.

Third, I'll go over some reasons that we might be concerned by this failure of conditionalisation. I'll discuss a few such reasons, but the one I'll spend most time on is that it raises a worry about whether this is really a model where beliefs about the good matter at all. The consistency proof the chapter starts with has a downside for the evidentialist; it grounds an argument that this view is really just a notational variant on orthodoxy. And the point about conditionalisation strengthens that argument.

Fourth, I'll look at a radical way the evidentialist can respond to this. The response is to massively  complicate what a world looks like in the model. What we end up with is a situation where worlds are pairs of 'descriptive worlds' (i.e., descriptions of the non-normative parts of the world), and functions from descriptive worlds to values. So the number of worlds we end up with is at least, in some sense, $n^m$, where $n$ is the number of values there are, and $m$ is the number of descriptive worlds there are. These models are not easy to use.

I'll go on to describe some odd features of these models. The biggest one is that they are not at all functionalist. There are distinct doxastic states that lead to the same dispositions to act. I'll discuss how problematic this is.

Finally, I'll look at whether we can build out of this an argument that the evidentialist theory is false. Basically the argument will be that the evidentialist theory is either anti-conditionalisation, or it is anti-functionalist, and those are both bad things. I think this is an interesting argument, but I also think its dialectical force is approximately zero. It is hard to imagine there are too many folks who find the premises more plausible than the negation of the conclusion.


## Worlds as Pairs

We're going to look at two models in this chapter, and both of them take an idea set out by Richard Bradley and Christian List as their starting point [#BradleyList2009]. They suggested that the desire as belief theorist should think worlds are ordered pairs. The first member of the pair will be a specification how things are descriptively, and the second member will be a specification of how things are morally. They don't go into much more detail than that about what exactly the nature of the second element should be, and one of the things we'll spend a bit of time on is that question. But the big picture here is taken, in its entirety, from their suggestion.

We'll start with a very simple way of modelling this. Say that a world is a pair $\op{d,m}$, where $d$ is a set of descriptive facts, and $m$ is a number. Intuitively, $m$ represents how good it is that $d$ obtains. Since we're still assuming **Good-Bad**, we'll assume that $m$ is either 0 or 1. 

These pairs are worlds, so credal functions are defined over them, and propositions are sets of them. There are some special propositions within that set. Say that a proposition is **factual** if is a set $S$ such that $\op{d,1} \in S \leftrightarrow \op{d,0} \in S$. That is, if $S$ is consistent with the facts being a certain way, then it is also consistent with any evaluation of those facts. We don't, on this approach, have a nice way to represent a purely moral proposition, but we have the factual propositions, and they will play a special role in what follows. (It's actually a bit funny that we don't have a nice way to represent the purely moral propositions; this will be relevant to what follows.)

So the worlds are pairs. As usual, we need to have credences and values defined over them. We will focus on pairs where for all $d, m$, we have $V(\op{d,m}) = m$. Call these the _privileged_ credence-value pairs. Note that here we're getting very close to the view Lewis calls _Desire by Necessity_ [#Lewis1996b]. When we get back to exegesis, I'll talk more about why we might think of this as a model of Desire by Necessity.

This class of 'privileged' credence-value pairs have some nice properties. If we extend $V$ from a valuation on worlds to a valuation on propositions in the normal way, and assume that updating on factual propositions is by conditionalisation, then we can ensure **Invariance**, **Addition** and **Restricted Conditionalisation** are satisfied. To be sure, we get those conditions to be satsified more or less by stipulation. So the fact that they are satisfied in the model is not any kind of evidence that they are good constraints. But if we had independent reason to endorse them, and I think we do, then it is nice that they are satisfied. And the fact that they are satisfiable in a reasonable model is a reason to think that they are not where one should object to Lewis's argument. I'll return to this point when discussing other objections to Lewis later in the book.

There is something else nice we can do with this model. Take any familiar credence-value pair, defined only over 'descriptive' worlds, and with bounded values. That is, the inputs to the familiar pair are factual propositions. Since value functions are only defined up to positive affine transformation, we can rescale the value function so its upper bound is 1, and its lower bound is 0. Call the credal and value functions we now have $\Pr_O$ and $\V_O$, where the $O$ is for 'Old'. We can define new functions $\Pr_N$ and $V_N$ as follows.

\\[
\Pr{_N}(\op{d,1}) = \Pr{_O}(d)V{_O}(d) \\
V{_N}(\op{d,1}) = 1 \\
\Pr{_N}(\op{d,0}) = \Pr{_O}(d)(1-V{_O}(d)) \\
V{_N}(\op{d,0}) = 1 \\
\\]

The new function will be in the privileged class, will keep the value of any descriptive proposition unchanged, and will satisfy **Restricted Conditionalisation** as long as the old functions were updated by conditionalisation. 

And you can do this trick in the reverse direction too. Given a pair from the privileged class, 
