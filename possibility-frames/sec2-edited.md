# Logics Determinable on Humberstone Frames {#sec-proof}

@Holliday2025 [§8.2] raises an interesting question. As well as the familiar Kripke frames most commonly used as a semantics for modal logic, and the Humberstone frames defined above, he introduces a class of 'full possibility' frames, which weaken some of Humberstone's constraints. It won't matter here exactly what these weakenings are, but what does matter is that he shows that using these weakened frames, we can determine logics that are not determinable on any class of Kripke frames. To state this more precisely, for any class of frames $\mathsf{F}$, let $\mathrm{L}(\mathsf{F})$ be the set of sentences true at all points in all models definable on some member of $\mathsf{F}$. Then let $\mathrm{ML}(\mathsf{F})$ be the set $\{\mathrm{L}(\mathsf{X}) : \mathsf{X} \subseteq \mathsf{F}\}$. That is, $\mathrm{ML}(\mathsf{F})$ is the class of logics that can be determined using just $\mathsf{F}$.

If we let $\mathsf{K}$ denote the class of Kripke frames, and $\mathsf{FP}$ denote the class of full possibility frames, @Holliday2025 [§2.5] constructs a very clever argument to show that $\mathrm{ML}(\mathsf{K}) \subsetneq \mathrm{ML}(\mathsf{FP})$. But if we let $\mathsf{H}$ denote the class of Humberstone frames, it follows from the fact that every Kripke frame is a Humberstone frame and every Humberstone frame is a full possibility frame that $\mathrm{ML}(\mathsf{K}) \subseteq \mathrm{ML}(\mathsf{H}) \subseteq \mathrm{ML}(\mathsf{FP})$. And while $\mathrm{ML}(\mathsf{K}) \subsetneq \mathrm{ML}(\mathsf{FP})$ implies that at least one of those inclusions is strict, it isn't clear which one. He leaves the question of which one it is — and of course it could be both — as an open question.

I don't have an answer to that question as asked, since it is asked about languages whose sentences have finite length. I do have a proof that if we allow infinite disjunction, as discussed above, then $\mathrm{ML}(\mathsf{H}) \neq \mathrm{ML}(\mathsf{K})$. If we expand the language like that, at least the first inclusion is strict. I will show this by constructing a single Humberstone frame that, in the infinitary language, defines a logic with no Kripke equivalent. The construction will follow Holliday's very closely, but differ just enough to ensure compliance with Humberstone's conditions.

## The Frame {-}

The frame is built from two copies of the set of finite binary sequences — sequences of 0s and 1s of any finite length, including the empty sequence. Call one copy the **left-handed** sequences and the other the **right-handed** sequences. The refinement relation is: $x \leqslant y$ iff $x$ and $y$ have the same handedness and $x$ is an initial segment of $y$. So within each copy the frame is just the binary tree ordered by extension, and no left-handed sequence refines a right-handed sequence or vice versa. It will help to have some notation for referring to points in this model. When $s$ is a finite binary sequence, I'll write $s^L$ for the left-handed version of $s$, and $s^R$ for the right-handed version.

## The Accessibility Relations {-}

Next I'll define an accessibility relation and a separate infinite family of accessibility relations. The single relation, which I'll write $R^{\rightarrow}$, is such that $xR^{\rightarrow}y$ iff $x$ is left-handed and $y$ is right-handed. The family of relations, each written $R^{\leftarrow}_i$ for $i \in \mathbb{N}$, is such that $xR^{\leftarrow}_iy$ iff $x$ is right-handed, $x$ does not have a $0$ in its $i$-th position (either because $x$ has length less than $i$, or because it has a $1$ in position $i$), and $y$ is left-handed.

That $R^{\rightarrow}$ satisfies **UpR**, **RDown**, and **RRef++** is obvious. It is also obvious that for each $i$, $R^{\leftarrow}_i$ satisfies **UpR** and **RDown**. It's only a little harder to show that it satisfies **RRef++**. Assume $xR^{\leftarrow}_iy$. So $x$ is right-handed and $y$ is left-handed. If $x$ is of length at least $i$, then $x$ itself can serve as the refinement such that every further refinement can access $y$. If $x$'s length is less than $i$, extend $x$ with enough 1s to create a sequence of length $i$. The result will be a refinement such that every further refinement can access $y$, as required.

## The Example {-}

Now consider the proposition (\ref{Splitting}), a minor variant on Holliday's example (\textsc{Split}). (I'm using $\mathsf{T}$ for an arbitrary tautology.)

\begin{equation}
\neg \Diamond^{\rightarrow} p
  \vee
