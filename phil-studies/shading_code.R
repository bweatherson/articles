
citations_by_topic <- short_bib_with_gamma |>
  select(id, cites, starts_with("lda")) |>
  pivot_longer(cols = starts_with("lda"),
               names_to = "topic",
               values_to = "probability") |>
  mutate(weighted_cites = cites * probability) |>
  mutate(topic = str_replace(topic, "lda-", "")) |>
  group_by(topic) |>
  summarise(cites = sum(weighted_cites), articles = sum(probability)) |>
  mutate(rate = cites/articles) |>
  mutate(Topic = topic,
         Articles = round(articles, 1),
         Citations = round(cites, 1),
         Rate = round(rate, 2)) |>
  select(Topic, Articles, Citations, Rate)

citations_by_topic_decade <- short_bib_with_gamma |>
  mutate(decade = paste0(
    floor(
      year/10
    ),
    "0s"
  )) |>
  select(id, decade, cites, starts_with("lda")) |>
  pivot_longer(cols = starts_with("lda"),
               names_to = "topic",
               values_to = "probability") |>
  mutate(weighted_cites = cites * probability) |>
  mutate(topic = str_replace(topic, "lda-", "")) |>
  group_by(topic, decade) |>
  summarise(cites = sum(weighted_cites), articles = sum(probability), .groups = "drop") |>
  mutate(rate = cites/articles) |>
  mutate(Topic = topic,
         Decade = decade,
         Articles = round(articles, 1),
         Citations = round(cites, 1),
         Rate = round(rate, 2)) |>
  select(Topic,Decade, Rate) |>
  pivot_wider(id_cols = Topic,
              names_from = Decade,
              values_from = Rate)

word_graphs(c("causal"), 1) + 
geom_rect(data = tibble(start = 1990, end = 1999), aes(xmin = start , xmax = end, ymin = -Inf, ymax = Inf),
          inherit.aes=FALSE, alpha = 0.5, fill = rgb(1,1,251/255))