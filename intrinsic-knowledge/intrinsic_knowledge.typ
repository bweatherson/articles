// Some definitions presupposed by pandoc's typst output.
#let blockquote(body) = [
  #set text( size: 0.92em )
  #block(inset: (left: 1.5em, top: 0.2em, bottom: 0.2em))[#body]
]

#let horizontalrule = line(start: (25%,0%), end: (75%,0%))

#let endnote(num, contents) = [
  #stack(dir: ltr, spacing: 3pt, super[#num], contents)
]

#show terms: it => {
  it.children
    .map(child => [
      #strong[#child.term]
      #block(inset: (left: 1.5em, top: -0.4em))[#child.description]
      ])
    .join()
}

// Some quarto-specific definitions.

#show raw.where(block: true): set block(
    fill: luma(230),
    width: 100%,
    inset: 8pt,
    radius: 2pt
  )

#let block_with_new_content(old_block, new_content) = {
  let d = (:)
  let fields = old_block.fields()
  fields.remove("body")
  if fields.at("below", default: none) != none {
    // TODO: this is a hack because below is a "synthesized element"
    // according to the experts in the typst discord...
    fields.below = fields.below.abs
  }
  return block.with(..fields)(new_content)
}

#let empty(v) = {
  if type(v) == str {
    // two dollar signs here because we're technically inside
    // a Pandoc template :grimace:
    v.matches(regex("^\\s*$")).at(0, default: none) != none
  } else if type(v) == content {
    if v.at("text", default: none) != none {
      return empty(v.text)
    }
    for child in v.at("children", default: ()) {
      if not empty(child) {
        return false
      }
    }
    return true
  }

}

// Subfloats
// This is a technique that we adapted from https://github.com/tingerrr/subpar/
#let quartosubfloatcounter = counter("quartosubfloatcounter")

#let quarto_super(
  kind: str,
  caption: none,
  label: none,
  supplement: str,
  position: none,
  subrefnumbering: "1a",
  subcapnumbering: "(a)",
  body,
) = {
  context {
    let figcounter = counter(figure.where(kind: kind))
    let n-super = figcounter.get().first() + 1
    set figure.caption(position: position)
    [#figure(
      kind: kind,
      supplement: supplement,
      caption: caption,
      {
        show figure.where(kind: kind): set figure(numbering: _ => numbering(subrefnumbering, n-super, quartosubfloatcounter.get().first() + 1))
        show figure.where(kind: kind): set figure.caption(position: position)

        show figure: it => {
          let num = numbering(subcapnumbering, n-super, quartosubfloatcounter.get().first() + 1)
          show figure.caption: it => {
            num.slice(2) // I don't understand why the numbering contains output that it really shouldn't, but this fixes it shrug?
            [ ]
            it.body
          }

          quartosubfloatcounter.step()
          it
          counter(figure.where(kind: it.kind)).update(n => n - 1)
        }

        quartosubfloatcounter.update(0)
        body
      }
    )#label]
  }
}

