# Top of the 80s

top_80s <- tibble(
  as_of = NA,
  rank = NA,
  old = NA
)

for (nn in 1990:2005){
  temp <- citation_tibble |>
    filter(old_year >= 1985,
           old_year <= 1994,
           new_year <= nn) |>
    group_by(old, old_year) |>
    tally(name = "citations") |>
    ungroup() |>
    arrange(-citations, old_year) |>
    slice(1:10) |>
    mutate(rank = row_number(),
           as_of = nn) |>
    select(as_of, rank, old)

  top_80s <- top_80s |>
    bind_rows(temp)
}

top_80s <- top_80s |>
  slice(-1) |>
  left_join(
    select(
      philo_bib,
      old = id,
      displayauth,
      year,
      title
    ), by = "old"
  )

citation_count <- citation_tibble |>
  filter(new_year <= 2021) |>
  group_by(old) |>
  tally(name = "citations")

grand_cites <- citation_tibble |>
  filter(new_year <= 2021) |>
  left_join(citation_count,
            by = c("new" = "old")) |>
  replace_na(replace = list(citations = 0)) |>
  group_by(old) |>
  summarise(grand_cites = sum(citations)) |>
  left_join(
    select(
      philo_bib,
      old = id,
      displayauth,
      year,
      title
    ), by = "old"
  ) |>
  arrange(-grand_cites)
