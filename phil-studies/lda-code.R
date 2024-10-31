phil_studies_gamma <- tidy(my_lda, matrix = "gamma") 

phil_studies_classifications <- phil_studies_gamma |>
  group_by(document) |>
  top_n(1, gamma) |>
  ungroup()

phil_studies_titles_and_topics <- left_join(phil_studies_classifications,
                                            ps_meta,
                                            by = c("document" = "id"))

phil_topics <- tidy(my_lda, matrix = "beta")

word_score <- phil_topics |>
  group_by(term) |>
  dplyr::summarise(avgbeta = mean(beta), sdbeta = sd(beta))

busy_topics <- phil_topics |>
  left_join(word_score, by = "term") |>
  right_join(common_ps_words, by = c("term" = "ngram")) |>
  mutate(score = (beta - avgbeta) * log(tn) / sdbeta)

distinctive_topics <- busy_topics %>%
  group_by(topic) %>%
  slice_max(n = 20, score) %>%
  ungroup() %>%
  arrange(desc(-topic))

distinctive_articles <- phil_studies_titles_and_topics |>
  ungroup() |>
  group_by(topic) |>
  slice_max(order_by = gamma, n = 15)

topics_tibble <- tribble(
  ~topic, ~Topic,
  1, "lda-Epistemology",
  2, "lda-Mind",
  3, "lda-Ethics",
  4, "lda-Language",
  5, "lda-Metaphysics"
)

#1 - Epistemology
#2 - Mind
#3 - Ethics
#4 - Language
#5 - Metaphysics

short_bib_with_gamma <- phil_studies_gamma |>
  left_join(topics_tibble, by = c("topic")) |>
  select(-topic) |>
  pivot_wider(id_cols = document,
              names_from = Topic,
              values_from = gamma) |>
  left_join(ps_join, by = c("document" = "jstor_id")) |>
  rename(id = wos_id) |>
  select(-document) |>
  left_join(short_bib, by = "id") |>
  filter(!is.na(year))

topic_rate_by_year <- short_bib_with_gamma |>
  group_by(year) |>
  summarise(across(starts_with("lda"), mean))

topic_count_by_year <- short_bib_with_gamma |>
  group_by(year) |>
  summarise(across(starts_with("lda"), sum))

names(topic_rate_by_year) <- sub("^lda-", "", names(topic_rate_by_year))
names(topic_count_by_year) <- sub("^lda-", "", names(topic_count_by_year))

short_bib_with_gamma <- short_bib_with_gamma |>
  ungroup() |>
  rowwise() |>
  mutate(max = max(c_across(1:5)))

unsorted_articles <- short_bib_with_gamma |>
  filter(max < 0.5) |>
  arrange(-cites)

topic_rate_by_issue <- short_bib_with_gamma |>
  group_by(volume, issue) |>
  summarise(across(starts_with("lda"), mean), .groups = "drop") |>
  rowwise() |>
  mutate(max = max(c_across(3:7))) |>
  left_join(issue_list |>
              mutate(volume = as.character(Volume),
                     issue = as.character(Issue)), 
            by = c("volume", "issue")) |>
  replace_na(list(Type = "Normal"))

topic_rate_by_type <- topic_rate_by_issue |>
  ungroup() |>
  mutate(Type = case_when(
    Type == "Conference" ~ "One-off",
    Type == "Topic" ~ "One-off",
    Type == "Bellingham" ~ "BSPC",
    TRUE ~ Type)) |>
  group_by(Type) |>
  summarise(across(starts_with("lda"), mean), .groups = "drop") %>%
  mutate(across(starts_with("lda"), \(x) paste0(round(x, 3) * 100,"%")))
  
names(topic_rate_by_type) <- sub("^lda-", "", names(topic_rate_by_type))
  
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