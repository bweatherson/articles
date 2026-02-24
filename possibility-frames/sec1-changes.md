# Changes to Section 1: The Formal Structure

## The Basic Language

1. **Line 87**: `a countable set $\mathcal{P}$ countable infinity of propositional variables` → `a countable set $\mathcal{P}$ of propositional variables`. The original has a garbled phrase — looks like a leftover from revising between "countable set" and "countable infinity".
2. **Line 87**: `$\neg$, $\wedge$ and $\vee$` → `$\neg$, $\wedge$, and $\vee$`. Oxford comma for consistency.
3. **Line 87**: `a transitive refinement relation $\geqslant$ on them` → `$\leqslant$`. The relation is introduced as $\leqslant$ everywhere else in the paper. Using $\geqslant$ here is inconsistent and potentially confusing.
4. **Line 87**: Removed `just` from "a simple language that just has" — the word adds nothing and the sentence is cleaner without it.
5. **Line 89**: `$V$ is a function from $\mathcal{P}$ to $W$` → `$V$ is a function from $\mathcal{P}$ to $\wp(W)$`. $V$ maps each propositional variable to a *set* of possibilities (those where it's true), not to a single possibility. The constraints and usage throughout confirm this.
6. **Line 94**: `$A \rightarrow B =_{df} A \vee \neg B$` → `$A \rightarrow B =_{df} \neg A \vee B$`. The material conditional is $\neg A \vee B$, not $A \vee \neg B$.
7. **Line 103**: `If $\mathcal{M} \models_x A$ and $x \leqslant y$, then $\mathcal{M} \models_x A$` → `then $\mathcal{M} \models_y A$`. Typo: the consequent should be about $y$, not $x$ again.

## Infinitary Disjunction

8. **Line 109**: `its definition of truth at a possibility is:` → `its truth at a possibility is defined as follows:`. The original is slightly awkward ("its definition ... is" followed by a displayed formula). The revision is more natural.

## Quantifiers

9. No changes to this subsection.

## Modal Operators

10. **Line 161**: `save just that I'll have` → `save that I'll have`. "Save just that" is a slightly unusual phrasing; "save that" is the standard idiom.
11. **Line 172**: `accessibility is not something that can be gained` → `accessibility is not something gained`. Tighter phrasing.
12. **Line 172**: The gloss on **RDown** read "accessibility cannot be gained by adding detail to the target." But **RDown** says that if $xR_iy$ and $y \leqslant y'$, then $xR_iy'$, i.e., accessibility is preserved when the *target* is refined. The original gloss describes gaining accessibility, but the constraint is about not *losing* it. Changed to: "accessibility cannot be lost by adding detail to the target."
13. **Line 172**: `$x'$ can access *y*` — the italics on *y* look like a formatting accident (it's a math variable, not emphasis). Changed to `$y$`.
14. **Line 174**: `the truth conditions for the box operator is` → `the truth condition for the box operator is`. Subject–verb agreement (singular "condition" or plural "conditions ... are"). Changed to singular to match "is".
15. **Line 182**: `If we just spell out` → `If we spell out`. Removed unnecessary "just".
16. **Line 186**: `$\exists y \, (x R_i y \Rightarrow \mathcal{M} \models_y A)$` → `$\exists y \, (x R_i y \text{ and } \mathcal{M} \models_y A)$`. The simple diamond clause should use conjunction, not material implication. With $\Rightarrow$, the formula would be trivially satisfied by any $y$ not accessible from $x$.
17. **Line 189**: In the argument for **RDown** implying Official → Simple: "there must be some refinement which can access a point where $A$ is true, and so by **RDown**, $x$ itself can access that point." The argument actually uses **UpR** (accessibility is inherited downward from refinements to the original point), not **RDown**. But the text says **RDown** implies Official → Simple, and the paragraph before sets up this direction explicitly. **Flag for author**: please check whether the proof sketch here has the directions right, or whether the labels on the two directions should be swapped.

## Modal Constraints

18. **Line 197**: `[note to Claude, we need page number for this]` → `[note to self: we need a page number for this]`. Changed the internal note to be addressed to the author rather than to me.
19. **Line 197**: `All we need is that if $x \leqslant x'$ and $xRy$ then there is some $z \geqslant y$ such that $xRy$.` → `$x'Rz$`. The original has $xRy$ in both the antecedent and consequent, which is trivially true. From context, the weakened condition should say that if $x \leqslant x'$ and $xRy$, then there is some $z \geqslant y$ such that $x'Rz$. Also added a colon after "the key fact" for clarity.
20. **Lines 199–206**: The final three paragraphs of this subsection (beginning "So we need other arguments..." through "...I think **RRef++** also follows from this way of thinking about accessibility.") have been **removed** from the edited version. See flag below.

### Flags for author consideration

21. **Lines 199–206 (removed paragraphs)**: These three paragraphs discuss Humberstone's arguments for the constraints beyond their role in ensuring persistence and refinability: the tense-logic argument, and the more compelling argument from defining accessibility in terms of modal truths (analogous to canonical model construction). This material is interesting but the writing is noticeably rougher than the rest of the section — it reads like a draft that hasn't been fully worked through yet. In particular:
    - The argument about tense logic (line 199) is presented and then immediately undercut ("This isn't convincing on its own though"), which makes the paragraph feel like thinking-aloud.
    - The final paragraph (line 205) contains some hedging ("I don't see how to prove there isn't a weaker condition..., it's possible we could use the refinability of A..., but I don't quite see how that would work") that suggests the argument isn't finished.
    - The transition from talking about $\Box_i A$ to talking about just $A$ in line 205 is confusing ("So if $\mathcal{M} \nmodels_x A$, there must be some refinement $x'$..." — this seems to be restating refinability for arbitrary $A$, but the argument is supposed to be about **RRef++**).

    I've removed these paragraphs from the edited version so you can rework them separately. If you'd prefer them left in with only light edits, let me know and I'll restore them.

22. **Line 186 / Diamond Simple**: Please verify the fix from $\Rightarrow$ to "and" — this seems clearly correct (the simple diamond should be existential conjunction), but it's a substantive change to a formal definition.

23. **Line 189 proof sketch**: As noted in item 17, the argument for why [$\Diamond_i$]~Official~ implies [$\Diamond_i$]~Simple~ appeals to **RDown**, but the step described (inheriting accessibility from a refinement back to the original point) sounds like **UpR**. Either the proof sketch or the labelling of the two directions may need correcting.
