temp <- citation_tibble |>
  filter(old_year <= 1973, old_year >= 1969) |>
  mutate(cite_when = case_when(
    new_year <= 1980 ~ "early",
    TRUE ~ "late"
  )) |>
  group_by(old, cite_when) |>
  tally(name = "citations") |>
  pivot_wider(id_cols = "old",
              names_from = "cite_when",
              values_from = "citations") |>
  slice_max(order_by = late, n = 100) |>
  left_join(
    select(
      philo_bib,
      old = id,
      displayauth,
      year,
      title
    ), by = "old"
  ) |>
  filter(late >= 100 & early <= 10) |>
  arrange(year) |>
  mutate(the_cite = paste0(
    "@",
    str_replace_all(old, ":","")
  )) |>
  arrange(-late)
