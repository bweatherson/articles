very_common_words <- ps_uni_grouped |>
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

words_with_cites <- ps_uni_grouped |>
  filter(ngram %in% very_common_words$ngram) |>
  left_join(citation_by_document, by = "jstor_id") |>
  replace_na(list(PS = 0, NPS = 0, all_cites = 0)) |>
  group_by(ngram) |>
  summarise(ps_cites = sum(PS), all_cites = sum(all_cites)) |>
  mutate(proportion = ps_cites/all_cites) |>
  arrange(proportion) |>
  left_join(very_common_words, by = "ngram")

all_word_count <- sum(ps_uni_grouped$count)
word_proportion_year <- function(x){
  sum(
    (
      word_count_by_year |> filter(year %in% x)
    )$wordcount
  )/ all_word_count
}
word_centrality <- function(w, y){
  use_in_range <- sum(
    (
      ps_uni_grouped |>
        filter(
          ngram == w,
          year %in% y
        )
    )$count
  )
  use_all <- sum(
    (
      ps_uni_grouped |>
        filter(
          ngram == w
        )
    )$count
  )
  range_freq <- word_proportion_year(y)
  pbinom(use_all - use_in_range, size = use_all, prob = 1-range_freq)
}



