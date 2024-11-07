require(tidyverse)
require(topicmodels)

ethics_topics <- tidy(ethics_lda, matrix = "gamma")
ethics_high <- ethics_topics |>
  filter(gamma > 1/3) |>
  left_join(ps_join, by = c("document" = "jstor_id")) |>
  rename(id = wos_id) |>
  select(-document) |>
  left_join(short_bib, by = "id") |>
  right_join(active_cites, 
            by = c("id" = "old"),
            multiple = "all",
            relationship = "many-to-many") |>
  filter(!is.na(year))

ethics_high_cites_summary <- ethics_high |>
  group_by(topic, citing_journal) |>
  tally() |>
  pivot_wider(
    id_cols = topic,
    names_from = citing_journal,
    values_from = n
  ) |>
  mutate(proportion = PS / (PS + NPS))

ethics_all <- ethics_topics |>
  left_join(ps_join, by = c("document" = "jstor_id")) |>
  rename(id = wos_id) |>
  select(-document) |>
  left_join(short_bib, by = "id") 

ethics_date <- ethics_all |>
  group_by(topic) |>
  summarise(avg_year = weighted.mean(year, gamma))