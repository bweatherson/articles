# Redoing main plots just looking at articles with >=15 citations

high_threshold <- 15

highly_cited <- citation_tibble |>
  group_by(old) |>
  tally(name = "citations") |>
  filter(citations >= high_threshold) |>
  rename(id = old)

highly_cited_per_year <- philo_bib |>
  filter(id %in% highly_cited$id) |>
  group_by(year) |>
  tally(name = "high_articles") 

articles_per_year <- articles_per_year |>
  filter(old_year >= 1956) |>
  left_join(highly_cited_per_year, by = c("old_year" = "year")) |>
  mutate(low_articles = articles - high_articles)

year_in_year_out <- citation_tibble |>
  filter(old_year >= 1956) |>
  group_by(old_year, new_year) |>
  tally(name = "citations") |> # Now add the 'missing' pairs
  ungroup() |>
  complete(old_year, new_year, fill = list(citations = 0)) |>
  left_join(citation_tibble |>
              group_by(old) |>
              filter(n() >= high_threshold) |>
              group_by(old_year, new_year) |>
              tally(name = "high_citations") |> # Now add the 'missing' pairs
              ungroup() |>
              complete(old_year, new_year, fill = list(high_citations = 0)),
            by = c("old_year", "new_year")) |>
  replace_na(list(high_citations = 0)) |>
  mutate(low_citations = citations - high_citations)

# Citations between years
ct_sum <- citation_tibble |>
  group_by(old_year, new_year) |>
  tally(name = "citations") |>
  ungroup() |>
  left_join(
    citation_tibble |>
      filter(old %in% highly_cited$id) |>
      group_by(old_year, new_year) |>
      tally(name = "high_citations") |>
      ungroup(),
    by = c("old_year", "new_year")
  ) |>
  replace_na(list(high_citations = 0)) |>
  mutate(low_citations = citations - high_citations)


# All citations to typical articles in a year
ct_all <- citation_tibble |>
  filter(new_year >= old_year + typical_low, new_year <= old_year + typical_high) |>
  group_by(new_year) |>
  tally(name = "typical_citations")

age_effect_tibble <- year_in_year_out |>
  filter(old_year >= start_year, old_year <= end_year + 1 - min_data, new_year >= start_year + typical_high) |>
  filter(new_year >= old_year) |>
  left_join(
    select(
      articles_per_year, 
      old_year, 
      articles,
      high_articles,
      low_articles), 
    by = "old_year") |>
  left_join(
    select(
      articles_per_year, 
      old_year, 
      typical_articles), 
    by = c("new_year" = "old_year")) |>
  left_join(ct_all, by = "new_year") |> 
  mutate(age = new_year - old_year) |>
  mutate(cite_ratio = (citations/articles)/(typical_citations/typical_articles)) |>
  mutate(high_cite_ratio = (high_citations/high_articles)/(typical_citations/typical_articles))  |>
  mutate(low_cite_ratio = (low_citations/low_articles)/(typical_citations/typical_articles)) 


age_effect_grouped <- age_effect_tibble |>
  filter(new_year >= old_year) |>
  filter(new_year <= old_year + end_year - start_year + 1 - min_data) |>
  mutate(age = new_year - old_year) |>
  group_by(age) |>
  summarise(mean_effect = mean(cite_ratio),
            high_mean_effect = mean(high_cite_ratio),
            low_mean_effect = mean(low_cite_ratio))

age_effect_tibble_adj <- age_effect_tibble |>
  mutate(age = new_year - old_year) |>
  filter(age <= end_year - start_year - min_data) |>
  left_join(age_effect_grouped, by = "age")

age_effect_grouped_plot <- age_effect_grouped |>
  ggplot(aes(x = age, y = mean_effect)) +
  geom_point() +
  xlab("Article age") +
  ylab("Mean citation ratio")

age_effect_everything_plot <- age_effect_tibble_adj |>
  filter(old_year >= 1975, old_year != 1973) |>
  ggplot(aes(x = age, y = cite_ratio, color = as.factor(old_year))) +
  geom_jitter(size = 0.5, alpha = 0.7) +
  # geom_jitter(aes(size=(old_year==2008 | old_year == 1985), shape = (old_year==2008)), alpha = 1) +
  #  geom_jitter(aes(size=(old_year %in% c(1978, 1980, 1985, 1987)), alpha = 1)) +
  # scale_size_manual(values=c(0.3,2)) +
  xlab("Age of cited articles") +
  ylab("Citation ratio") +
  geom_line(aes(x = age, y = mean_effect), color = point_col) +
  geom_point(aes(x = age, y = mean_effect), color = point_col, size = 0.4) +
  theme(legend.position = "none")

