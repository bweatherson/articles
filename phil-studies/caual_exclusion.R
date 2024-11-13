require(tidyverse)
causal_exclusion <- ps_uni_grouped |>
  filter(ngram %in% c(
    "causal",
    "exclusion",
    "mental",
    "kim")) |>
  select(ngram, count, wos_id, year, displayauth, title) |>
  pivot_wider(names_from = ngram,
              values_from = count) |>
  replace_na(list(
    causal = 0,
    exclusion = 0,
    mental = 0,
    kim = 0)
    )|>
  mutate(score = causal * exclusion * mental * kim) |>
  arrange(-score) |>
  mutate(score2 = 
           (kim >= 10) +
           (kim >= 1) +
           (exclusion >= 10) +
           (exclusion >= 1) +
           (causal >= 10) +
           (causal >= 1) +
           (mental >= 10) +
           (mental >= 1)
  ) |>
  arrange(-score2, -score)

causal_exclusion_refined <- causal_exclusion |>
  filter(score2 >= 3,
         year >= 1990,
         year <= 1999)

causal_exclusion_cites <- active_cites |>
  filter(old %in% causal_exclusion_refined$wos_id) |>
  group_by(old, citing_journal) |>
  tally() |>
  pivot_wider(names_from = citing_journal,
              values_from = n) |>
  replace_na(list(
                PS = 0, NPS = 0))

sum(causal_exclusion_cites$PS)/ (sum(causal_exclusion_cites$PS) + sum(causal_exclusion_cites$NPS))

mean(causal_exclusion_cites$NPS)