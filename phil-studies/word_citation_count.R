very_common_words <- ps_uni |>
  filter(count >= 5) |>
  group_by(ngram) |>
  tally(name = "articles") |>
  filter(articles >= 10)

citation_by_document <- active_cites |>
  filter(cited_journal == "PS") |>
  group_by(old, citing_journal) |>
  summarise(citations = n_distinct(new), .groups = "drop") |>
  pivot_wider(id_cols = old,
              names_from = citing_journal,
              values_from = citations) |>
  replace_na(list(PS = 0, NPS = 0)) |>
  mutate(all_cites = PS + NPS) |>
  left_join(ps_join, by = c("old" = "wos_id")) 

words_with_cites <- ps_uni |>
  filter(ngram %in% very_common_words$ngram) |>
  left_join(citation_by_document, by = "jstor_id") |>
  replace_na(list(PS = 0, NPS = 0, all_cites = 0)) |>
  group_by(ngram) |>
  summarise(ps_cites = sum(PS), all_cites = sum(all_cites)) |>
  mutate(proportion = ps_cites/all_cites) |>
  arrange(proportion)

temp <- words_with_cites |>
  filter(is.na(PS))