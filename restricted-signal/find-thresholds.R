summary_scoreboard_c10 <- main_scoreboard |>
  group_by(target, c10) |>
  tally(name = "trials") 

workout_thresh_c10 <- summary_scoreboard_c10 |>
  pivot_wider(id_cols = c10,
              names_from = target,
              values_from = trials) |>
  replace_na(
    list(
      `FALSE` = 0,
      `TRUE` = 0
    )
  ) |>
  mutate(target_comp = `TRUE` - `FALSE`)

c10_thresh <- min(
  (
    workout_thresh_c10 |>
      filter(target_comp > 0)
  )$c10
)

failures_c10 <- sum(
  (
    summary_scoreboard_c10 |>
      filter(
        target == FALSE & c10 >= c10_thresh |
          target == TRUE & c10 < c10_thresh)
  )$trials
)