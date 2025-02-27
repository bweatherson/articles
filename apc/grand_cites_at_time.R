# Grand cites at a time

overall_grand_cites <- c()

for (end_year in (199:202)*10){
  temp_citation_count <- citation_tibble |>
    filter(new_year <= end_year,
           old_year >= end_year - 20) |>
    group_by(old) |>
    tally(name = "citations")
  
  temp_grand_cites <- citation_tibble |>
    filter(new_year <= end_year,
           old_year >= end_year - 20) |>
    left_join(temp_citation_count,
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
  
  temp_grand_cites_summary <- temp_grand_cites |>
    slice(1:10) |>
    left_join(
      temp_citation_count,
      by = "old"
    ) |>
    mutate(
      Article = paste0(
        displayauth,
        " -@",
        str_replace_all(old, ":",""),
        " \"",
        title,
        "\""
      )
    ) |>
    mutate(rank = row_number(),
           as_of = end_year) |>
    select(
      `As Of` = as_of,
      Rank = rank,
      Article,
      Citations = citations,
      `Grand-Citations` = grand_cites
    )
  
  overall_grand_cites <- overall_grand_cites |>
    bind_rows(temp_grand_cites_summary)
}