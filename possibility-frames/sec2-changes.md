# Changes to Section 2: Logics Determinable on Humberstone Frames

## Opening paragraphs

1. **Line 211**: `logics which are not determinable` → `logics that are not determinable`. "That" for restrictive clauses.
2. **Line 211**: `definable some member` → `definable on some member`. Missing preposition.
3. **Line 211**: `That is $\mathrm{ML}(\mathsf{F})$ will be the class of logics which can be determined` → `That is, $\mathrm{ML}(\mathsf{F})$ is the class of logics that can be determined`. Added comma after "That is"; changed "will be" to "is" (it's a definition, not a future event); "that" for restrictive clause.
4. **Line 213**: The second sentence is a grammatical tangle. It begins "But, if we let $\mathsf{H}$ denote the class of Humberstone frames, he notes that while the fact that every Kripke frame is a Humberstone frame..." — "while the fact that" starts a subordinate clause that never resolves properly. Restructured to: "But if we let $\mathsf{H}$ denote the class of Humberstone frames, it follows from the fact that every Kripke frame is a Humberstone frame and every Humberstone frame is a full possibility frame that $\mathrm{ML}(\mathsf{K}) \subseteq \mathrm{ML}(\mathsf{H}) \subseteq \mathrm{ML}(\mathsf{FP})$. And while..."
5. **Line 213**: `He leaves the question of which one it is, and of course it could be both, as an open question.` → `He leaves the question of which one it is — and of course it could be both — as an open question.` Em-dashes for the parenthetical, to avoid the comma pileup.
6. **Line 215**: `languages with sentences with finite lengths` → `languages whose sentences have finite length`. Avoids the double "with" and is more natural.
7. **Line 215**: `at least the first inequality is strict` → `at least the first inclusion is strict`. The chain $\mathrm{ML}(\mathsf{K}) \subseteq \mathrm{ML}(\mathsf{H})$ is an inclusion, not an inequality.
8. **Line 215**: `The construction will follow Holliday's construction very closely` → `The construction will follow Holliday's very closely`. Avoids repeating "construction".

## The Frame

9. **Line 219**: `sequences—sequences` → `sequences — sequences`. Added spaces around em-dash for consistency with typical style. (This is a minor preference; revert if you prefer closed em-dashes.)

## The Accessibility Relations

10. **Line 221**: Removed extra space before `{-}` in the heading.
11. **Line 223**: `which I'll write $R^{\rightarrow}$ is such that` → `which I'll write $R^{\rightarrow}$, is such that`. Added missing comma after the math.
12. **Line 223**: `each of which I'll write as $R^{\leftarrow}_i$, for $i \in \mathbb{N}$, is such that` → `each written $R^{\leftarrow}_i$ for $i \in \mathbb{N}$, is such that`. Tightened; "I'll write as" is wordy given the earlier parallel phrase.
13. **Line 225**: `then $x$ itself can be the refinement such that` → `then $x$ itself can serve as the refinement such that`. Slightly more natural.
14. **Line 225**: Added "further" to the last sentence: "every further refinement can access $y$" — paralleling the sentence two lines above and making the claim more precise.

## The Example

15. **Line 229**: `(\ref{Splitting}); a minor variant` → `(\ref{Splitting}), a minor variant`. Semicolon should be a comma (the clause after is not independent).
16. **Line 253**: `$\neg \Diamond^{rightarrow} p$` (×2) → `$\neg \Diamond^{\rightarrow} p$`. Missing backslash before `rightarrow`, so these wouldn't render the arrow symbol.
17. **Line 253**: `$\mathrm{ML}(\mathsf{K}) \neq \mathrm{ML}(\mathsf{K})$` → `$\mathrm{ML}(\mathsf{K}) \neq \mathrm{ML}(\mathsf{H})$`. Typo: the second set should be $\mathsf{H}$, not $\mathsf{K}$ (otherwise the claim is that something is not equal to itself).
18. **Line 257**: `Here is will be helpful` → `Here it will be helpful`. Typo.
19. **Line 257**: `Consider those $s_y^R$, for which $s_x^LR^{\rightarrow}s_y^R$, where |s_y^R|, the length of |s_y^R|, is minimal.` Rewrote for clarity: `Consider those $s_y^R$ for which $s_x^LR^{\rightarrow}s_y^R$ and $p$ is true at $s_y^R$, where $|s_y^R|$, the length of $s_y^R$, is minimal.` The original omits the condition that $p$ is true (which is needed — we're looking at accessible points where $p$ holds with minimal length). Also wrapped `|s_y^R|` in dollar signs for proper math rendering and removed the second set of bars around "the length of $s_y^R$" (it was displaying as $|s_y^R|$ when it should just be the name).
20. **Line 257**: `since sequence lengths are positive integers` → `since sequence lengths are non-negative integers and $p$ is true at some accessible right-handed point`. Sequence lengths are non-negative (the empty sequence has length 0). The well-ordering argument also needs the set to be non-empty, which is guaranteed by the case assumption.
21. **Line 257**: `Let $i = |s_y^R| + 1.` — the period closes the math environment. Added `$` to close properly: `Let $i = |s_y^R| + 1$`.
22. **Line 257**: `adding either a 0 or a 1, respectively, to $s_y$` → `to $s_y^R$`. The notation $s_y$ is the underlying sequence; since we've been writing the decorated version throughout, consistency requires $s_y^R$.
23. **Line 257**: `at it's $i$'th position` → `at its $i$th position`. "It's" is a contraction of "it is"; the possessive is "its". Also "$i$'th" → "$i$th" (no apostrophe needed).
24. **Line 257**: `the right-hand disjunct of (\ref{Splitting})` → `the $i$th disjunct of the right-hand disjunction of (\ref{Splitting})`. More precise — the right-hand side is an infinitary disjunction, and we've shown one specific disjunct (the $i$th) is true.
25. **Line 259**: `$\neg \Diamond^{rightarrow} p$` → `$\neg \Diamond^{\rightarrow} p$`. Same missing-backslash fix as item 16.
26. **Line 259**: `The second point` → `The second claim`. For consistency with the setup ("I'm going to make three claims").
27. **Line 259**: `since that will fail` → `since it will fail`. "That" is ambiguous; the pronoun refers to $\neg \Diamond^{\rightarrow} p$.
28. **Line 261**: `that right-hand disjunct` → `the right-hand disjunction`. The infinitary disjunction is the whole right-hand side; and "that" should be "the".
29. **Line 261**: `that's a dead-end` (×2) → `that is a dead-end`. Slightly more formal register for a proof.
30. **Line 261**: `So the disjunction will not be false somewhere, and hence not valid on the frame.` → `So the whole disjunction will be false at those points, and hence (\ref{Splitting}) is not valid on the frame.` The original says the disjunction "will not be false somewhere" — but the argument is that it *will* be false (both disjuncts fail), so it's not valid. Rewrote to make the logic clearer.
31. **Line 263**: `which validate exactly those the sentences valid` → `that validates exactly the sentences valid`. "Those the" is a typo/extra word; "which" → "that" for restrictive clause; "validate" → "validates" for agreement with "class".
32. **Line 263**: `$\mathrm{ML}(\mathsf{H}) \subsetneq \mathrm{ML}(\mathsf{K})$` → `$\mathrm{ML}(\mathsf{K}) \subsetneq \mathrm{ML}(\mathsf{H})$`. The inclusion was backwards. Since every Kripke frame is a Humberstone frame, $\mathrm{ML}(\mathsf{K}) \subseteq \mathrm{ML}(\mathsf{H})$; and since the two are not equal, the strict inclusion is $\mathrm{ML}(\mathsf{K}) \subsetneq \mathrm{ML}(\mathsf{H})$.

### Flags for author consideration

33. **Line 211**: The definition of $\mathrm{L}(\mathsf{F})$ says "the set of sentences true at all points in all models definable on some member of $\mathsf{F}$." The quantifier structure is ambiguous: does this mean sentences true at all points in *some* model on *some* frame, or sentences true at all points in *all* models on *all* frames in $\mathsf{F}$? From context (and from how $\mathrm{ML}$ is used), I believe it means: for a single frame $F \in \mathsf{F}$, $\mathrm{L}(\{F\})$ is the set of sentences valid on $F$ (true at all points in all models on $F$), and then $\mathrm{L}(\mathsf{X})$ for a class $\mathsf{X}$ is the intersection $\bigcap_{F \in \mathsf{X}} \mathrm{L}(\{F\})$. But the phrasing "definable on some member" could be read as existential. You may want to tighten this.

34. **Line 257**: The proof picks a minimal-length $s_y^R$ among accessible right-handed points where $p$ is true, sets $i = |s_y^R| + 1$, and then argues about position $i$. But $R^{\rightarrow}$ accesses *all* right-handed points from any left-handed point, so the choice of $s_y^R$ depends only on the valuation of $p$. The minimality condition is doing real work (it ensures that $s_y^R \oplus \langle 0 \rangle$ and $s_y^R \oplus \langle 1 \rangle$ are the shortest extensions), but the argument doesn't seem to *use* minimality — it only uses that $i = |s_y^R| + 1$, and any $s_y^R$ where $p$ is true would do. Is minimality needed here, or is it a leftover from an earlier version of the argument?

35. **Line 261 (third claim)**: The argument restricts to models where $p$ is true at exactly one world. In the Humberstone setting, truth is persistent, so if $p$ is true at a point, it's true at all refinements. This means $p$ can never be true at exactly one possibility in a non-trivial Humberstone model. The argument works because we're considering *Kripke* frames here (where persistence doesn't apply), but it might be worth adding a word to make this contrast explicit.
