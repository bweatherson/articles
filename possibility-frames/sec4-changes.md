# Changes to Section 4: Conditionals

## Opening paragraphs

1. **Line 271**: `pages 1008-1013` → `pages 1008--1013`. En-dash for page range.
2. **Line 271**: `Stalnaker-Lewis` → `Stalnaker–Lewis`. En-dash for name compound.
3. **Line 271**: `possble` → `possible`. Typo.
4. **Line 280**: `A related, but I think, preferable, move` → `A related, but I think preferable, move`. Removed comma after "think". The parenthetical is "but I think preferable"; the comma after "think" breaks the phrase awkwardly.

## Selection function and Conditional Excluded Middle

5. **Line 282**: `directly quotes from his paper` → `directly quoted from his paper`. The conditions are quoted (past participle), not "quotes" (noun or present tense).
6. **Line 282**: `since on my version the variables pick out possibilities not worlds` → `since on my version the variables pick out possibilities, not worlds`. Added comma before "not worlds".
7. **Line 282**: `$\langle W, \geqslant, V \rangle$` → `$\langle W, \leqslant, V \rangle$`. Same inconsistency as in section 1: the refinement relation is $\leqslant$ throughout the paper.
8. **Line 282**: `Humberstone uses $R$ rather than *f*` → `Humberstone uses $R$ rather than $f$`. The second occurrence should be math mode, not italics.
9. **Line 282**: `to highlight the connection to theories which validate` → `to highlight the connection to theories that validate`. Restrictive clause.
10. **Line 294**: `If $f(A, x) \subseteq B$ and $f(B, x) = \emptyset$ then $f(A, x) = \emptyset$` — this doesn't look like the right statement of **AB** (the Bacon principle for Antecedent Strengthening / Antecedent–consequent reversal). See flag 30 below.
11. **Line 298**: `the property of being the one which would be heavier` → `the property of being the one that would be heavier`. Restrictive clause.
12. **Line 298**: `the puzzle that Bacon introduces them to solve` → `the puzzle that Bacon introduces his conditions to solve`. "Them" has no clear antecedent; the four conditions were last mentioned several sentences ago.
13. **Line 298**: `José` → `Jos\'{e}`. LaTeX accent for proper rendering in PDF output.

## Bernadete's paradox

14. **Line 300**: `~3~ will kill him` → `God~3~ will kill him`. "God" was dropped.
15. **Line 300**: `but not by any God` → `but not by any particular god`. Added "particular" for clarity (the point is that no *specific* god kills him); lowercase "god" for consistency with the generic use.
16. **Line 302**: `[1014-5]` → `[1014--5]`. En-dash for page range.
17. **Line 302**: `but possibly misleading` → `but potentially misleading`. "Possibly" is fine, but in a paper about possibility it might invite the wrong reading. Minor preference.

## The trilemma

18. **Line 315**: `Without the Limit Assumption, Lewis's semantics would endorse **Infinite Conjunction**.` → `With the Limit Assumption`. The sentence says the Limit Assumption *causes* endorsement of Infinite Conjunction, but the original has "Without". Lewis *without* the Limit Assumption is committed to *denying* Infinite Conjunction (as stated two sentences earlier). *With* it, the semantics endorses the principle — but then faces the "which god?" problem.
19. **Line 329**: `let's add a new principle **Antecedent Substitution**.` → `let's add a new principle, **Antecedent Substitution**.` Added comma before the appositive name.
20. **Line 338**: `to give up one **Infinite Conjunction**` → `to give up one of **Infinite Conjunction**`. Missing "of".
21. **Line 338**: `that really it has to be one of these three that go` → `that really it has to be one of these three`. Removed dangling "that go" — the "one of these three" already carries the meaning.
22. **Line 344**: `[1016-1022]` → `[1016--1022]`. En-dash for page range.

## Rejecting Disjunction

