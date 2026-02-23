# Editorial Notes: "Humberstone on Possibility Frames"

---

## Introduction (lines 75–81)

**Unclear reference — "the non-modal parts of the view"**
> "The non-modal parts of the view are discussed again in section 6.44 of *The Connectives*..."

It's not obvious what "non-modal parts" refers to in a paper whose whole point is modal logic via possibilities. Consider specifying: the semantics for the propositional connectives? The basic structure of possibilities?

**Repetitive — "possible"**
> "...make some notes about its logic, and end with a survey of the many possible applications it has."

"Possible applications" is redundant with "survey" and slightly ironic in a paper about possibility. Consider "potential applications" or simply "applications."

**Loose pronoun — "it"**
> "...when a story $x$ is a proper part of story $y$, what that means is that everything settled in $x$ is still true in $y$, and more things besides are settled. When this happens, we'll call $y$ a proper *refinement* of $x$."

"When this happens" is slightly vague. Could be tightened to "In that case" or the sentence recast to avoid it.

**Sentence that could be shortened**
> "It's not that *A Study in Scarlet* is a story. It has proper parts which are stories."

The first sentence is puzzling—did you mean "It's not *just* that *A Study in Scarlet* is a story"? If so, say so. If the point is that the novel has proper parts that are also stories, the two sentences could be merged: "*A Study in Scarlet* is itself a story with proper parts that are also stories."

**Unclear phrasing — "For most purposes it will be more convenient..."**
> "For most purposes it will be more convenient to use the more general notion of *refinement*, where each story counts as an improper refinement of itself."

"More convenient than what" is not stated. Convenient compared to the "proper refinement" notion? Worth clarifying.

---

## Section 2 — The Formal Structure

### Basic Language (lines 87–106)

**Terminological inconsistency introduced without clear motivation**
> "I'll call this a *possibility frame* in most contexts, but a *Humberstone frame* when I'm comparing it to similar structures..."

This is fine as a policy, but the sentence is buried mid-paragraph. It might be worth putting this distinction in a more prominent spot — e.g., as a short remark or footnote at first use — since both terms will recur throughout.

**Typo / wrong index in persistence claim**
> "First, every sentence in the language is persistent. If $\mathcal{M} \models_x A$ and $x \leqslant y$, then $\mathcal{M} \models_x A$."

The conclusion should be $\mathcal{M} \models_y A$, not $\mathcal{M} \models_x A$.

**Unclear pronoun — "this"**
> "This is, as Humberstone notes, easier to state using this definition of $\neg$."

Two uses of "this" in quick succession refer to different things (the refinability claim; the definition of negation). Consider: "The general form of refinability is easier to state using the truth conditions for $\neg$ given above."

**Sentence that could be shortened**
> "In this paper, I'm going to discuss three extensions of this language. I'll introduce them in reverse order of how much they are discussed in Humberstone..."

Could be: "I'll discuss three extensions of this language, in reverse order of their prominence in Humberstone."

### Infinitary Disjunction (lines 109–115)

**Vague claim — "things could easily have been otherwise"**
> "Again, it's fairly simple to show that this addition to the language will preserve persistence and refinability. But while this is simple, it is significant, because things could easily have been otherwise."

"Things could easily have been otherwise" is too vague to be informative. What could have failed? Does infinitary conjunction not preserve these properties? A clause explaining what the contrast case is would help.

### Quantifiers (lines 119–157)

**Internal note to address**
> "following a suggestion in @Humberstone1981a [xxxx]"

Placeholder page number left in. Needs filling before submission.

**Long and dense paragraph — consider breaking up**
The paragraph beginning "The $\forall\exists$ pattern in the atomic clauses is necessary..." (line 153) covers two distinct points: (1) why the $\forall\exists$ pattern is needed, and (2) when the clauses simplify. These could be separated for readability.

**Unclear pronoun — "this"**
> "This is a possibilist treatment of the universal quantifier, in contrast to the actualist quantifiers discussed in @HarrisonTrainor2019. I'll return in @sec-quant to the reasons we are best off using possibilist quantifiers..."

"This" at the start refers back to the whole quantifier setup, which is fine, but "the reasons we are best off" slightly presupposes the conclusion. Consider "I'll return in @sec-quant to whether possibilist quantifiers are preferable, and the difficulties they raise."

