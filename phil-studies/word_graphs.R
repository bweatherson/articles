word_graphs <- function(x, y){
  active_docs <- ps_uni |>
    filter(ngram %in% x)
  
  active_docs |>
    group_by(year, ngram) |>
    summarise(#docs = n_distinct(wos_id), 
              words = sum(count),
              .groups = "drop") |>
    left_join(word_count_by_year, by = "year") |>
    mutate(proportion = words/wordcount) |>
    ggplot(aes(x = year, y = proportion)) +
    geom_point() +
    facet_wrap(vars(ngram), ncol = y) +
    scale_x_continuous(limits = c(1980, 2019),
                       breaks = c(1990, 2010),
                       minor_breaks = 396:404 * 5) +
    labs(x = element_blank(), y = element_blank())
    
}



word_graphs(c("utilitarian", "utilitarianism", "kantian", "utility"))

ps_to_ps <- ps_cites |>
  filter(id %in% short_bib_with_gamma$id)

word_graphs(c("slur", "slurs"), 2)
word_graphs(c("testimony", "trust", "friend", "blame"), 2)
word_graphs(c("reference", "description"), 2)
word_graphs(c("heim", "kratzer"), 2)
word_graphs(c("chomsky", "montague"), 2)

word_graphs(c("fictional", "work", "rigid", "fiction"), 2) # Nothing Here
word_graphs(c("thought", "word", "use", "water", "russell", "frege"), 2) # Maybe keep word, water
word_graphs(c("justified", "justification", "reasonable", "lehrer", "criterion", "coherence", "chisholm", "regress"), 2) # Definitely justified, maybe chisholm
word_graphs(c("hesperus", "phosphorus", "superman", "salmon", "braun", "cicero", "sentence"), 2) # Keep sentence
word_graphs(c("predicate", "function", "extension", "variables", "quantification", "definition", "definitions"), 2) #Nothing here
word_graphs(c("functionalism", "computer", "functional", "functionalist"), 2) # Keep ism, ist
word_graphs(c("set", "sets", "class", "classes"), 2) # Scale wrong, although set does fall
word_graphs(c("harm", "kill", "save", "prevent", "trolley", "five"), 2) # Nope, nothing
word_graphs(c("responsibility", "free", "responsible", "control", "ability", "agent", "freedom", "causal"), 2)
word_graphs(c("grounding", "grounds", "grounded"), 2) # keep 'ing'
word_graphs(c("attention", "schellenberg"), 2) # keep attention
word_graphs(c("normative", "reasons", "pragmatic", "friendship"), 2) # keep normative, reasons
word_graphs(c("world", "worlds", "modality", "necessity"), 2)
word_graphs(c("credence", "credences", "conditionalization", "coin"), 2) # keep coin, credence

most_used_words <- ps_uni |>
  ungroup() |>
  group_by(ngram) |>
  summarise(n = sum(count)) |>
  slice_max(n, n = 2000)

year_word_count <- ps_uni |>
  group_by(year) |>
  summarise(n = sum(count)) |>
  arrange(year) |>
  mutate(cs = cumsum(n))

use_count_early <- ps_uni |>
  filter(year <= 2009) |>
  ungroup() |>
  group_by(ngram) |>
  summarise(early_use = sum(count))

use_count_late <- ps_uni |>
  filter(year >= 2010) |>
  ungroup() |>
  group_by(ngram) |>
  summarise(late_use = sum(count))

use_count_all <- inner_join(
  use_count_late,
  use_count_early,
  by = "ngram") |>
  mutate(all_use = early_use + late_use) |>
  mutate(late_prob = pbinom(early_use, size = all_use, prob = 0.5097)) |>
  mutate(early_prob = pbinom(late_use, size = all_use, prob = 0.4903)) |>
  filter(all_use > 2000) |>
  arrange(early_prob)

# Things that fall after 2010 
# Demonstrative and Physical are big in 2000s, less so after
word_graphs(c("physical", "sentence", "meaning", "reference", "statement", "language"), 3)
word_graphs(c("believes", "water", "putnam", "davidson", "quine", "description", "obligation", "demonstrative", "functionalism"), 3)

# Just for amusement
word_graphs(c("his", "her"), 1)
word_graphs(c("he", "she"), 2)

# Things that rise after 2010
word_graphs(c("credence", "grounding", "metaphysical", "phenomenology", "disagreement", "fundamental", "coin", "attention"), 3)
word_graphs(c("epistemic", "evidence", "experience", "perceptual", "reasons", "normative"), 3)
