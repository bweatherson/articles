bigger_scoreboard <- tribble(
  ~urn, ~c7f, ~c8f, ~c9f, ~c10f
)

for (the_target in (75:99)/100){
  
main_scoreboard <- main_scoreboard |>
  mutate(target = (reality >= the_target))


summary_scoreboard_c7 <- main_scoreboard |>
  group_by(target, c7) |>
  tally(name = "trials") 

workout_thresh_c7 <- summary_scoreboard_c7 |>
  pivot_wider(id_cols = c7,
              names_from = target,
              values_from = trials) |>
  replace_na(
    list(
      `FALSE` = 0,
      `TRUE` = 0
    )
  ) |>
  mutate(target_comp = `TRUE` - `FALSE`)

c7_thresh <- min(
  (
    workout_thresh_c7 |>
      filter(target_comp > 0)
  )$c7
)

failures_c7 <- sum(
  (
    summary_scoreboard_c7 |>
      filter(
        target == FALSE & c7 >= c7_thresh |
          target == TRUE & c7 < c7_thresh)
  )$trials
)

summary_scoreboard_c8 <- main_scoreboard |>
  group_by(target, c8) |>
  tally(name = "trials") 

workout_thresh_c8 <- summary_scoreboard_c8 |>
  pivot_wider(id_cols = c8,
              names_from = target,
              values_from = trials) |>
  replace_na(
    list(
      `FALSE` = 0,
      `TRUE` = 0
    )
  ) |>
  mutate(target_comp = `TRUE` - `FALSE`)

c8_thresh <- min(
  (
    workout_thresh_c8 |>
      filter(target_comp > 0)
  )$c8
)

failures_c8 <- sum(
  (
    summary_scoreboard_c8 |>
      filter(
        target == FALSE & c8 >= c8_thresh |
          target == TRUE & c8 < c8_thresh)
  )$trials
)

summary_scoreboard_c9 <- main_scoreboard |>
  group_by(target, c9) |>
  tally(name = "trials") 

workout_thresh_c9 <- summary_scoreboard_c9 |>
  pivot_wider(id_cols = c9,
              names_from = target,
              values_from = trials) |>
  replace_na(
    list(
      `FALSE` = 0,
      `TRUE` = 0
    )
  ) |>
  mutate(target_comp = `TRUE` - `FALSE`)

c9_thresh <- min(
  (
    workout_thresh_c9 |>
      filter(target_comp > 0)
  )$c9
)

failures_c9 <- sum(
  (
    summary_scoreboard_c9 |>
      filter(
        target == FALSE & c9 >= c9_thresh |
          target == TRUE & c9 < c9_thresh)
  )$trials
)

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

bigger_scoreboard <- bigger_scoreboard |>
  add_row(
    urn = the_target,
    c7f = failures_c7,
    c8f = failures_c8,
    c9f = failures_c9,
    c10f = failures_c10
  )
}