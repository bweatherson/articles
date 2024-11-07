cites_in_ps <- active_cites |>
  filter(new_journal == "Philosophical Studies",
         new_year >= 1980) |>
  group_by(old) |>
  tally(name = "ps_cites") |>
  right_join(short_bib, by = c("old" = "id")) |>
  rename(id = old) |>
  replace_na(list(ps_cites = 0)) |>
  arrange(-cites) |>
  mutate(proportion = ps_cites/cites) |>
  select(ps_cites, cites, proportion, displayauth, year, title, journal, everything()) |>
  filter(cites > 50) |>
  arrange(-proportion)