recent_high_cites <- active_philo_cite |>
  left_join(
    select(
      active_philo_bib,
      id,
      new_year = year
    ),
    by = "id"
  ) |>
  filter(new_year >= 2020, new_year <= 2024) |>
  group_by(refs) |>
  tally(name = "citations") |>
  rename(id = refs) |>
  left_join(active_philo_bib, by = "id") |>
  select(citations, displayauth, year, title, everything()) |>
  arrange(-citations)

record_for_year <- recent_high_cites |>
  filter(year >= 1965) |>
  group_by(year) |>
  slice_max(order_by = citations, n = 5, with_ties = FALSE) |>
  arrange(-year, -citations)