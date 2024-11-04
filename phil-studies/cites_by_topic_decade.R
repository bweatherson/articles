in_period_cites <- all_cites |>
  filter(new_year >= 1980, new_year <= 2019)

ps_cite_prob = nrow(
  in_period_cites |> filter(new_journal == "Philosophical Studies")
) /nrow(in_period_cites)

in_period_ps_cites <- in_period_cites |>
  filter(new_journal == "Philosophical Studies") |>
  group_by(old) |>
  tally(name = "ps_cites")

short_bib_with_ps <- short_bib |>
  filter(cites > 0) |>
  left_join(in_period_ps_cites, by = c("id" = "old")) |>
  replace_na(list(ps_cites = 0)) |>
  mutate(binom = pbinom(ps_cites, cites, ps_cite_prob)) |>
  arrange(binom) |>
  mutate(nbinom = pbinom(cites-ps_cites, cites, 1-ps_cite_prob)) |>
  arrange(nbinom)

cites_by_topic <- 
  short_bib_with_gamma |>
  pivot_longer(starts_with("lda"),
               names_to = "topic",
               values_to = "gamma") |>
  filter(gamma > 0.5) |>
  mutate(topic = str_replace(topic, "lda-", "")) |>
  mutate(decade = paste0(
    floor(
      year/10
    ),
    "0s"
  ))

topic_list <- (cites_by_topic |> group_by(topic) |> tally())$topic
decade_list <- (cites_by_topic |> group_by(decade) |> tally())$decade

q3_topic_decade <- tribble(
  ~topic, ~decade, ~q3
)

for (the_topic in topic_list){
  for (the_decade in decade_list){
    temp_cite_list <- cites_by_topic |>
      filter(decade == the_decade, topic == the_topic)
    temp_q3 <- quantile(temp_cite_list$cites, 0.75)
    q3_topic_decade <- q3_topic_decade |>
      add_row(topic = the_topic,
              decade = the_decade,
              q3 = temp_q3)
  }
}

q3_topic_decade <- q3_topic_decade |>
  mutate(q3 = round(q3, 1)) |>
  pivot_wider(id_cols = topic,
              names_from = decade,
              values_from = q3)

mean_topic_decade <- tribble(
  ~topic, ~decade, ~mean
)

for (the_topic in topic_list){
  for (the_decade in decade_list){
    temp_cite_list <- cites_by_topic |>
      filter(decade == the_decade, topic == the_topic)
    temp_mean <- mean(temp_cite_list$cites)
    mean_topic_decade <- mean_topic_decade |>
      add_row(topic = the_topic,
              decade = the_decade,
              mean = temp_mean)
  }
}

mean_topic_decade <- mean_topic_decade |>
  mutate(mean = round(mean, 1)) |>
  pivot_wider(id_cols = topic,
              names_from = decade,
              values_from = mean)