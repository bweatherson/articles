require(tidyverse)

phil_studies_words <- read_csv("/Users/weath/Documents/lda-cites-unigrams-only/PS-unigrams.csv") |>
  mutate(jstor_id = paste0(
    "PS-",
    str_sub(id, start = 29)
  )) |>
  mutate(word = str_replace_all(ngram,"[^A-Za-z]","")) |>
  mutate(word = str_to_lower(word)) |>
  group_by(jstor_id, word) |>
  summarise(count = sum(count), .groups = "drop") |>
  filter(word != "")

save(phil_studies_words, file = "phil_studies_words.RData")

#load("phil_studies_words.RData")
load("/Users/weath/Documents/articles/phil-studies/ps_join.RData")
load("/Users/weath/Documents/articles/phil-studies/ps_meta.RData")

phil_studies_word_count <- phil_studies_words |>
  group_by(jstor_id) |>
  summarise(wordcount = sum(count))


ps_words_and_year <- phil_studies_words |>
  filter(jstor_id %in% ps_join$jstor_id) |>
  left_join(
    select(
      ps_meta,
      jstor_id,
      year),
    by = "jstor_id") |>
  filter(!is.na(year))

ps_how_many_words_each_year <- ps_words_and_year  |>
  group_by(year) |>
  summarise(all_words = sum(count))
            

ps_articles_by_year <- ps_words_and_year |>
  group_by(year) |>
  summarise(articles = n_distinct(jstor_id))

ps_words_by_year <- ps_words_and_year |>
  group_by(word, year) |>
  summarise(count = sum(count), .groups = "drop") |>
  ungroup() |>
  left_join(ps_articles_by_year, by = "year") |>
  left_join(
    ps_words_and_year |>
      group_by(word, year) |>
      summarise(uses = n_distinct(jstor_id), .groups = "drop"),
    by = c("word", "year")) |>
  replace_na(replace = list(uses = 0)) |>
  mutate(use_rate = uses/articles) |>
  left_join(
    ps_words_and_year |>
      filter(count >= 10) |>
      group_by(word, year) |>
      summarise(topic = n_distinct(jstor_id), .groups = "drop"),
    by = c("word", "year")) |>
  replace_na(replace = list(topic = 0)) |>
  mutate(topic_rate = topic / articles)
  
common_ps_words <- ps_words_and_year |>
  group_by(word) |>
  summarise(all_count = sum(count)) |>
  arrange(-all_count) |>
  filter(all_count >= 100) |>
  left_join(ps_words_by_year, by = "word") |>
  complete(nesting(word,all_count),
           nesting(year, articles),
           fill = list(
             count = 0,
             uses = 0,
             use_rate = 0,
             topic = 0,
             topic_rate = 0)) |>
  left_join(ps_how_many_words_each_year, by = "year") |>
  mutate(word_rate = 1000 * count / all_count) |>
  group_by(word) |>
  mutate(avg_topic = mean(topic_rate),
         sd_topic = sd(topic_rate),
         z_topic = topic_rate * (topic_rate - avg_topic)/sd_topic) |>
  ungroup() |>
  arrange(-z_topic)

words_by_decade <- common_ps_words |>
  mutate(decade = paste0(
    floor(year/10),
    "0s")) |>
  group_by(word, decade) |>
  summarise(
    z = mean(topic_rate) * (mean(topic_rate) - mean(avg_topic))/mean(sd_topic),
    use_rate = mean(use_rate),
    word_rate = mean(word_rate),
    topic_rate = mean(topic_rate),
    count = sum(count),
    .groups = "drop") |>
  arrange(-z)

topic_rate <- words_by_decade |>
  pivot_wider(
    id_cols = "word",
    names_from = "decade",
    values_from = "topic_rate"
  ) |>
  mutate(surplus = 2*`1990s` - `1980s` - `2000s`) |>
  filter(`1990s` > `1980s`,
         `1990s` > `2000s`) |>
  arrange(-surplus)
 
# Words for 1990s
# Lots of language related words: meaning, language, beliefs, sentences

temp <- common_ps_words |>
  filter(word == "exist")
  
      
