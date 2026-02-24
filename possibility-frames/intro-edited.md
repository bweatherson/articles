---
title: "Humberstone on Possibility Frames"
abstract: |
  In his 1981 paper "From Worlds to Possibilities", Lloyd Humberstone developed an approach to modal logic using _possibilities_ rather than possible worlds. Possibilities, unlike worlds, may be incomplete. This paper sets out the possibility frame approach to modal logic, proves some results about its logic (including that no finitary modal logic is determinable on Humberstone frames), and surveys several applications, including to conditionals, vagueness, and fiction.
date: Feb 23 2026
number-sections: true
draft: false
execute:
  echo: false
  warning: false
author:
  - name: Brian Weatherson
    url: http://brian.weatherson.org
    affiliation: University of Michigan
    affiliation_url: https://umich.edu
    orcid_id: 0000-0002-0830-141X
categories:
  - logic
  - metaphysics
bibliography:
 - /Users/weath/Documents/quarto-articles/brian-quarto.bib
format:
  html:
    fig-format: png
    fig-width: 10
    fig-height: 7
    embed-resources: true
  pdf:
    documentclass: article
    classoption: twoside
    keep-tex: true
    geometry:
      - paperheight=10in,
      - paperwidth=7in,
      - top=1in
      - bottom=1in
      - inner=0.8in
      - outer=0.8in
      - headsep=0.25in
      - headheight=1in
      - footskip=0.35in
    pdf-engine: xelatex
    mathfont: EB Garamond Math
    mainfont: EB Garamond Math
    sansfont: EB Garamond SemiBold
    mainfontoptions:
      - ItalicFont=EB Garamond Italic
      - BoldFont=EB Garamond SemiBold
    fontsize: 10.5pt
    linkcolor: blue
    urlcolor: blue
    colorlinks: true
    linestretch: 1
    link-citations: true
    link-bibliography: false
    output-file: "Humberstone on Possibility Frames"
    include-in-header:
      - maketitle.tex
      - body-style.tex
      - doi-setup-aggressive.tex
      - text: |
          \newcommand{\nmodels}{\mathrel{\ooalign{$\models$\cr\raisebox{-0.001ex}{\hss$\mkern-1mu/\hss$}\cr}}}
          \newcommand{\llbracket}{[\![}
          \newcommand{\rrbracket}{]\!]}
          \setlength\heavyrulewidth{0ex}
          \setlength\lightrulewidth{0ex}
          \usepackage[lines=2]{lettrine}
          \cehead{Draft of February 23, 2026}
          \DeclareSymbolFont{symbolsC}{U}{txsyc}{m}{n}
          \DeclareMathSymbol{\boxright}{\mathrel}{symbolsC}{128}
nocite: |
  @Humberstone1981a
---

In his 1981 paper "From Worlds to Possibilities", Lloyd Humberstone shows a way to do modal logic without the apparatus of possible worlds. Instead of worlds, he uses _possibilities_, which may, unlike worlds, be incomplete. The non-modal parts of the view are discussed again in section 6.44 of _The Connectives_, though the differences between the view there and the 1981 view are largely presentational. In this paper I'll set out this _possibility frame_ approach to modal logic, make some notes about its logic, and end with a survey of the many possible applications it has.

Mathematically, possibilities are just points in a model, just like possible worlds are points in different kinds of models. But it helps to have a mental picture of what kind of thing they are. In "From Worlds to Possibilities", Humberstone notes that one picture you could have is that they are sets of possible worlds. This isn't a terrible picture, but it's not perfect for a couple of reasons. For one thing, as Humberstone notes, part of the point of developing possibilities is to do without the machinery of possible worlds. Understanding possibilities as sets of possible worlds wouldn't help with that project. For another, as Wesley @Holliday2025 [271--2] notes, the natural way to generate modal accessibility relations on sets of worlds from accessibility on the worlds themselves doesn't always work the way Humberstone wants accessibility to work. So let's start with a different picture.

Possibilities, as I'll think of them, are _stories_. To make things concrete, let's focus on a particular story: _A Study in Scarlet_ (@ConanDoyle1995), the story in which Sherlock Holmes was introduced. That story settles some questions, both explicitly, e.g., that Holmes is a detective, and implicitly, e.g., that Holmes has never set foot on the moon. But it leaves several other questions open, e.g., how many cousins Holmes has. It's not just that _A Study in Scarlet_ is a story. It has proper parts that are stories. The first chapter is a story, one that tells of the first meeting between Holmes and Watson. And arguably it is a proper part of a larger story, made up of all of Conan Doyle's stories of Holmes and Watson. When a story $x$ is a proper part of story $y$, what that means is that everything settled in $x$ is still true in $y$, and more things besides are settled. When this happens, we'll call $y$ a proper _refinement_ of $x$. For most purposes it will be more convenient to use the more general notion of _refinement_, where each story counts as an improper refinement of itself.

Following Humberstone, I'll write $x \leqslant y$ to mean that $y$ is a refinement of $x$. As he notes, this notation can be confusing if one thinks of $x$ and $y$ as sets, because in that case the refinement will typically be _smaller_.^[@Holliday2025 writes $y \sqsubseteq x$ when $y$ is a refinement of $x$, mirroring this way of thinking about possibilities.] But if we think of possibilities as stories, the notation becomes more intuitive. We have $x \leqslant y$ when $y$ is created by adding new content to $x$. Keeping with this theme, I'll typically model stories not as worlds, but as finite sequences. (In the main example in @sec-proof, they will be sequences of 0s and 1s.) In these models, $x \leqslant y$ means that $x$ is an initial segment of $y$.
