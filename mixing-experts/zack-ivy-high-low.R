require(tidyverse)

trials <- 100000000

start_time <- Sys.time()

# Set up tibble
master <- tibble(trial = 1:trials)

# Get color for each row
master <- master %>%
  mutate(ball = sample(0:1, trials, replace= T)) %>% # 1 means ball is white, 0 means ball is black
  mutate(zackivy = sample(0:1, trials, replace= T)) %>% # 1 means Zack gets high evidence, 0 means Ivy does
  select(-trial)

# Get probabilities for each expert draw
master$e1 <- runif(trials, min = 0, max = 1)
master$e2 <- runif(trials, min = 0, max = 1)

# Get color for expert 1
master <- master %>%
  mutate(c1 = qhyper(e1, 15 - ball, 14 + ball, 9) + ball) # c1 is number of whites first sees
# It is how many whites are in the 9 plus the extra if it is white

master <- master %>%
  mutate(removed = qhyper(e2, c1 - ball, 9 + ball - c1, 5)) %>%
  mutate(c2 = c1 - removed) %>%
  mutate(lowev = c1 / 10) %>%
  mutate(highev = c2 /5) %>%
  mutate(zack = case_when(zackivy == 1 ~ lowev,
                          TRUE ~ highev)) %>%
  mutate(ivy = case_when(zackivy == 0 ~ lowev,
                          TRUE ~ highev))
  

summary <- master %>%
  group_by(zack, ivy) %>%
  summarise(p = mean(ball), n = n(), .groups = 'drop')
View(summary)
  
end_time <- Sys.time()

end_time - start_time