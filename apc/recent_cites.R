who_cites_more <- citation_tibble |>
  left_join(
    select(
      philo_bib,
      id,
      journal
    ), by = c("new" = "id")
  ) |>
  filter(new_year >= 2010, new_year <= 2021) |>
  mutate(period = case_when(
    new_year < 2020 ~ "2010-2019",
    TRUE ~ "2020-2022"
  )) |>
  group_by(journal, period) |>
  summarise(articles = n_distinct(new), citations = n(), .groups = "drop") |>
  mutate(name_len = str_length(journal)) |>
  mutate(mean_cites = citations/articles) |>
  pivot_wider(id_cols = c(journal, name_len), names_from = period, values_from = mean_cites) |>
  mutate(diff = `2020-202q` - `2010-2019`) |>
  arrange(-diff)

recent_pr <- philo_bib |>
  filter(year %in% 2020:2021,
         journal == "Philosophical Review")

recent_pr_cites <- citation_tibble |>
  filter(new %in% recent_pr$id) |>
  left_join(
    select(
      philo_bib,
      id,
      displayauth,
      year,
      title,
      journal
    ), by = c("old" = "id")
  ) |>
  left_join(
    select(
      philo_bib,
      new = id,
      new_auth = displayauth,
      new_title = title
    ), by = "new"
  ) |>
  ungroup() |>
  group_by(new) |>
  add_tally(name = "outbound_citations") |>
  arrange(-outbound_citations, new, year)