require(tidyverse)
require(topicmodels)

meta_topics <- tidy(meta_lda, matrix = "gamma")
meta_high <- meta_topics |>
  filter(gamma > 1/3) |>
  left_join(ps_join, by = c("document" = "jstor_id")) |>
  rename(id = wos_id) |>
  select(-document) |>
  left_join(short_bib, by = "id") |>
  filter(!is.na(year)) |>
  left_join(active_cites, 
             by = c("id" = "old"),
             multiple = "all",
             relationship = "many-to-many")

meta_high_cites_summary <- meta_high |>
  group_by(topic, citing_journal) |>
  tally() |>
  pivot_wider(
    id_cols = topic,
    names_from = citing_journal,
    values_from = n
  ) |>
  mutate(proportion = PS / (PS + NPS))