### Modal Operators (lines 161–207)

**Unclear pronoun — "it"**
> "But while this is tempting, it isn't compulsory."

"It" refers to reading the truth conditions as explanatory right-to-left. Fine here, but "this picture isn't compulsory" would be clearer.

**Incomplete sentence / unclear passage**
> "I don't see how to prove there isn't a weaker condition that would also work, it's possible we could use the refinability of A to find some weaker condition, but I don't quite see how that would work. So I think **RRef++** also follows from this way of thinking about accessibility."

This paragraph ends with hedging ("I don't see... I don't quite see...") and then asserts **RRef++** follows. The logic is confusing: does it follow, or don't you know if something weaker would also work? These are separate questions. The paragraph seems unfinished; it may need either a proper proof sketch or a more explicit acknowledgment that this is a gap.

**Internal note — missing page number**
> "As Holliday points out [note to Claude, we need page number for this]"

Author note left in the text — needs a page number and removal of the note before submission.

**Unclear — weakened condition stated incorrectly**
> "All we need is that if $x \leqslant x'$ and $xRy$ then there is some $z \geqslant y$ such that $xRy$."

The conclusion "$xRy$" is the same as the hypothesis. Presumably the condition should end "$x'Rz$" or similar. This needs correcting.

---

## Section 4 — Logics Determinable on Humberstone Frames

**Typo — wrong sets compared**
> "From this it follows that $\mathrm{ML}(\mathsf{K}) \neq \mathrm{ML}(\mathsf{K})$."

Both sides are $\mathrm{ML}(\mathsf{K})$. One should presumably be $\mathrm{ML}(\mathsf{H})$.

This same error appears earlier in the same paragraph:
> "I do have a proof that if we allow infinite disjunction... then $\mathrm{ML}(\mathsf{K}) \neq \mathrm{ML}(\mathsf{K})$."

**Inconsistent notation — $R^{\rightarrow}$ vs $R^{\leftarrow}$**
In the definition of the accessibility relations (line 223), you write:
> "$xR^{\leftarrow}_iy$ iff $x$ is right-handed..."

But you introduced the family of relations as $R^{\rightarrow}_i$. The superscripts $\rightarrow$ and $\leftarrow$ are used inconsistently here — check which is intended and make uniform throughout (this persists into the discussion of (\ref{Splitting})).

**Unclear antecedent — "it"**
> "It won't matter here exactly what these weakenings are, but what does matter is that he shows that using these weakened frames, we can determine logics which are not determinable on any class of Kripke frames."

"He" refers to Holliday, but it's a few clauses away from the name. Consider "but what matters is Holliday's result that..."

**Sentence that could be shortened**
> "he notes that while the fact that every Kripke frame is a Humberstone frame and every Humberstone frame is a full possibility frame, $\mathrm{ML}(\mathsf{K}) \subseteq \mathrm{ML}(\mathsf{H}) \subseteq \mathrm{ML}(\mathsf{FP})$, and while $\mathrm{ML}(\mathsf{K}) \subsetneq \mathrm{ML}(\mathsf{FP})$ implies that one of those inclusions is strict, it isn't clear which one."

This sentence has a dangling "while the fact that..." that never resolves grammatically. Suggest splitting into two sentences.

**Typo**
> "Since $s_y^R \oplus \langle 0 \rangle$ has a 0 at it's $i$'th position"

"it's" should be "its."

**Truncated section**
> "Putting these together, the sentences valid"

Line 263 ends mid-sentence. Presumably there is missing text here.

---

## Section 5 — Quantifiers and Necessitism

This section (line 265) is listed as a placeholder (`#sec-quant`) with no content. As noted, section 3 is also unwritten. No editorial notes possible yet.

---

## Section 6 — Conditionals

**Repetitive — "natural"**
> "It is natural to think about whether that is true in largely metaphysical terms... And as @Lewis1973a argued, it is natural to answer that question negatively."

"Natural" appears twice in two sentences. The second use could be replaced: "Lewis argued that the answer is no."

**Unclear — "largely metaphysical terms"**
> "It is natural to think about whether that is true in largely metaphysical terms, asking whether there really is guaranteed to be a single nearest world..."

"In largely metaphysical terms" is vague. You immediately clarify with the question about nearest worlds, so the phrase "in largely metaphysical terms" adds little. Consider cutting it.