// callout rendering
// this is a figure show rule because callouts are crossreferenceable
#show figure: it => {
  if type(it.kind) != str {
    return it
  }
  let kind_match = it.kind.matches(regex("^quarto-callout-(.*)")).at(0, default: none)
  if kind_match == none {
    return it
  }
  let kind = kind_match.captures.at(0, default: "other")
  kind = upper(kind.first()) + kind.slice(1)
  // now we pull apart the callout and reassemble it with the crossref name and counter

  // when we cleanup pandoc's emitted code to avoid spaces this will have to change
  let old_callout = it.body.children.at(1).body.children.at(1)
  let old_title_block = old_callout.body.children.at(0)
  let old_title = old_title_block.body.body.children.at(2)

  // TODO use custom separator if available
  let new_title = if empty(old_title) {
    [#kind #it.counter.display()]
  } else {
    [#kind #it.counter.display(): #old_title]
  }

  let new_title_block = block_with_new_content(
    old_title_block, 
    block_with_new_content(
      old_title_block.body, 
      old_title_block.body.body.children.at(0) +
      old_title_block.body.body.children.at(1) +
      new_title))

  block_with_new_content(old_callout,
    block(below: 0pt, new_title_block) +
    old_callout.body.children.at(1))
}

// 2023-10-09: #fa-icon("fa-info") is not working, so we'll eval "#fa-info()" instead
#let callout(body: [], title: "Callout", background_color: rgb("#dddddd"), icon: none, icon_color: black, body_background_color: white) = {
  block(
    breakable: false, 
    fill: background_color, 
    stroke: (paint: icon_color, thickness: 0.5pt, cap: "round"), 
    width: 100%, 
    radius: 2pt,
    block(
      inset: 1pt,
      width: 100%, 
      below: 0pt, 
      block(
        fill: background_color, 
        width: 100%, 
        inset: 8pt)[#text(icon_color, weight: 900)[#icon] #title]) +
      if(body != []){
        block(
          inset: 1pt, 
          width: 100%, 
          block(fill: body_background_color, width: 100%, inset: 8pt, body))
      }
    )
}



#let article(
  title: none,
  subtitle: none,
  authors: none,
  date: none,
  abstract: none,
  abstract-title: none,
  cols: 1,
  margin: (x: 1.25in, y: 1.25in),
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: "libertinus serif",
  fontsize: 11pt,
  title-size: 1.5em,
  subtitle-size: 1.25em,
  heading-family: "libertinus serif",
  heading-weight: "bold",
  heading-style: "normal",
  heading-color: black,
  heading-line-height: 0.65em,
  sectionnumbering: none,
  pagenumbering: "1",
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  doc,
) = {
  set page(
    paper: paper,
    margin: margin,
    numbering: pagenumbering,
  )
  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)
  set heading(numbering: sectionnumbering)
  if title != none {
    align(center)[#block(inset: 2em)[
      #set par(leading: heading-line-height)
      #if (heading-family != none or heading-weight != "bold" or heading-style != "normal"
           or heading-color != black or heading-decoration == "underline"
           or heading-background-color != none) {
        set text(font: heading-family, weight: heading-weight, style: heading-style, fill: heading-color)
        text(size: title-size)[#title]
        if subtitle != none {
          parbreak()
          text(size: subtitle-size)[#subtitle]
        }
      } else {
        text(weight: "bold", size: title-size)[#title]
        if subtitle != none {
          parbreak()
          text(weight: "bold", size: subtitle-size)[#subtitle]
        }
      }
    ]]
  }

  if authors != none {
    let count = authors.len()
    let ncols = calc.min(count, 3)
    grid(
      columns: (1fr,) * ncols,
      row-gutter: 1.5em,
      ..authors.map(author =>
          align(center)[
            #author.name \
            #author.affiliation \
            #author.email
          ]
      )
    )
  }

  if date != none {
    align(center)[#block(inset: 1em)[
      #date
    ]]
  }

  if abstract != none {
    block(inset: 2em)[
    #text(weight: "semibold")[#abstract-title] #h(1em) #abstract
    ]
  }

  if toc {
    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 0em, below: 2em)[
    #outline(
      title: toc_title,
      depth: toc_depth,
      indent: toc_indent
    );
    ]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}

#set table(
  inset: 6pt,
  stroke: none
)

#show: doc => article(
  title: [Intrinsic Knowledge],
  authors: (
    ( name: [Brian Weatherson],
      affiliation: [University of Michigan],
      email: [] ),
    ),
  abstract: [Jonathon Stoltz's "Inferential Knowledge and What that Determines" discusses the idea that knowledge is (at least sometimes) #emph[intrinsically determined];. In this note, I discuss how that idea relates to contemporary work on the nature of intrinsicness, the nature of knowledge, and the nature of essences.

],
  abstract-title: "Abstract",
  sectionnumbering: "1.1.a",
  pagenumbering: "1",
  toc_title: [Table of contents],
  toc_depth: 3,
  cols: 1,
  doc,
)

Jonathan Stoltz's paper is really insightful; I learned a lot from it and I basically agree with the conclusion. In this note I wanted to make some observations about how these debates connect to some contemporary literature. In particular, I want to note how thinking about some of these older debates is useful for cleaning up some unclarity in a few related contemporary debates.

= Intrinsic Determination
<sec-intrinsic-determination>
I want to start from sort of the opposite end of the question about intrinsic determination to Stoltz. Let's think about how intrinsic determination could possibly fail to obtain. We're told that what it is for intrinsic determination to hold is (INT\*) is true.

/ (INT\*): #block[
K(#emph[p];) can produce D(K(#emph[p];) is a cognition in which #emph[p] is true).
]

Here's a very quick argument for that. Since K is factive, the fact that K(#emph[p];) determines that p.~And since K(#emph[p];) has #emph[p] as its content, what factivity means in this case is that #emph[p] is true. So K(#emph[p];) determines, i.e., produces a determination, that #emph[p] is true, and hence that K(#emph[p];) is a cognition in which #emph[p] is true.

