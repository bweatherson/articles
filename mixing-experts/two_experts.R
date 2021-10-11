require(tidyverse)
# t <- sample(1:199, 100, replace = F)
# t <- sort(t)
# c <- sample(1:200, 1, replace = F)
# skipper <- function(x){
#   case_when(x < c ~ x,
#             TRUE ~ x + 1)
# }
# c <- 3
# t2 <- map(t, as.numeric)
# t3 <- map(t2, skipper)

#c <- sample(1:200, 1, replace = F)
#t <- sample(1:199, 100, replace = F)
#t <- sort(t)
#sum(t < 100)

master <- tibble(trial = 1:100)
master <- master %>% 
  rowwise() %>%
  mutate(c = sample(1:200, 1, replace = F)) %>%
  mutate(t1 = list(sample(1:199, 100, replace = F))) %>%
  mutate(v1 = case_when(c < 101 ~ sum(t < 100),
                       TRUE ~ sum(t < 101))) %>%
  mutate(t2 = list(sample(1:199, 100, replace = F))) %>%
  mutate(v2 = case_when(c < 101 ~ sum(t < 100),
                        TRUE ~ sum(t < 101))) %>%
  mutate(color = case_when (c < 101 ~ 0,
                            TRUE ~ 1))
summary <- master %>%
  ungroup() %>%
  group_by(v1, v2) %>%
  summarise(p = mean(color), .groups = 'drop')
View(summary)
  