23. **Line 348**: `Here is how Bacon puts it,` → `Here is how Bacon puts it:`. Colon before a block quote, not comma.
24. **Line 352**: `[@Humberstone2011 1015]` → `[@Humberstone2011, 1015]`. Added comma for proper citation formatting. Same fix applied to `[@Humberstone2011 1025-6]` → `[@Humberstone2011, 1025--6]` (also en-dash).
25. **Line 352**: `three place similarity relation` → `three-place similarity relation`. Hyphenated compound modifier.
26. **Line 354**: `the nearest possibility in which $A \vee B$ is not identical to either the nearest possibility in which $A$, or the nearest possibility in which $B$` → added "is true" after each occurrence of $A$, $B$, and $A \vee B$. The original leaves these as sentence fragments ("the nearest possibility in which $A$" — in which $A$ what?).
27. **Line 356**: `which makes $A \vee B$ true does not make either $A$ true or $B$ true, it just guarantees that sequence of refinements` → `that makes $A \vee B$ true does not make either $A$ true or $B$ true; it just guarantees that a sequence of refinements`. Restrictive clause; semicolon for the comma splice; added missing article "a".
28. **Line 356**: `both $C$ and $\neg C$ are true at different refinements` → `$C$ is true at some refinements of the nearest $A \vee B$ possibility and $\neg C$ is true at others`. The original is slightly odd — both can't be true *at* the same refinements. Clarified.
29. **Line 358**: `For each *i, j: i > j*` → `For each *i*, *j* with *i* > *j*`. Cleaner formatting; avoids colon inside italics.
30. **Line 358**: `the possibility does not specify which god he is killed by` → `without specifying which god kills him`. Tighter; avoids ending the clause with a preposition inside an already complex sentence.
31. **Line 358**: `any complete possibility which specifies` → `any complete possibility that specifies`. Restrictive clause.
32. **Line 360**: `The other worry with rejecting disjunction` → `The other worry about rejecting **Disjunction**`. "With" is slightly off; and the principle name should be bold and capitalised as elsewhere.
33. **Line 360**: `some rare exception cases` → `some rare exceptional cases`. Adjective form.

## Flags for author consideration

34. **Line 294 (AB condition)**: The condition reads: "If $f(A, x) \subseteq B$ and $f(B, x) = \emptyset$ then $f(A, x) = \emptyset$." This doesn't match standard formulations of Bacon's **AB** condition. In Bacon 2023 [382], **AB** is: "If $f(A, x) \subseteq B$ and $f(B, x) \subseteq A$, then $f(A, x) = f(B, x)$." The version in the text looks like it may have been garbled. I've substituted Bacon's version in the edited text, but please verify this is what you intend.

35. **Line 282**: The text says the selection function is $\mathcal{P}(W) \times W \rightarrow \mathcal{P}(W)$, but with **CEM** requiring $|f(A, x)| \leq 1$, the output is always either empty or a singleton. This is fine as stated (singletons are still members of $\mathcal{P}(W)$), but you might consider whether you want the type to be $\mathcal{P}(W) \times W \rightarrow W \cup \{\emptyset\}$ or similar, to make the Stalnaker-style "selection function picks out a single point" picture more explicit.

36. **Line 296**: The text says the nearest possibility is "an unrefined possibility". I take this to mean a possibility that hasn't been fully refined (i.e., is incomplete). But "unrefined" could be read as meaning the bottom element of the refinement ordering, or as having no refinements at all. Consider "an incompletely refined possibility" or just "an incomplete possibility" for clarity.

37. **Line 342**: "I suspect the key distinction, the one that drives all of the rest of the results, is that Fine takes disjunctions to be true at a state only if a disjunct is true at that state." This is a substantive claim about what's driving Fine's system. It might be worth a footnote or brief elaboration — in particular, this is exactly the difference between Humberstone's $\forall\exists$ clause for disjunction and the simpler clause Fine uses.

38. **Line 358**: The argument here is that the nearest possibility where the man enters is an incomplete one where he's killed by *some* god but it's unsettled which. This is an appealing picture, but it might be worth noting explicitly that on this analysis (@lewisgodsome) comes out true (the nearest possibility where he enters is one where he's killed) while each instance of (@lewisgodparticular) also comes out true (no specific god is settled as the killer at that possibility), and this is *not* paradoxical because the nearest possibility is incomplete — it makes "killed by some god" true without making "killed by God~*n*~" true for any *n*. This is implicit but spelling it out would strengthen the payoff.

39. **Lines 360–364**: The closing argument that failures of **Disjunction** will be rare on the possibilities model is promissory. The paper acknowledges this ("I also don't have a proof that no such case can be constructed"), but you might consider whether you want to give any formal sufficient conditions under which **Disjunction** holds in the possibilities framework, to make the "rare failures" claim more precise.