Now something must be wrong with that 'quick argument'. Too many careful philosophers reject the thesis of universal intrinsic determination for it to be that simple to argue for it. And the obvious thing that's wrong with it is that it leaves out any role for #emph[intrinsicness];. We don't want to just ask whether K(#emph[p];) can produce this determination, but whether it can produce the determination in virtue of its intrinsic features.

Let's give a name to the state K(#emph[p];) which doesn't quite so strongly presuppose that it has certain features. Let's call it 'Fred'. Then we can reformulate the 'very quick argument' as follows.

#quote(block: true)[
#strong[Master Argument for Intrinsic Determination]

+ Fred is intrinsically some kind of knowledge state.
+ Fred is intrinsically a state with content #emph[p];.
+ By 1, it is intrinsic to Fred that it's content is true.
+ By 2 and 3, it is intrinsic to Fred that #emph[p];.
+ By 4 and (INT\*), intrinsic determination holds for Fred.
]

Since (INT\*) is a definition, the real issues are about 1 and 2. What I want to do for the rest of this note is go through how different views about the nature of intrisnicness, and different views about knowledge and essence, can motivate the various different views that Stoltz finds in the historical literature.

= Intrinsicness
<sec-intrinsicness>
The modern literature on intrinsicness is very confusing, because there are three different questions being discussed.

First, broadly speaking what kind of thing is intrinsicness. In #cite(<sep-intrinsic-extrinsic>, form: "prose", supplement: [§2]);, there are four broad kinds identified. For simplicity, I'll just focus on the last two: intrinsicness is a matter of a feature being internal, and intrinsicness is a matter of a feature being shared by all duplicates. These two most notably come apart with respect to identity properties, like #emph[being Fred];. That's plausibly internal, but it's not shared by duplicates. Fred could have an identical twin who is not numerical identical with them.

