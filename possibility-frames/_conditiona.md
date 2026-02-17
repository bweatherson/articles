The only discussion of possibilities (as opposed to worlds) in *The Connectives* is in the chapter on disjunction. But there are several potential connections to conditionals, and in this section I'll go over a couple of them.

One connection concerns Conditional Excluded Middle (as discussed on pages xxx-yyy of *The Connectives*), and more generally the relationship between $A > (B v C)$ and $(A > B) v (A > C)$. On a Stalnaker-Lewis style approach to conditionals, these are equivalent iff there is a nearest possible world in which $A$ is true, for any possble $A$. It is natural to think about whether that is true in largely metaphysical terms, asking whether there really is guaranteed to be a single nearest world where $A$ is true. And as @Lewis1973a argued, it is natural to answer that question negatively.

To take one striking example of that, consider the discussion by Jeremy @Goodmanms of the example, originally due to Max @Blackxx, of the two spheres alone in space. Black says that the spheres are really two, so this is a counterexample to the Principle of Identity of Indiscernibles. Let's assume, for now, that Black is right, and we can call one sphere $a$ and the other sphere $b$. Goodman asks what we should say about the counterfactual possibility that one of the spheres is heavier. On Lewis's picture, rejecting Conditional Excluded Middle, both (@goodmana) and (@goodmanb) are false.

(@goodmana) If one of the spheres were heavier, it would be $a$.
(@goodmanb) If one of the spheres were heavier, it would be $b$.

A common thought at this point is that this verdict really does follow from Lewis's 'nearest possible world' semantics for conditionals, but that data about the inferential role of conditionals shows that Conditional Excluded Middle must be correct.^[For a recent statement of this last view, with many more citations to similar statements, see @CarianiGoldstein2020.] This is, many think, a problem for the Lewisian view.

One move here, discussed by @Humberstone2011 [10xx], is to use supervaluations. Perhaps it is in some sense indeterminate whether the world where $a$ is heavier or the world where $b$ is heavier is more like actuality. A related, but I think, preferable, move is to analyse conditionals not in terms of possible worlds, but in terms of possibilities.

Here is one possible way to analyse conditionals, mixing Stalnaker's approach with Humberstone's possibilities.^[The particular details here closely follow the theory presented by Andrew @Bacon2023, which I'll return to presently.] Extend a possibility model $\langle W, \slantgeq, V \rangle$ to a conditional possibility model by adding a selection function $f$. This is a function $\mathcal{P}(W) \times W \rightarrow \mathcal{P}(W)$, intuitively picking out the 'nearest' possibilities to a world where a particular proposition is true, satisfying these constraints.

[Include Bacon constraints]

The cardinality constraint [include name] guarantees that Conditional Excluded Middle will hold. But we don't have to make invidious choices about whether the nearest possibility where one of the spheres is heavier makes $a$ or $b$ heavier. Rather, we just say that the nearest possibility is an unrefined possibility that makes the disjunctive proposition _One of them is heavier_ true, without making either disjunct true. It will have refinements where each is true, but the nearest possibility will not validate either disjunct. This seems like an intuitive treatment of the case.

Goodman uses this example to argue that Black was incorrect, and the spheres are in fact discernible. His argument is that one but not the other will have the property of being the one which would be heavier if they were different. I don't think this argument goes through on the possibilities framework, but filling in the details of that would require providing a theory of properties on the the possibilities framework, and 
