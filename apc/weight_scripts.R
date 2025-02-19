# Scripts for Working out weights

# Start by loading age_effect_tibble, and removing years we're not interested in
# Also remove columns that aren't relevant for these purposes, and calculating the means

basic_weight <- age_effect_tibble |>
  select(old_year, new_year, articles, citations) |>
  mutate(base_cite = citations/articles) |>
  filter(new_year > old_year) |>
  filter(old_year >=1957)

# Now write a function that works out for each article its weight in each year after publication

fun_single_article_weight <- function(x){
  article_cites <- citation_tibble |>
    filter(old == x)
  
  article_year <- ifelse(
    nrow(article_cites > 0),
    article_cites$old_year[1],
    filter(philo_bib, id == x)$year[1]
  )
  
  article_cites_by_year <- article_cites |>
    group_by(old_year, new_year) |>
    tally(name = "yearly_citations") |>
    ungroup() |>
    right_join(basic_weight, by = c("old_year", "new_year")) |>
    replace_na(replace = list(yearly_citations = 0)) |>
    filter(old_year == article_year, new_year > old_year) |>
    arrange(new_year) |>
    mutate(weight = yearly_citations/base_cite,
           age = new_year - old_year)
  
  article_cites_by_year
}

fun_single_article_short <- function(x){
  mean(
    filter(
      fun_single_article_weight(x),
      age <= 7
    )$weight
  )
}

fun_single_article__long <- function(x){
  mean(
    filter(
      fun_single_article_weight(x),
      age > 7
    )$weight
  )
}

fun_single_article___all <- function(x){
  mean(
    filter(
      fun_single_article_weight(x),
      age > 0
    )$weight
  )
}