The second question is how to implement each of the various kinds. My one contributions to this literature @Weatherson2001-WEAIPA[#cite(<Weatherson2006-WEATAM>, form: "prose");] presupposed that the relevant kind is #emph[shared by duplicates];, and then fussed around with how to turn the idea that intrinsic properties are shared by duplicates into a full theory. At the time I thought this was the right way to think about intrinsicness, but I really didn't argue for that; I was mostly just working out details.

Then the third question is what kind of dispute the first question really is. Is there one true notion of intrinsicness, and the proponents of the different kinds of theory are debating what it is? Or are there different notions, and the real question is which of them is most useful, or perhaps which is most useful for different purposes? I used to hold the 'one true notion' view, but I've come around to thinking the more pragmatic approach is the right one. Different kinds of intrinsicness play different philosophical roles, and we need multiple notions around here. Indeed, we'll see roles for the different kinds just in this note.

= Knowledge as Extrinsic
<knowledge-as-extrinsic>
If we do understand intrinsicness as being shared by duplicates, then we quickly get to Śaṅkaranandana's view that all knowledge is extrinsic. Any knower has a duplicate in what #cite(<Williams2016>, form: "prose") calls a 'bubble world'; a world that is a duplicate of the actual world immediately around the knower, but where things go strange outside the bubble. Since the knower is duplicated, presumably the knowledge, i.e., Fred, is also duplicated. But since #emph[p] is false, it follows that either 1 or 2 must be false. Either Fred's counterpart has different content, falsifying 2, or Fred's counterpart is not factive, falsifying 1.

One might worry that's a little quick. That argument shows that all knowledge of the external world is extrinsic, but it doesn't show that knowledge of the internal world is extrinsic. If #emph[p] is the result of performing the #emph[cogito] inference, then wouldn't it still be a piece of knowledge when Fred's host's counterpart performs it?

To get around this problem, we'll draw on what #cite(<Sider2001>, form: "prose") says about 'maximal' properties. He notes that most properties of ordinary macroscopic objects, like knowers, are #emph[maximal];. That is, part of what it is to have that property is that one is not part of a larger thing that also has it. For example, I'm a thinker, but the mereological difference between me and one of my hairs is not. I'm thinking about epistemology, and I know a bit about it, and that mereological difference does not. But the mereological difference has duplicates who are maximal; intuitively they are worlds just like this one except that hair was plucked out. So knowing stuff about epistemology isn't shared by duplicates. Similarly if both I and my counterpart with one fewer hair perform the cogito, we both end up with knowledge. But my counterpart's duplicate in this world, i.e., the mereological difference between me and that hair, does not get knowledge that way. So even the knowledge one gets from the cogito is not extrinsic.

This shows that if we understand intrinsicness as being shared by duplicates, then Śaṅkaranandana is right and all knowledge is extrinsic. But that's not the most helpful way to think about knowledge and intrinsic determination. The same kind of argument shows that if we understand intrinsic value to be values that all duplicates share, then virtually nothing has intrinsic value. That doesn't seem like a particularly useful way of thinking.#footnote[There is a tension here in the approach to intrinsic value in #cite(<Moore1903>, form: "prose");. The 'isolation test' for intrinsic value that Moore uses only really makes sense on the shared by duplicates approach to intriniscness. But that's not a helpful way to think about intrinsic value. For much more on this, see #cite(<sep-value-intrinsic-extrinsic>, form: "prose", supplement: [§2]);.] A better approach is to say that some other notion of intrinsicness is relevant to intrinsic value, and, relatedly, to intrinsic determination of knowledge.

= Knowledge as Intrinsic
<sec-as-intrinsic>
To get the view that all knowledge is intrinsically determined, the simplest way is to adopt these three premises.

- Intrinsicness is a matter of interiority, and that implies that all essential properties of a thing are intrinsic to it.
- As #cite(<Williamson2000>, form: "prose") argues, knowledge is a mental state. What I take him to mean by that is that knowledge states are essentially pieces of knowledge. It is part of their identity condition that they are pieces of knowledge.
- The content of a mental state is essential to it.

Given the first and second premise, we can infer that it is intrinsic to Fred that it's a piece of knowledge. Given the first and third, we can infer that it is intrinsic to Fred that it has #emph[p] as its content. And then as in the Master Argument, we can infer that it is intrinsic to Fred that #emph[p];. Indeed, we can infer that it is intrinsic to Fred that it meets all the pre-requisites for being knowledge that #emph[p];.

The first and third premises here are, by philosophy standards, not that controversial. The second is much more controversial.

Before Williamson, the completely standard view was that beliefs were mental states, and to say that a belief amounted to knowledge was basically to positively evaluate it in a certain way. But being knowledge was no more part of the essence of the belief than being good was part of the essence of someone who was, as it turns out, mostly good. Williamson argued, convincingly to many, that this was the wrong way to look at things. He argued that we should reconceptualise knowledge in much the same way that we had, over the preceding decades, reconceptualised vision. There was an old view that states of visual awareness, seeings, were essentially states of visual appearance, and accidentally states where the appearances matched reality for the right reasons.#footnote[See \#Lewis1980d for some of the complications involved in trying to say more precisely what those accidental features are.] The better view was to say that seeings are a particular kind of mental state, and hallucinations and the like are not worse versions of the same state, but different states altogether. Similarly, knowledge states are not just better versions of belief states, they are different states.

My sense is that this view fits better with Buddhist and other South Asian traditions than the more traditional analytic view that knowledge states were essentially beliefs and accidentally knowledge. So I'll simply assume it in what follows. Then given the other two assumptions, which as I said are also widely accepted in recent analytic philosophy, we get that all knowledge is intrinsically determined.

We're still left with a third question. What kind of view could get the view that knowledge is (a) often intrinsically determined, (b) always intrinsically determined when it is inferential knowledge, but (c) sometimes extrinsically determined. To get this we need to question the third assumption above, that cognitive states have their contents essentially.

= The Genetic Conception
<sec-genetic>
Let's think a bit about the relationship between the genetic conception of knowledge, and the third premise above: content essentialism. As I said earlier, that premise is very widely accepted in recent analytic philosophy. One of the only discussions I know that rejects it is Marian David's paper "Content Essentialism" @David2002, which is also where I took the name.

In "Luminous Margins" @Weatherson2004-WEALMT I used David's idea in a way that's relevant to some issues raised in Stoltz's discussion. In particular, I wanted to make sense of the idea that a correct mathematical guess could easily have been mistaken. So if someone guesses that 193 plus 245 is 438, they don't thereby know that 193 plus 245 is 438, and they don't know it because that belief could easily have been wrong. But how could that be? If the belief has its content essentially, and mathematical facts don't change, then that belief is true in all nearby worlds. What I suggested, following David, was that the belief could easily have had a different content, and that different content could have been false.

In retrospect, it would have been useful to articulate the genetic conception of cognition to back up this thought. What's essential to the guess that 193 plus 245 is 438 is that it's a #emph[guess];. That's how it came about, and on the genetic conception that's what is essential to it. That very guess could easily have been the guess that 193 plus 245 is 448. Because of that it could easily have been false. I was interested in how this related to ideas of safety, but let's set that aside for now and focus on the idea of essence.

There is one quick way to argue against content essentialism that doesn't go through, but which fails in an interesting way. Given content externalism, the content of a cognitive state is not intrinsic to it. Given that essential properties are intrinsic, it follows that the content is not essential, as required. This argument fails because it turns on an equivocation on 'intrinsic'. Content externalism says that the content of a cognitive state is not shared #emph[with its duplicates];. It says that content is not intrinsic on the understanding of intrinsicness as being shared by duplicates. That notion of intrinsicness is useful, especially for characterising theses like content externalism, but it isn't the one we're primarily working with here. On the understanding of intrinsicness as something more like internality, content might be essential even if it isn't shared by duplicates, just like identity can be essential without being shared by duplicates.

The genetic conception of cognition might remind the reader of the thesis, associated with #cite(<Kripke1980>, form: "prose");, of origin essentialism. Origin essentialism is the thesis that things in general have their origins essentially. But there are two important distinctions between the genetic conception and origin essentialism that are a bit important.

Origin essentialism is a very general thesis about the essences of things in general. The genetic conception is just about cognitive states.

And in the literature following Kripke, origin essentialism is rarely distinguished from a nearby thesis: the necessity of origins. The necessity of origins thesis is that necessarily, if a thing exists, it has the origins it actually has. It isn't unusual to see that thesis simply equated with origin essentialism.#footnote[The clearest version I've found of that is in the opening of Graham Forbes's "Origins and Identities" #cite(<Forbes2001>, form: "year");, where he starts with a definition of origin essentialism, and the definition is a statement, in quantified modal logic, of the necessity of origins thesis.] Intuitively, origin essentialism and the necessity of origins could be distinct.

It isn't true in general that a thing has a property essentially iff it necessarily has it. For instance, this coffee cup is necessarily such that 193 plus 245 is 438, but I don't think that's part of the essence of the coffee cup. Following #cite(<Fine1994b>, form: "prose");, we might think that Socrates is necessarily a member of the singleton set containing Socrates, but he isn't essentially a member of that set. (Conversely, the singleton does essentially have Socrates as a member.) I think the criticisms that Fraser MacBride and Frederique Janssen-Lauret #cite(<MacBrideJL2022>, form: "year") make of the assumptions about the metaphysics of sets behind that example are fairly convincing. Still, there are enough cases where essential properties and necessary properties come intuitively apart that we should keep the two theses, origin essentialism and the necessity of origins, separate.

That last sentence probably won't be too controversial in very recent philosophy. Fine's argument convinced a lot of philosophers to distinguish modal claims and essential claims. But the history of how it did so was surprising. Fine's paper had relatively little uptake when it first came out. Google Scholar only reports 24 citations to it before 1999. But especially after 2010, it became standard to distinguish modal claims from claims about essence.#footnote[I think there is an identifiable #emph[modal era] in analytic philosophy, running from roughly 1970 to 2010. The equation of various claims with claims in the language of modal logic or conditional logic is a key part of that era. But this volume isn't the place to go into differences between contemporary philosophy and (very) early 21st century philosophy.]

