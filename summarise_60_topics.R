# Code for building summary of the 60 topics
# It would be cleaner to loop this, but I can't figure out how

alltopics_summary <- c()

load("phil-studies/topic-ldas/Epistemology.RData")

currenttopic_topics <- tidy(epistemology_lda, matrix = "gamma")
currenttopic_high <- currenttopic_topics |>
  filter(gamma > 1/3) |>
  left_join(ps_join, by = c("document" = "jstor_id")) |>
  rename(id = wos_id) |>
  select(-document) |>
  left_join(short_bib, by = "id") |>
  right_join(active_cites, 
             by = c("id" = "old"),
             multiple = "all",
             relationship = "many-to-many") |>
  filter(!is.na(year))

currenttopic_high_cites_summary <- currenttopic_high |>
  group_by(topic, citing_journal) |>
  tally() |>
  pivot_wider(
    id_cols = topic,
    names_from = citing_journal,
    values_from = n
  ) |>
  mutate(proportion = PS / (PS + NPS))

currenttopic_all <- currenttopic_topics |>
  left_join(ps_join, by = c("document" = "jstor_id")) |>
  rename(id = wos_id) |>
  select(-document) |>
  left_join(short_bib, by = "id") 

currenttopic_date <- currenttopic_all |>
  group_by(topic) |>
  summarise(avg_year = weighted.mean(year, gamma))

currenttopic_count <- currenttopic_topics |>
  group_by(topic) |>
  summarise(articles = sum(gamma)) |>
  mutate(articles = round(articles, 1))

currenttopic_summary <- currenttopic_high_cites_summary |>
  rename(ps_cites = PS, nps_cites = NPS) |>
  mutate(all_cites = ps_cites + nps_cites) |>
  left_join(currenttopic_count, by = "topic") |>
  left_join(currenttopic_date, by = "topic") |>
  mutate(field = "Epistemology") |>
  select(field, topic_number = topic, articles, avg_year, ps_cites, all_cites, proportion)

alltopics_summary <- bind_rows(alltopics_summary, currenttopic_summary)

load("phil-studies/topic-ldas/Ethics.RData")

currenttopic_topics <- tidy(ethics_lda, matrix = "gamma")
currenttopic_high <- currenttopic_topics |>
  filter(gamma > 1/3) |>
  left_join(ps_join, by = c("document" = "jstor_id")) |>
  rename(id = wos_id) |>
  select(-document) |>
  left_join(short_bib, by = "id") |>
  right_join(active_cites, 
             by = c("id" = "old"),
             multiple = "all",
             relationship = "many-to-many") |>
  filter(!is.na(year))

currenttopic_high_cites_summary <- currenttopic_high |>
  group_by(topic, citing_journal) |>
  tally() |>
  pivot_wider(
    id_cols = topic,
    names_from = citing_journal,
    values_from = n
  ) |>
  mutate(proportion = PS / (PS + NPS))

currenttopic_all <- currenttopic_topics |>
  left_join(ps_join, by = c("document" = "jstor_id")) |>
  rename(id = wos_id) |>
  select(-document) |>
  left_join(short_bib, by = "id") 

currenttopic_date <- currenttopic_all |>
  group_by(topic) |>
  summarise(avg_year = weighted.mean(year, gamma))

currenttopic_count <- currenttopic_topics |>
  group_by(topic) |>
  summarise(articles = sum(gamma)) |>
  mutate(articles = round(articles, 1))

currenttopic_summary <- currenttopic_high_cites_summary |>
  rename(ps_cites = PS, nps_cites = NPS) |>
  mutate(all_cites = ps_cites + nps_cites) |>
  left_join(currenttopic_count, by = "topic") |>
  left_join(currenttopic_date, by = "topic") |>
  mutate(field = "Ethics") |>
  select(field, topic_number = topic, articles, avg_year, ps_cites, all_cites, proportion)

alltopics_summary <- bind_rows(alltopics_summary, currenttopic_summary)

load("phil-studies/topic-ldas/Language.RData")

currenttopic_topics <- tidy(language_lda, matrix = "gamma")
currenttopic_high <- currenttopic_topics |>
  filter(gamma > 1/3) |>
  left_join(ps_join, by = c("document" = "jstor_id")) |>
  rename(id = wos_id) |>
  select(-document) |>
  left_join(short_bib, by = "id") |>
  right_join(active_cites, 
             by = c("id" = "old"),
             multiple = "all",
             relationship = "many-to-many") |>
  filter(!is.na(year))

currenttopic_high_cites_summary <- currenttopic_high |>
  group_by(topic, citing_journal) |>
  tally() |>
  pivot_wider(
    id_cols = topic,
    names_from = citing_journal,
    values_from = n
  ) |>
  mutate(proportion = PS / (PS + NPS))

