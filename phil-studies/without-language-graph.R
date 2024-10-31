without_language <- topic_rate_by_year %>%
  mutate(across(
    (starts_with("E") | starts_with("M")),
  \(x)  (x/(1-`Language`)))) |>
  select(-Language) |>
  pivot_longer(
    cols = 2:5,
    names_to = "topic",
    values_to = "rate") |>
  ggplot(
  aes(x = year, y = rate)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  facet_wrap(~topic, nrow = 2) +
  scale_x_continuous(breaks = c(1990, 2010)) +
  scale_y_continuous(lim = c(0, 0.5), breaks = c(0.1, 0.2, 0.3, 0.4)) +
  labs(x = element_blank(),
       y = element_blank())