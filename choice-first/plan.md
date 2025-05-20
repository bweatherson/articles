Three things that a decision theory has to do

1. Say what value individual options have
2. Say which options are preferable to which other options.
3. Say which options should be chosen from arbitrary sets of options

We get three orientations towards decision theory regarding which of these we take to have priority; which is first. But this is an ambiguous question, in at least five ways.

1. Metaphysically first; which things ground which other things.
2. Analytically first; which concepts are constructed out of which other concepts.
3. Mathematically first; which one we take as primitive in our formal modeling.
4. Causally first; which one we think drives the bus in human decision making.
5. Epistemologically first; which one we take to be evidence for which other one.

We could mix-and-match, we could be anti-foundationalist, we could indeed mix-and-match about whether to have foundations for some and not others. For instance, I think we should definitely be anti-foundationalist about the epistemology of decision theory. The only way to tell what the right methodology is is to just do some decision theory.

Causally, it is very hard to avoid the idea that values are primary, on combinatorial grounds if nothing else. When I look at 2000 goods in a store, I don't have the two million pairwise preferences that would be needed to explain my decision making on a preference first model. As long as you believe in higher level causation, that's consistent with values being constituted by preferences, but it certainly feels like I form pair wise preferences by consulting my values. (But maybe those values are constituted by yet further preferences; that's plausible.)

The other three are harder, and I want to defend the possibility of having a choices first approach. Indeed, I want to argue that a choices first approach has many virtues that are not always appreciated.

# Why not values

- Hard to define the units. What is it for this to have value 17?
- Labor theory of value would do, but I don't think it works. (Maybe see Dobb 1937, as cited by Sen, on being clear what the labor theory is.)
- Value just feels comparative, in a way that electrical charge doesn't.
- A lot of theorists agree, value is only defined up to positive affine transformation - why, because that preserves the relevant comparisons.

# Three Principles of Choice

Alpha: If a is choice-worthy from the bigger set, it's choice-worthy from the smaller set that it's in. Hard to give up, though Sen on cocaine is amusing.
Gamma: If a is choice-worthy from Delta, and choice-worthy from Theta, it's choice-worthy from their union.
Beta: If a and b are choice-worthy from some set, they are *equal*, i.e., equi-choice-worthy everywhere.

Choices based in preferences have to satisfy Alpha and Gamma. Choices based in complete preferences satisfy Beta.

# Terminological Convenience

Using preference talk we can define all sorts of nice properties like transitivity, independence, asymmetry, and completeness
Do we have to give up all of that if we move to choice-first approaches? No.
Clunky way of doing it; just look at choices from pair-sets. But this is both unmotivated, and not sufficiently strong.
First, a definition: a, b equal relative to a set S if for any subset of S containing both, a in c(S) iff b in c(S).
Transitivity is replaced by Cut (so-called because it kind of looks like Cut, and it Cuts out the middle man.)
  Note that Cut rules out making much progress here on social choice; just walk back into Condorcet paradox.
Independence becomes a rule about transformation
  Actually two rules: lottery independence and gamble independence
Completeness is turned into Beta, but it's changed in the process, see next section
Asymmetry becomes true by definition
  I think that's good; I don't think it's possible to prefer A to B and B to A, at least under those descriptions
  The value-first approach also has this result, though it does this for transitivity too
  I guess I think this should be true by definition, and preference-first approach can't do this, but both guesses are very tentative.

# Beta and the anti-incomplete arguments

There are natural counter-examples to Beta, e.g., Sartre's student. These are Hard Choices. Often this is interpreted as a claim about preferences, that preferences are incomplete, or that pairs of options are on a par.

A simpler way to treat the cases is that binary relations are inappropriate, or not precisely defined.

Maybe Broome is right that the preferences are vague. Maybe Dorr et al are right that if there are such things as preferences they have to be complete. But none of this implies that Beta holds, unless you accept a tight relationship between preference and choice.

Now that tight relationship does look somewhat plausible - but so does the failure of Beta, and so do the principles that Broome/Dorr bring up. We have to choose what to give up, and maybe it's the choice-preference link.

I'll argue as the paper goes on that choice-worthiness is related to determinate preference, not preference. And 'determinate' is a little polysemous here. Determinate preference is, in turn, defined in terms of choice.

Maybe introduce Levi model here, and note that we're going to end up with something that gets these results

a is in c(S) iff exists a u in the representor such that a is optimal (maybe plus a weak dominance condition)
a is preferred to b is a vague claim, and the members of the representor are the precisifications

# Spencer, Gallow, and Multiple Equilibria

Spencer's objection to Gallow
Gallow's response
The IRI rejoinder
The simple Spencer rejoinder
How choice-theory handles it: something is choice-worthy if it maximises utility ex post.
Note this slides between the various suppositional approaches to value.

# Choice Under Ignorance

Option a: 10 if p, 0 otherwise
Option b: 3

What's p? Who knows. All agent knows is that it is proposition true in infinitely many worlds, and false in infinitely many.
Could we just say it has probability 1/2?
Eh, we can tell it is equivalent to q&r for some q,r such that all four Boolean combinations are true in infinitely many, false in infinitely many. Principle of Indifference goes haywire in infinite contexts, as Keynes pointed out.
Feels like anything goes, as with Spencer.
Could we say maximin, and hence option b? Well, probably not; let's add a third option.

Option c: 0 if p, 10 otherwise

Now b seems inadmissible, since whatever Pr we have for p, one of a, c is better. No consistent position where b is better.
So Gamma fails, which will be notable.

# Degenerate Games

Same as previous section, but assume the p is that other player chooses Left rather than Right.
And other player gets constant payout in every state of the game.
Textbook theory says that this is basically a choice under uncertainty.
Moreover, this seems right.
But still b is not ok if a and c are both there.
So again we have Gamma failing, and maybe Beta failing as well.

# Mixed Strategies

How can mixing be uniquely choice-worthy in Rock-Paper-Scissors?
Answer: something is choice-worthy iff it maximises utility once it is chosen.
It isn't that there is some pre-existing value (e.g., value supposing it is chosen) that matters; it's entirely ex post.
This also feels like it gets the Sartre case right, or at least the way Sartre wants.
You simply must choose.

# Lederman and Hard Choices

Why doesn't Sartre's student just join the resistance?
That way he can look after his sick mother during the day, and fight the Nazis at night.
Well, maybe it would seriously impugn his mother looking after; it would be like rearing cattle in the evening.
And maybe the resistance is no good around where he is.
But still, maybe it's 3,3, whereas the others are 10,0 and 0,10
Should he prefer 50/50 chance of the two good outcomes, or the 3,3?
  Why a 50/50 split? Don't ask
Harvey says the 3,3 has to be ok: primary argument
  If lottery better than a constant return, then one outcome of lottery has to be better than the constant
  Better here means that it is uniquely choice-worthy from the pair set.
  But neither of these are
  So the lottery doesn't have it's expected value
Can get to expected value being right from a handful of principles
  Harvey uses lottery independence plus expected value for one-dimensional
  Might be able to go even weaker, since independence gets you expected value given the other three von Neumann/Morgenstern assumptions
  At least, you'll get something like expected value: expected value of the computed utility (which we can call the utility)
Is it wrong to use vectors to model what's happening here?
  No
  Generalising Harvey's principle of NegDom: Lottery is preferred only if the constant is not choice-worthy from set of lottery outcomes + it
  That would follow from what Harvey says plus Gamma
  But we're scrapping Gamma
  The argument he gives for Gamma is very preference-first
So we get the intuitively right result: options that are just a little better than worst-case scenario along every dimension not choice-worthy
They aren't even choice-worthy when alternative is a lottery
This is consistent with lottery having non-final value because the alternative argument involves appeal to Gamma
Note that we have several cases already where we want to do without Gamma.