**Unclear pronoun — "this"**
> "A related, but I think, preferable, move is to analyse conditionals not in terms of possible worlds, but in terms of possibilities."

The preceding sentence describes the supervaluation move as an option "discussed by Humberstone." It's not entirely clear what "related" refers to — related to the supervaluationist move, or to the general Lewisian problem? A brief gloss would help.

**Possible citation issue**
> "The four conditions are directly quotes from his paper..."

"Directly quotes" should be "direct quotes." Also, if they are direct quotes, copyright/attribution norms for a philosophy journal may require either block quotation or explicit acknowledgment. Worth checking.

**Unclear — "by these lights"**
> "This isn't convincing on its own though. For one thing, as already noted, we might not need **UpR**. For another, by these lights we should worry that the system is incomplete..."

"By these lights" is somewhat colloquial and the referent is slightly unclear — by the lights of the tense-logic motivation? Consider "By the same reasoning..."

**Repetitive — "one of" / "there are... there are"**
> "There are a couple of reasons to be unhappy with this way of getting out of the problem. One is that... But a bigger one is that..."

Not exactly repetitive, but the structure is weak. "A bigger one" is vague — bigger in what sense? Suggesting: "More seriously, Fine's resolution..."

**Unclear pronoun — "them"**
> "He develops a theory of conditionals that doesn't use possible worlds, but instead uses incomplete states. These are not entirely unlike Humberstone's possibilities, but the resulting theory is quite different. I suspect the key distinction, the one that drives all of the rest of the results, is that Fine takes disjunctions to be true at a state only if a disjunct is true at that state."

"All of the rest of the results" — which results? This is the first time results are mentioned in this paragraph. A brief specification would help.

**Sentence that could be shortened**
> "This is the principle that @Humberstone2011 [1016] calls *Conv. Subj. Dilemma*, the key being that from $(A \vee B) \boxright C)$ one can infer $A \boxright C$."

"The key being that" is a dangling participial phrase. Suggest: "This is what @Humberstone2011 [1016] calls *Conv. Subj. Dilemma*: from $(A \vee B) \boxright C$ one can infer $A \boxright C$."

Also: there is an unmatched parenthesis in $(A \vee B) \boxright C)$.

**Unclear — "very unusual relationships"**
> "You need to have some very unusual relationships between Humberstone's family of similarity relations $S_w$ and $\geqslant$ in order for **Disjunction** to fail."

$S_w$ was introduced much earlier (in the discussion of Humberstone's argument for **Disjunction**) but not formally defined. A reader who has lost track of it may be confused. A brief reminder of what $S_w$ is, or a back-reference, would help.

**Unclear — the final paragraph of this section**
> "I can't construct an intuitive case where that happens that doesn't involve infinite sequences like in Bernadete's case, though I also don't have a proof that no such case can be constructed. This is all far from conclusive, but it seems plausible..."

This is honest, but the hedging accumulates ("I can't... I also don't have... far from conclusive... seems plausible"). Consider whether you can tighten this to one hedged claim rather than four.

---

## Conclusion

**Typo**
> "I've gone over two more uses of the possibilties framework..."

"Possibilties" should be "possibilities."

**Unclear — "two more"**
> "I've gone over two more uses of the possibilties framework, but there are many more things that we could imagine using it for. I'll end by briefly mentioning two of them."

The conclusion says you've gone over "two more uses" and will mention "two of them" (further uses). Since section 3 is unwritten, it's worth checking whether the count of "two more" is correct once that section exists.

**Unclear pronoun — "this"**
> "On this approach we don't get left with the unfortunate triple, which Lewis is committed to, of it being true in the story that $A \vee B$, but false that it's true in the story that $A$, and false that it's true in the story that $B$."

"This approach" refers to the possibilities approach to fiction just introduced. Fine, but the sentence itself is very long. Consider breaking after "this approach" or after "committed to."

---

## Global Notes

- The paper uses "we" and "I" somewhat interchangeably. Worth making a consistent choice.
- Bernadete's name is spelled "Bernadete" in one place and the example is attributed to "José @Bernadete1964." Confirm the spelling is consistent with the bibliography entry.
- The paper refers to section 3 (sec-quant) as being where you'll return to possibilist quantifiers, but that section has no content yet. Make sure the forward reference in the introduction (line 157) still makes sense once the section is written.