\bigvee_{i \in \mathbb{N}}(
  \Diamond^{\rightarrow}
    (
      p
        \wedge
      \Diamond_i^{\leftarrow} \mathsf{T}
    )
  \wedge
  \Diamond^{\rightarrow}
    (
      p
        \wedge
      \neg \Diamond_i^{\leftarrow} \mathsf{T}
    )
  )
\tag{\textsc{Splitting}}
\label{Splitting}
\end{equation}

I'm going to make three claims about (\ref{Splitting}). First, it is true throughout the frame I just described. Second, $\neg \Diamond^{\rightarrow} p$ is not true on all models on that frame. Third, there is no class of Kripke frames throughout which (\ref{Splitting}) is always true and $\neg \Diamond^{\rightarrow} p$ is not always true. From this it follows that $\mathrm{ML}(\mathsf{K}) \neq \mathrm{ML}(\mathsf{H})$.

For the first claim, I'll show something slightly stronger, namely that at each point one or other disjunct in (\ref{Splitting}) is true. If the point is right-handed, then the first disjunct is true, since each right-handed point is a dead-end with respect to $R^{\rightarrow}$. So we just have to look at the left-handed points. Let $x$ be an arbitrary left-handed point. If there is no $y$ such that $xR^{\rightarrow}y$ and $p$ is true at $y$, then again the first disjunct is true.

Now consider the cases where there are points $y$ such that $xR^{\rightarrow}y$ and $p$ is true at $y$. Here it will be helpful to write $x$ as $s_x^L$, and $y$ as $s_y^R$. Consider those $s_y^R$ for which $s_x^LR^{\rightarrow}s_y^R$ and $p$ is true at $s_y^R$, where $|s_y^R|$, the length of $s_y^R$, is minimal. There must be some such points, since sequence lengths are non-negative integers and $p$ is true at some accessible right-handed point. Let $i = |s_y^R| + 1$. Let $s_y^R \oplus \langle 0 \rangle$ and $s_y^R \oplus \langle 1 \rangle$ be the right-handed sequences generated by adding either a 0 or a 1, respectively, to $s_y^R$. Since $p$ is true at $s_y^R$ and truth is persistent, $p$ will be true at both $s_y^R \oplus \langle 0 \rangle$ and $s_y^R \oplus \langle 1 \rangle$. Since $s_y^R \oplus \langle 0 \rangle$ has a 0 at its $i$th position, it is a dead-end with respect to $R^{\leftarrow}_i$. So $\neg \Diamond_i^{\leftarrow} \mathsf{T}$ is true there. But since $R^{\rightarrow}$ satisfies **RDown**, $s_x^LR^{\rightarrow}s_y^R\oplus \langle 0 \rangle$. So $\Diamond^{\rightarrow}(p \wedge \neg \Diamond_i^{\leftarrow} \mathsf{T})$ is true at $s_x^L$. A similar argument shows that $p \wedge \Diamond_i^{\leftarrow} \mathsf{T}$ is true at $s_y^R\oplus \langle 1 \rangle$, so $\Diamond^{\rightarrow}(p \wedge \Diamond_i^{\leftarrow} \mathsf{T})$ is true at $s_x^L$. And that implies that the $i$th disjunct of the right-hand disjunction of (\ref{Splitting}) is true at $s_x^L$, as required.

The second claim, that $\neg \Diamond^{\rightarrow} p$ is not true on all models on the frame, is trivial, since it will fail at some left-handed points whenever $p$ is true at some right-handed point.

For the third claim, we follow Holliday's argument particularly closely. Consider any class of Kripke frames such that $\neg \Diamond^{\rightarrow} p$ is not valid on that class. Look at the class of models on those frames where $p$ is true at exactly one world. For any disjunct of the right-hand disjunction of (\ref{Splitting}) to be true at a point, that point must access a world where $p$ is true that is a dead-end with respect to $R^{\leftarrow}_i$, and also a world where $p$ is true that is not a dead-end with respect to $R^{\leftarrow}_i$. That's impossible if $p$ is true at just one world. So throughout this class of models, the right-hand disjunction of (\ref{Splitting}) will be false. But if $\neg \Diamond^{\rightarrow} p$ is not valid on the frame, there will also be points in this class of models where $\Diamond^{\rightarrow} p$ is true. So the whole disjunction will be false at those points, and hence (\ref{Splitting}) is not valid on the frame.

Putting these together, there is no class of Kripke frames that validates exactly the sentences valid on this particular Humberstone frame. So $\mathrm{ML}(\mathsf{K}) \neq \mathrm{ML}(\mathsf{H})$, and hence $\mathrm{ML}(\mathsf{K}) \subsetneq \mathrm{ML}(\mathsf{H})$.
