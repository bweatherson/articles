# The Formal Structure {#sec-formal}

## The Basic Language {-}

To start with, assume we're working in a simple language that has a countable set $\mathcal{P}$ of propositional variables, and three connectives: $\neg$, $\wedge$, and $\vee$. We have a set of possibilities $W$, and a transitive refinement relation $\leqslant$ on them. The following rules show how to build what I'll call a _Humberstone possibility model_ on $\langle W, \leqslant \rangle$. (I'll call this a _possibility frame_ in most contexts, but a _Humberstone frame_ when I'm comparing it to similar structures, especially in the context of discussing @Holliday2025.)

A Humberstone possibility model $\mathcal{M}$ is a triple $\langle W, \leqslant, V \rangle$, where $V$ is a function from $\mathcal{P}$ to $\wp(W)$, intuitively saying where each atomic proposition is true, satisfying these two constraints:

- For all $x$, if $x \in V(p)$ and $y \geqslant x$, then $y \in V(p)$. Intuitively, truth for atomics is **persistent** across refinements.
- For all $x$, if $\forall y \geqslant x \exists z \geqslant y: z \in V(p)$, then $x \in V(p)$. This is what @Humberstone2011 [900] calls **refinability**, and it means that $p$ only fails to be true at $x$ if there is some refinement of $x$ where it is settled as being untrue.

