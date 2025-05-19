yearly_grand_cites <- function(the_year){
  temp_citation_count <- citation_tibble |>
    filter(new_year == the_year) |>
    group_by(old) |>
    tally(name = "citations")
  temp <- citation_tibble |>
#      filter(new_year == the_year,
#             old_year >= end_year - 100) |>
      left_join(temp_citation_count,
                by = c("new" = "old")) |>
      replace_na(replace = list(citations = 0)) |>
      group_by(old) |>
      summarise(grand_cites = sum(citations)) |>
      # left_join(
      #   select(
      #     active_philo_bib,
      #     old = id,
      #     displayauth,
      #     year,
      #     title
      #   ), by = "old"
      # ) |>
      slice_max(order_by = grand_cites, n = 100) |>
      mutate(measure_year = the_year) |>
      mutate(ranking = min_rank(-grand_cites))
  temp
}

overall_grand_cites <- c() 

for (the_year in 1990:2024){
  overall_grand_cites <- bind_rows(
    overall_grand_cites, yearly_grand_cites(the_year)
  )  
}

grand_cite_ranking <- overall_grand_cites |>
  select(-grand_cites) |>
  pivot_wider(
    id_cols = old,
    values_from = ranking,
    names_from = measure_year
  ) |>
  left_join(
    select(
      active_philo_bib,
      old = id,
      displayauth,
      year,
      title
    ), by = "old"
  ) |>
  select(id = old, displayauth, year, title, everything())