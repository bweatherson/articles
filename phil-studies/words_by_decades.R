words_by_decades <- ps_uni_grouped |>
  mutate(decade = paste0(floor(year/10),"0s")) |>
  group_by(ngram, decade) |>
  summarise(count = sum(count), .groups = "drop") |>
  pivot_wider(id_cols = ngram,
              names_from = decade,
              names_prefix = "d",
              values_from = count) |>
  replace_na(
    list(
      d1980s = 0,
      d1990s = 0,
      d2000s = 0,
      d2010s = 0
    )
  )

all_word_count <- sum(ps_uni_grouped$count)
word_proportion_year <- function(x){
  sum(
    (
      word_count_by_year |> filter(year %in% x)
    )$wordcount
  )/ all_word_count
}
f1980s <- word_proportion_year(1980:1989)
f1990s <- word_proportion_year(1990:1999)
f2000s <- word_proportion_year(2000:2009)
f2010s <- word_proportion_year(2010:2019)

words_by_decades <- words_by_decades |>
  mutate(all_uses = d1980s + d1990s + d2000s + d2010s) |>
  mutate(c1980s = pbinom(all_uses - d1980s, size = all_uses, prob = 1-f1980s)) |>
  mutate(c1990s = pbinom(all_uses - d1990s, size = all_uses, prob = 1-f1990s)) |>
  mutate(c2000s = pbinom(all_uses - d2000s, size = all_uses, prob = 1-f2000s)) |>
  mutate(c2010s = pbinom(all_uses - d2010s, size = all_uses, prob = 1-f2010s))

words_overall <- words_with_cites |>
  left_join(words_by_decades, by = "ngram")