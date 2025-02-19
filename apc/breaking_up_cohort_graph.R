require(slider)

articles_with_short_long_cites <- philo_bib |>
  select(old = id,
         year,
         displayauth,
         title) |>
  left_join(article_times_cited, by = "old") |>
  replace_na(replace = list(citations = 0))

base_rate <- typical_citation_rate_per_year |>
  select(new_year, mean_cites) |>
  filter(new_year >= 1960) |>
  arrange(new_year) |>
  mutate(nearterm = slide_dbl(mean_cites, sum, .after = 6)) |>
  mutate(longterm = slide_dbl(mean_cites, sum, .after = 100))

articles_with_short_long_cites <- articles_with_short_long_cites |>
  mutate(yplus1 = year + 1,
         yplus6 = year + 8) |>
  left_join(
    select(
      base_rate,
      yplus1 = new_year,
      short_norm = nearterm
    ), by = "yplus1"
  ) |>
  left_join(
    select(
      base_rate,
      yplus6 = new_year,
      long_norm = longterm
    ), by = "yplus6"
  )

short_long_cites <- citation_tibble |>
  mutate(age = new_year - old_year) |>
  mutate(cite_type = case_when(
    age >= 8 & age <= 300 ~ "long_cites",
    age >= 1 & age <= 7 ~ "short_cites",
    TRUE ~ "other")) |>
  group_by(old, cite_type) |>
  tally(name = "citations") |>
  ungroup() |>
  complete(old, cite_type, fill = list(citations = 0), explicit = FALSE) |>
  pivot_wider(id_cols = old, names_from = cite_type, values_from = citations)
    
articles_with_short_long_cites <- articles_with_short_long_cites |>
  filter(year <= 2010) |>
  left_join(
    select(
      short_long_cites,
      old,
      short_cites,
      long_cites,
      other_cites = other
    ), by = "old"
  ) |>
  mutate(short_rate = short_cites/short_norm, long_rate = long_cites/long_norm) |>
  arrange(-short_rate) |>
  replace_na(replace = list(short_rate = 0, long_rate = 0))

nrow(
  filter(
    articles_with_short_long_cites,
    long_rate >= 8 | short_rate >= 10
  )
)

busy_articles <-   filter(
  articles_with_short_long_cites,
  long_rate >= 6 | short_rate >= 8
)

busy_cites <- citation_tibble |>
  filter(old %in% busy_articles$old)

year_short_long <- articles_with_short_long_cites |>
  group_by(year) |>
  filter(short_rate >= 10) |>
  tally(name = "short_term_high") |>
  left_join(articles_with_short_long_cites |>
              group_by(year) |>
              filter(long_rate >= 8) |>
              tally(name = "long_term_high"),
            by = "year")



weighted_citation_tibble <- citation_tibble |>
  left_join(
    select(
      age_effect_tibble,
      old_year,
      new_year,
      citations,
      articles
    ),
    by = c("old_year", "new_year")
  ) |>
  mutate(weight = articles/citations) |>
  mutate(age = new_year - old_year) |>
  filter(age > 0, old_year <= 2010) |>
  mutate(cite_type = case_when(
    age >= 8 & age <= 300 ~ "long_weight",
    age >= 1 & age <= 7 ~ "short_weight",
    TRUE ~ "other")) |>
  group_by(old, cite_type) |>
  summarise(weight = sum(weight), .groups = "drop") |>
  complete(old, cite_type, fill = list(weight = 0), explicit = FALSE) |>
  pivot_wider(id_cols = old, names_from = cite_type, values_from = weight) |>
  mutate(all_weight = short_weight + long_weight) |>
  right_join(
    select(
      philo_bib,
      old = id,
      displayauth,
      year,
      title
    ), by = "old"
  ) |>
  filter(year <= 2010) |>
  replace_na(replace = list(short_weight = 0, long_weight = 0, all_weight = 0)) |>
  mutate(short_weight = round(short_weight / 7, 2)) |>
  mutate(long_weight = round(long_weight / (2014 - year), 2)) |>
  mutate(all_weight = round(all_weight / (2021 - year), 2))


short_weight_of_citings <- function(article_id){
  mean(
    filter(
      weighted_citation_tibble,
      old %in% filter(
        citation_tibble,
        old == article_id
      )$new
    )$short_weight
  )
}

all_weight_of_citings <- function(article_id){
  mean(
    filter(
      weighted_citation_tibble,
      old %in% filter(
        citation_tibble,
        old == article_id
      )$new
    )$all_weight
  )
}

long_weight_of_citings <- function(article_id){
  mean(
    filter(
      weighted_citation_tibble,
      old %in% filter(
        citation_tibble,
        old == article_id
      )$new
    )$long_weight
  )
}

most_cites_by_2010 <- citation_tibble |>
  filter(new_year <= 2010) |>
  group_by(old) |>
  tally(name = "citations") |>
  arrange(-citations) |>
  filter(citations >= 30) |>
  left_join(
    select(
      philo_bib,
      old = id,
      displayauth,
      year,
      title
    ), by = "old"
  ) |>
  rowwise() |>
  mutate(downstream_short = round(short_weight_of_citings(old), 2),
         downstream_long  = round(long_weight_of_citings(old), 2),
         downstream_all   = round(all_weight_of_citings(old), 2))|>
  mutate(prod = downstream_short * downstream_long,
         ratio = downstream_short/downstream_long)