currenttopic_all <- currenttopic_topics |>
  left_join(ps_join, by = c("document" = "jstor_id")) |>
  rename(id = wos_id) |>
  select(-document) |>
  left_join(short_bib, by = "id") 

currenttopic_date <- currenttopic_all |>
  group_by(topic) |>
  summarise(avg_year = weighted.mean(year, gamma))

currenttopic_count <- currenttopic_topics |>
  group_by(topic) |>
  summarise(articles = sum(gamma)) |>
  mutate(articles = round(articles, 1))

currenttopic_summary <- currenttopic_high_cites_summary |>
  rename(ps_cites = PS, nps_cites = NPS) |>
  mutate(all_cites = ps_cites + nps_cites) |>
  left_join(currenttopic_count, by = "topic") |>
  left_join(currenttopic_date, by = "topic") |>
  mutate(field = "Language") |>
  select(field, topic_number = topic, articles, avg_year, ps_cites, all_cites, proportion)

alltopics_summary <- bind_rows(alltopics_summary, currenttopic_summary)

load("phil-studies/topic-ldas/Metaphysics.RData")

currenttopic_topics <- tidy(metaphysics_lda, matrix = "gamma")
currenttopic_high <- currenttopic_topics |>
  filter(gamma > 1/3) |>
  left_join(ps_join, by = c("document" = "jstor_id")) |>
  rename(id = wos_id) |>
  select(-document) |>
  left_join(short_bib, by = "id") |>
  right_join(active_cites, 
             by = c("id" = "old"),
             multiple = "all",
             relationship = "many-to-many") |>
  filter(!is.na(year))

currenttopic_high_cites_summary <- currenttopic_high |>
  group_by(topic, citing_journal) |>
  tally() |>
  pivot_wider(
    id_cols = topic,
    names_from = citing_journal,
    values_from = n
  ) |>
  mutate(proportion = PS / (PS + NPS))

currenttopic_all <- currenttopic_topics |>
  left_join(ps_join, by = c("document" = "jstor_id")) |>
  rename(id = wos_id) |>
  select(-document) |>
  left_join(short_bib, by = "id") 

currenttopic_date <- currenttopic_all |>
  group_by(topic) |>
  summarise(avg_year = weighted.mean(year, gamma))

currenttopic_count <- currenttopic_topics |>
  group_by(topic) |>
  summarise(articles = sum(gamma)) |>
  mutate(articles = round(articles, 1))

currenttopic_summary <- currenttopic_high_cites_summary |>
  rename(ps_cites = PS, nps_cites = NPS) |>
  mutate(all_cites = ps_cites + nps_cites) |>
  left_join(currenttopic_count, by = "topic") |>
  left_join(currenttopic_date, by = "topic") |>
  mutate(field = "Metaphysics") |>
  select(field, topic_number = topic, articles, avg_year, ps_cites, all_cites, proportion)

alltopics_summary <- bind_rows(alltopics_summary, currenttopic_summary)

load("phil-studies/topic-ldas/Mind.RData")

currenttopic_topics <- tidy(mind_lda, matrix = "gamma")
currenttopic_high <- currenttopic_topics |>
  filter(gamma > 1/3) |>
  left_join(ps_join, by = c("document" = "jstor_id")) |>
  rename(id = wos_id) |>
  select(-document) |>
  left_join(short_bib, by = "id") |>
  right_join(active_cites, 
             by = c("id" = "old"),
             multiple = "all",
             relationship = "many-to-many") |>
  filter(!is.na(year))

currenttopic_high_cites_summary <- currenttopic_high |>
  group_by(topic, citing_journal) |>
  tally() |>
  pivot_wider(
    id_cols = topic,
    names_from = citing_journal,
    values_from = n
  ) |>
  mutate(proportion = PS / (PS + NPS))

currenttopic_all <- currenttopic_topics |>
  left_join(ps_join, by = c("document" = "jstor_id")) |>
  rename(id = wos_id) |>
  select(-document) |>
  left_join(short_bib, by = "id") 

currenttopic_date <- currenttopic_all |>
  group_by(topic) |>
  summarise(avg_year = weighted.mean(year, gamma))

currenttopic_count <- currenttopic_topics |>
  group_by(topic) |>
  summarise(articles = sum(gamma)) |>
  mutate(articles = round(articles, 1))

currenttopic_summary <- currenttopic_high_cites_summary |>
  rename(ps_cites = PS, nps_cites = NPS) |>
  mutate(all_cites = ps_cites + nps_cites) |>
  left_join(currenttopic_count, by = "topic") |>
  left_join(currenttopic_date, by = "topic") |>
  mutate(field = "Mind") |>
  select(field, topic_number = topic, articles, avg_year, ps_cites, all_cites, proportion)

alltopics_summary <- bind_rows(alltopics_summary, currenttopic_summary) |>
  mutate(citation_rate = round(all_cites/articles, 2))

save(alltopics_summary, file = "alltopics_summary.RData")

