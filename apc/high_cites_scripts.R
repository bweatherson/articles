temp <- citation_tibble |>
  mutate(age = new_year - old_year) |>
  group_by(old) |>
  mutate(citations = n()) |>
  filter(citations >= 25,
         citations >= 10,
         old_year <= 1990) |>
  mutate(mean_age = round(
    mean(age),
    2
  )) |>
  left_join(
    select(
      philo_bib,
      old = id,
      displayauth,
      title,
      journal
    ),
    by = "old"
  ) |>
  arrange(mean_age)

what_about_1990 <- citation_tibble |>
  filter(old_year == 1990) |>
  mutate(age = new_year - old_year) |>
  group_by(old) |>
  mutate(citations = n()) |>
  filter(citations < 15) |>
  mutate(mean_age = round(
    mean(age),
    2
  )) |>
  left_join(
    select(
      philo_bib,
      old = id,
      displayauth,
      title,
      journal
    ),
    by = "old"
  ) |>
  filter(old_year == 1990,
         citations >= 6,
         mean_age <= 10) |>
  arrange(mean_age, journal) |>
  filter(
    journal %in% c(
      "Philosophy of Science",
      "British Journal for the Philosophy of Science",
      "Studies in History and Philosophy of Science",
      "Biology and Philosophy"
    )
  ) |>
  group_by(old) |>
  summarise(`Mean Citation Age` = max(mean_age)) |>
  mutate(Article = paste0(
    "@",
    str_replace_all(old, ":",""))) |>
  select(Article, `Mean Citation Age`)