Given these constraints, Humberstone suggests the following theory of truth at a possibility for all sentences in this language. (We'll treat $\rightarrow$ as a defined connective, with $A \rightarrow B =_{df} \neg A \vee B$.)

\begin{align*}
[\text{Vbls}] \quad & \mathcal{M} \models_x p_i \text{ iff } x \in V(p_i); \\
[\neg] \quad & \mathcal{M} \models_x \neg A \text{ iff } \forall y \geqslant x, \, \mathcal{M} \nmodels_y  A; \\
[\wedge] \quad & \mathcal{M} \models_x A \wedge B \text{ iff } \mathcal{M} \models_x A \text{ and } \mathcal{M} \models_x B; \\
[\vee] \quad & \mathcal{M} \models_x A \vee B \text{ iff } \forall y \geqslant x \, \exists z \geqslant y \, : \, \mathcal{M} \models_z A \text{ or } \mathcal{M} \models_z B.
\end{align*}

Given these definitions, it's possible to prove three things. First, every sentence in the language is persistent. If $\mathcal{M} \models_x A$ and $x \leqslant y$, then $\mathcal{M} \models_y A$. For any sentence, truth is always preserved when moving to a refinement. Second, refinability holds for all sentences in the language. This is, as Humberstone notes, easier to state using this definition of $\neg$. It now becomes the claim, for arbitrary $A$, that if $\mathcal{M} \nmodels_x A$, there is some refinement $y$ of $x$ such that $\mathcal{M} \models_y \neg A$. Third, for any set of sentences $\Gamma$ and sentence $A$, the truth at a point of all sentences in $\Gamma$ guarantees the truth of $A$ iff the sequent $\Gamma$ entails $A$ in classical propositional logic.

In this paper, I'm going to discuss three extensions of this language. I'll introduce them in reverse order of how much they are discussed in Humberstone, starting with one he does not discuss at all: infinitary disjunction.

## Infinitary Disjunction {-}

We'll add to the language a new symbol $\bigvee$, which forms a new sentence out of any countable set of sentences not containing $\bigvee$. Intuitively, it is true when one of the sentences in the set is true. More formally, its truth at a possibility is defined as follows:

\begin{align*}
[\bigvee] \quad & \mathcal{M} \models_x \bigvee ({A_1, A_2, \dots})  \text{ iff } \forall y \geqslant x \, \exists z \geqslant y \, : \,\text{ for some } i \, \mathcal{M} \models_z A_i.
\end{align*}

Again, it's fairly simple to show that this addition to the language will preserve persistence and refinability. But while this is simple, it is significant, because things could easily have been otherwise.

## Quantifiers {-}

The second extension will be to add quantifiers, following a suggestion in @Humberstone1981a [xxxx]. Assume, as usual, that the language has a stock of names $c_1, \dots$, and for each $n$, a stock of $n$-place predicates $F^n_1, F^n_2, \dots$. A _first-order (Humberstone) possibility model_ is a structure $\langle W, \leqslant, D, V \rangle$, where $D$ assigns a non-empty domain of objects to each point, and $V$ interprets the non-logical vocabulary. More precisely:

- $D$ is a function assigning to each $x \in W$ a non-empty set $D(x)$, the **domain** at $x$.
- $V$ assigns to each name $c_i$ and each $x \in W$ either a designated element $V(c_i, x) \in D(x)$, or is undefined at $x$.
- $V$ assigns to each $n$-place predicate $F^n_j$ and each $x \in W$ a set $V(F^n_j, x) \subseteq D(x)^n$, the **extension** of $F^n_j$ at $x$.

These must satisfy the following constraints:

Domain monotonicity
:    If $x \leqslant y$, then $D(x) \subseteq D(y)$.

Name coverage
:    For each name $c_i$ and each $x \in W$, there exists some $y \geqslant x$ such that $V(c_i, y)$ is defined.

Persistence for names
:    If $V(c_i, x)$ is defined and $x \leqslant y$, then $V(c_i, y)$ is defined and $V(c_i, y) = V(c_i, x)$.

Persistence for predicate extensions
:    If $\langle o_1, \dots, o_n \rangle \in V(F^n_j, x)$ and $x \leqslant y$, then $\langle o_1, \dots, o_n \rangle \in V(F^n_j, y)$.

Refinability for predicate extensions
:    If $\langle o_1, \dots, o_n \rangle \notin V(F^n_j, x)$, then there exists some $y \geqslant x$ such that for all $z \geqslant y$, $\langle o_1, \dots, o_n \rangle \notin V(F^n_j, z)$.

Given a model and a variable assignment $g$ mapping variables to objects, truth at a point is defined as follows. Write $g[v/o]$ for the assignment that maps variable $v$ to object $o$ and otherwise agrees with $g$. For a term $t$, write $\llbracket t \rrbracket^{g,x}$ for the denotation of $t$ under $g$ at $x$: for a variable $v$ this is $g(v)$, and for a name $c_i$ this is $V(c_i, x)$ when defined, and undefined otherwise.

\begin{align*}
[=] \quad & \mathcal{M}, g \models_x t_1 = t_2 \text{ iff } \forall y \geqslant x \, \exists z \geqslant y : \llbracket t_1 \rrbracket^{g,z} \text{ and } \llbracket t_2 \rrbracket^{g,z} \text{ are both defined and equal}; \\
[F^n] \quad & \mathcal{M}, g \models_x F^n_j(t_1, \dots, t_n) \text{ iff } \forall y \geqslant x \, \exists z \geqslant y : \langle \llbracket t_1 \rrbracket^{g,z}, \dots, \llbracket t_n \rrbracket^{g,z} \rangle \in V(F^n_j, z); \\
[\forall] \quad & \mathcal{M}, g \models_x \forall v \, A \text{ iff } \forall y \geqslant x \, \forall o \in D(y) : \mathcal{M}, g[v/o] \models_y A; \\
[\exists] \quad & \mathcal{M}, g \models_x \exists v \, A \text{ iff } \forall y \geqslant x \, \exists z \geqslant y \, \exists o \in D(z) : \mathcal{M}, g[v/o] \models_z A.
\end{align*}

The Boolean connectives are handled exactly as in the propositional case.

The $\forall\exists$ pattern in the atomic clauses is necessary to ensure that persistence and refinability hold for all sentences, including atomic ones. Consider $c_i = c_i$: if a name has no denotation at $x$ but acquires one at some refinement, then a simple "check the denotation at $x$" condition would leave $c_i = c_i$ neither true nor false at $x$, and no refinement of $x$ could settle it as false either, violating refinability. The $\forall\exists$ condition handles this correctly: $c_i = c_i$ is true at $x$ whenever $c_i$ is covered at $x$ (i.e., every refinement has a further refinement where $c_i$ gets a referent), since once $c_i$ gets a referent $o$, persistence of names ensures $o = o$ at all further refinements.

The atomic clauses simplify when names are fully defined. If $t_1$ and $t_2$ are variables, or names that already have denotations at $x$, then by persistence of names and predicate extensions the $\forall\exists$ quantifier prefix collapses: $\mathcal{M}, g \models_x t_1 = t_2$ iff $\llbracket t_1 \rrbracket^{g,x} = \llbracket t_2 \rrbracket^{g,x}$, and $\mathcal{M}, g \models_x F^n_j(t_1, \dots, t_n)$ iff $\langle \llbracket t_1 \rrbracket^{g,x}, \dots, \llbracket t_n \rrbracket^{g,x} \rangle \in V(F^n_j, x)$. The more complex clauses above are needed only to handle the case where some name occurring in the formula lacks a denotation at $x$ but is guaranteed to acquire one.

This is a possibilist treatment of the universal quantifier, in contrast to the actualist quantifiers discussed in @HarrisonTrainor2019. I'll return in @sec-quant to the reasons we are best off using possibilist quantifiers, and the difficulties this raises for talking about just what's true in a possibility.

## Modal Operators {-}

The third extension will be the introduction of modal operators. Here I'll follow @Humberstone1981a very closely, save that I'll have a plurality of modal operators rather than just one. So I'll use these structures to define (as @Holliday2025 does) multi-modal logics. But I'll follow Humberstone, and not Holliday, in defining modal operators in terms of accessibility relations $R_i$ satisfying these three conditions^[I'm using the names for these that Holliday uses, which are more evocative than Humberstone's original names.]:

**UpR**:
:    If $x \leqslant x'$ and $x' R_i y$, then $x R_i y$.

**RDown**:
:    If $x R_i y$ and $y \leqslant y'$, then $x R_i y'$.

**RRef++**:
:    If $x R_i y$, then there exists $x' \geqslant x$ such that for all $x'' \geqslant x'$, $x'' R_i y$.

**UpR** says that if a refinement of $x$ can access $y$, then $x$ itself can already access $y$: accessibility is not something gained by adding detail to the source. **RDown** is a converse of this; it says that accessibility cannot be lost by adding detail to the target. **RRef++** says that if $x$ can access $y$, there is some refinement $x'$ of $x$ where it is settled that $x'$ can access $y$. This last access can't be overturned by further refinement of $x'$.

Given these constraints, the truth condition for the box operator is:

\begin{align*}
[\Box_i] \quad & \mathcal{M} \models_x \Box_i A \text{ iff } \forall y \, (x R_i y \Rightarrow \mathcal{M} \models_y A); \\
\end{align*}

This should be familiar: $\Box_i A$ is true at $x$ iff $A$ is true at every $R_i$-accessible possibility.

Humberstone treats $\Diamond$ as a defined connective, $\Diamond_i A$ just means $\neg \Box_i \neg A$, and I'll follow suit. If we spell out what it means for $\neg \Box_i \neg A$ to be true, we get the rule [$\Diamond_i$]~Official~. But if we impose the above three constraints on $R_i$, we can see that this is equivalent to the more familiar [$\Diamond_i$]~Simple~.

\begin{align*}
[\Diamond_i]_{\text{Official}} \quad & \mathcal{M} \models_x \Diamond_i A \text{ iff } \forall y \geqslant x \, \exists z \geqslant y \, \exists w \, (z R_i w \text{ and } \mathcal{M} \models_w A). \\
[\Diamond_i]_{\text{Simple}} \quad & \mathcal{M} \models_x \Diamond_i A \text{ iff } \exists y \, (x R_i y \text{ and } \mathcal{M} \models_y A);
\end{align*}

If $R_i$ obeys **RDown**, then [$\Diamond_i$]~Official~ will imply [$\Diamond_i$]~Simple~. For $\Diamond_i A$ to be true at $x$ according to [$\Diamond_i$]~Official~, there must be some refinement which can access a point where $A$ is true, and so by **RDown**, $x$ itself can access that point. If $R_i$ obeys **RRef++**, then [$\Diamond_i$]~Simple~ will imply [$\Diamond_i$]~Official~. If there is some $y$ such that $xR_iy$ and $A$ is true at $y$, then by **RRef++**, there is some refinement of $x$ such that every refinement of it can access $y$, and hence can access a point where $A$ is true. So these are equivalent.

From now on, I'll use [$\Diamond_i$]~Simple~ when working out what's true at points in particular models. But when we are proving general facts about the language, it will help to remember that $\Diamond_i$ is a defined connective, so we don't need an extra part of inductive arguments to cover it.

## Modal Constraints {-}

Why should we impose the three constraints Humberstone proposes? It is not hard to show that they guarantee that persistence and refinability hold for sentences generated using these new modal connectives. At least, it isn't hard as long as we remember that $\Diamond$ is being treated as defined, so the only new step in the inductive proofs involves $\Box$. And **UpR** guarantees persistence for $\Box$ sentences, while **RRef++** guarantees refinability.

But this is overkill. As Humberstone points out, we haven't used **RDown** in the proof, so this doesn't explain why we'd impose **RDown**. As Holliday points out [note to self: we need a page number for this], **UpR** is stronger than we need for persistence. We could weaken it by making greater use of the fact that $A$ is persistent. All we need is that if $x \leqslant x'$ and $xRy$, then there is some $z \geqslant y$ such that $x'Rz$. That will guarantee the key fact: if $x'$ can access a world where $A$ is true, then so can $x$.

In the next section I'll discuss what logics can be defined using frames that satisfy all of these conditions.
