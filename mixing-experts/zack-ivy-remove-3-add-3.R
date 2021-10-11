require(tidyverse)

trials <- 10^9

big_summary <- c()

for(i in 1:9){

#start_time <- Sys.time()

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
master$e3 <- runif(trials, min = 0, max = 1)

# Get color for expert 1
master <- master %>%
  mutate(firstwhite = qhyper(e1, 25 - ball, 24 + ball, 9) + ball) # c1 is number of whites first sees
# It is how many whites are in the 9 plus the extra if it is white

master <- master %>%
  mutate(removed = qhyper(e2, firstwhite - ball, 9 + ball - firstwhite, i)) %>%
  mutate(keptwhite = firstwhite - removed) %>%
  mutate(newwhite = qhyper(e3, 25 - keptwhite, keptwhite + 15 + i, i)) %>%
  mutate(secondwhite = keptwhite + newwhite) %>%
  mutate(ivy = firstwhite / 10) %>%
  mutate(zack = secondwhite / 10) %>%
  mutate(lowprob = pmin(ivy, zack)) %>%
  mutate(highprob = pmax(ivy, zack))
  

summary2 <- master %>%
  group_by(lowprob, highprob) %>%
  summarise(p = mean(ball), n = n(), .groups = 'drop')

rm(master)

#end_time <- Sys.time()

#end_time - start_time

summary2$c <- i

big_summary <- bind_rows(big_summary, summary2)
}

highlights <- big_summary %>%
  filter(lowprob == 0.3, highprob == 0.8)

View(highlights)

theplot <- ggplot(big_summary, aes(c, p)) + geom_point(size = 0.2)

theplot + facet_grid(rows = vars(lowprob), cols = vars(highprob), scales = "free")