This is all by way of saying that when I was discussing content essentialism back in 2004, I wasn't distinguishing it from the claim that in any world where a cognitive state exists, it has the content it actually has. Now it is plausible that the essentialist thesis entails the necessity thesis; that is, if something has a feature essentially it has it necessarily. That could be true even if necessary properties are not always essential. And that's all we need to argue that if a token guess could have easily had a different content, then it does not have its content essentially. With that in mind, let's return to the three theses about intrinsic determination we were trying to validate.

= Inferences and The Genetic Conception
<inferences-and-the-genetic-conception>
Start with these three assumptions:

+ Any essential property is an intrinsic feature.
+ Any knowledge state is essentially a knowledge state.
+ Any cognitive state, including any knowledge state, has its genesis essentially.

Now consider any case where someone knows some propositions, and they properly infer some further proposition #emph[p] from them. Call the resulting attitude towards #emph[p] Fred. Since this is a proper inference from knowledge, I assume Fred is a bit of knowledge.

By 2, the prior propositions Fred is inferred from are essentially bits of knowledge. By 3, it is essential to Fred that it was inferred from these particular prior states. By 2, it is essential to those states that they are knowledge states. Putting these together, it seems to follow that it is essential to Fred that it was inferred from knowledge.

Now we have to be a bit careful here. If we aren't equating essential properties with necessary properties, we can't simply conclude that essential properties are closed under entailment. Still, the move here doesn't look too controversial. All I've done is say that it isn't just the numerical identity of the origins of a state that are essential to the state, but also the essential features of those origins. That seems like a plausible move even if essences are not in general closed under entailment.