age_effect_everything_plot_high <- age_effect_tibble_adj |>
  filter(old_year >= 1975, old_year != 1973) |>
  ggplot(aes(x = age, y = high_cite_ratio, color = as.factor(old_year))) +
  geom_jitter(size = 0.5, alpha = 0.7) +
  # geom_jitter(aes(size=(old_year==2008 | old_year == 1985), shape = (old_year==2008)), alpha = 1) +
  #  geom_jitter(aes(size=(old_year %in% c(1978, 1980, 1985, 1987)), alpha = 1)) +
  # scale_size_manual(values=c(0.3,2)) +
  xlab("Age of cited articles") +
  ylab("Citation ratio") +
  geom_line(aes(x = age, y = high_mean_effect), color = point_col) +
  geom_point(aes(x = age, y = high_mean_effect), color = point_col, size = 0.4) +
  theme(legend.position = "none")

age_effect_everything_plot_low <- age_effect_tibble_adj |>
  filter(old_year >= 1975, old_year != 1973) |>
  ggplot(aes(x = age, y = low_cite_ratio, color = as.factor(old_year))) +
  geom_jitter(size = 0.5, alpha = 0.7) +
  # geom_jitter(aes(size=(old_year==2008 | old_year == 1985), shape = (old_year==2008)), alpha = 1) +
  #  geom_jitter(aes(size=(old_year %in% c(1978, 1980, 1985, 1987)), alpha = 1)) +
  # scale_size_manual(values=c(0.3,2)) +
  xlab("Age of cited articles") +
  ylab("Citation ratio") +
  geom_line(aes(x = age, y = low_mean_effect), color = point_col) +
  geom_point(aes(x = age, y = low_mean_effect), color = point_col, size = 0.4) +
  theme(legend.position = "none")


year_by_year_with_effect <- year_in_year_out |>
  filter(new_year >= old_year) |>
  filter(new_year <= end_year) |>
  filter(old_year >= start_year, old_year <= end_year - min_data + 1, new_year >= start_year + typical_high) |>
  mutate(age = new_year - old_year) |>
  filter(age <= end_year - start_year - min_data) |>
  left_join(age_effect_grouped, by = "age") |>
  left_join(
    select(
      age_effect_tibble, old_year, new_year, cite_ratio
    ), by = c("old_year", "new_year")
  ) |>
  mutate(surplus = cite_ratio - mean_effect) |>
  arrange(-surplus)

# The next one calculates the difference between each year and the average. 
# But this has odd effects at the periphery, and compares each year to something it is part of.
# Below, in yiyo_extended, I try to work out what happens when each year is compared to the other years
# This is more work because you have to calculate the 'other years' value again each time

year_by_year_average <- year_by_year_with_effect |>
  group_by(old_year) |>
  summarise(mean_surplus = mean(surplus))

year_by_year_average_plot <- year_by_year_average |>
  ggplot(aes(x = old_year, y = mean_surplus)) +
  geom_point()  +
  geom_smooth() +
  xlab(element_blank()) +
  ylab("Mean annual citations above average") +
  scale_y_continuous(labels = scales::percent)

# year_by_year_average_plot + geom_smooth()

effect_by_age_average <- function(early, late){
  age_effect_tibble |>
    filter(age >= early, age <= late) |>
    #    add_count(old_year, name = "data_points") |>
    #    filter(data_points >= min_data) |>
    group_by(old_year) |>
    summarise(mean_ratio = mean(cite_ratio)) |>
    ggplot(aes(x = old_year, y = mean_ratio)) +
    geom_point() +
    geom_smooth() +
    xlab(element_blank()) +
    ylab(element_blank()) +
    labs(title = case_when(
      early == late ~ paste0("Citation ratio at age ", early),
      TRUE ~ paste0("Mean citation ratio from ages ",early," to ",late)))
}

effect_by_age_facet <- function(early, late){age_effect_tibble |>
    filter(age>= early, age <= late) |>
    ggplot(aes(x = old_year, y = cite_ratio)) +
    geom_point() + geom_smooth() +
    facet_wrap(~age, ncol = 4)
}

year_to_mean_plot <- function(the_year){
  age_effect_tibble_adj |>
    filter(old_year == the_year) |>
    ggplot(aes(x = age, y = cite_ratio)) +
    geom_point(size = 2, alpha = 1, color = hcl(h = (the_year-1975)*(360/43)+15, l = 65, c = 100)) +
    # geom_jitter(aes(size=(old_year==2008 | old_year == 1985), shape = (old_year==2008)), alpha = 1) +
    #  geom_jitter(aes(size=(old_year %in% c(1978, 1980, 1985, 1987)), alpha = 1)) +
    # scale_size_manual(values=c(0.3,2)) +
    xlab("Age of cited articles") +
    ylab("Citation ratio") +
    geom_line(aes(x = age, y = mean_effect), color = point_col) +
    geom_point(aes(x = age, y = mean_effect), color = point_col, size = 0.4) +
    theme(legend.position = "none")
}