Is it also part of the essence of Fred that the inference was proper? That isn't quite as obvious to me. But we probably don't need it. All that we need is that the essence of Fred determines that the inference was proper. Given the identity of the earlier states, including their status as knowledge, and the fact that Fred was inferred (directly) from them, it seems like it should follow that the inference was proper. Again, without assuming essences are closed under entailment this won't mean this propriety is part of Fred's essence. But here we're trying to prove something weaker, namely that Fred's essence determines that Fred is knowledge. That is true as long as the essences of Fred and it's predecessors determine that the inference to Fred is proper. That will be true as long as propriety is non-contingent, which it plausibly is.

So putting all this together, we get that it is essential to Fred that it is knowledge, and indeed knowledge that #emph[p];. It couldn't be knowledge of something else while being the kind of inference it was from the premises it was from. By 1, it is intrinsic to Fred that it is knowledge that #emph[p];. From that it follows that #emph[p] is true, and indeed that Fred meets all of the pre-requisites for knowledge. So inferential knowledge will be intrinsically determined on this picture, as required.

= Perceptions and The Genetic Conception
<sec-perception>
The final part is trickier. Can we get an argument that there is knowledge which is extrinsically determined? I think we can, though it requires a carefully worked out case, and an extra assumption. The key move is going to be rejecting content essentialism; in the circumstances where knowledge is extrinsically determined, it's plausible that the content of a cognitive state is not essential to it.

Start with a case that's relatively simple. A person sees a rope in terrible light. They form the true belief that it is a rope, not a snake. But the light is terrible. That very method of belief formation could easily have led to the belief that there was a snake. So on the genetic conception of cognition, that very cognition could have been the cognition that there was a snake. That is to say, this is plausibly a case where content essentialism fails. What's essential to the cognition is that it is based on visual appearances in terrible light. Those appearances are both temporally and modally unstable. Even when they are right, it isn't part of their essence that they are right.

This is plausibly a case where content essentialism fails, but it is not yet a case where knowledge is extrinsically determined. After all, in this kind of terrible light, even true cognitions about the world around one are lucky guesses, and hence not knowledge. What we need, and here I'm drawing on #cite(<WilliamsonLofoten>, form: "prose");, are cases that are better than lucky guesses, but only #emph[just] better than lucky guesses.

Change the case so that the light is poor, but not terrible. Now it is plausible that the viewer does know that there is a rope, rather than a snake. But is this intrinsically determined? In poor light, people do make mistakes. That they perceived the rope as a rope rather than as a snake might not be essential to the cognition, even though their perception is reliable enough that they do indeed get knowledge.

What's crucial here is that the KK thesis fails for perceptual knowledge in poor but not terrible conditions for perception. This is the case that Stoltz sets aside at the start of §4, though from what he says about inferential knowledge, I don't think that there's anything that I'm particularly disagreeing with. In any case where KK fails for perception, it seems to me that the genetic conception of cognition will imply that intrinsic determination also fails. The perceptual state is not essentially a perception that #emph[p];, which it needs to be for the argument for intrinsic determination to go through.

= Conclusion
<conclusion>
Thinking about intrinsic determination helps shed light on several areas of contemporary philosophy that could use some extra clarity. To understand whether, and when, knowledge is intrinsically determined, we need to at least do the following. First, we have to distinguish intrinsicness as sharing by duplicates from intrinsicness as internality. Second, we have to think through the implications of the genetic conception of cognition, and how that is somewhat, but not exactly, like origin essentialism. Third, we need to distinguish essential properties from necessary properties. And fourth, we need to work through how perceptual knowledge works in situations that are far from perfect perceptual situations, but still good enough for getting knowledge.

When we do all these things, we can see that all of the positions adopted in the Buddhist tradition can be grounded in combinations of views that are adopted in various places today. More importantly, by doing this, we get a better understanding of what really separates the different contemporary views.

#bibliography("/Users/weath/Documents/quarto-articles/brian-quarto.bib")

