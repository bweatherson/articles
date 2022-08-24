require(tidyverse)
set.seed(1)

# Set up tibble to record results
master <- tribble(
  ~StratA, ~StratB, ~Aa, ~Ab, ~Ba, ~Bb, ~ASurplus
)

# Variable for accuracy of predictor
pacc <- 1.1

# Number of trials
trial <- 1

# Individual stag hunt game

#epsil <- 10^(-6)
#pd_payoff <- c(4.999, 0, 5, 0.001)
#stag_payoff <- c(2 * epsil, 5 - epsil, 0, 5)

pd_payoff <- c(4, 0, 5, 1)
stag_payoff <- c(15, 40, 0, 50)

stag_hunt <- function(play, predict){
  t <- 2 * play + predict + 1
  stag_payoff[t]
}
pris_dill <- function(play, predict){
  t <- 2 * play + predict + 1
  pd_payoff[t]
}

# Work out what second play is given results of first play
second_play_calculate <- function(strat, play, predict){
  t <- strat %% 16
  g <- 3 - 2*play - predict
  t <- floor((t %% (2^(g + 1)))/(2^g))
  t
}

# Function for results given play X, predict Y
million_trial <- function(x, y){
  # This will keep track across all million trials
  score <- 0
  
  # Work out what they play on first round
  first_play <- case_when(
    x < 16 ~ 0,
    TRUE ~ 1
  )
  first_predict_perfect <- case_when(
    y < 16 ~ 0,
    TRUE ~ 1
  )
  
  for (i in 1:trial){
    first_predict <- case_when(
      runif(1) < pacc ~ first_predict_perfect,
      TRUE ~ 1 - first_predict_perfect
    )
    score <- score + pris_dill(first_play, first_predict)
    
    second_play <- second_play_calculate(x, first_play, first_predict)
    second_predict_perfect <- second_play_calculate(y, first_play, first_predict)
    second_predict <- case_when(
      runif(1) < pacc ~ second_predict_perfect,
      TRUE ~ 1 - second_predict_perfect
    )
    
    score <- score + stag_hunt(second_play, second_predict)
  }
  score
}

# all_strats <- c()
# 
# current_strat <- 17
# 
# for (cycle in 1:30){
# master <- tibble(StratA = current_strat, StratB = 0:31) %>%
#   mutate(Aa = million_trial(StratA, StratA)) %>%
#   mutate(Ab = million_trial(StratA, StratB)) %>%
#   mutate(Ba = million_trial(StratB, StratA)) %>%
#   mutate(Bb = million_trial(StratB, StratB)) %>%
#   mutate(Awin = Aa + Ab - Ba - Bb) %>%
#   arrange(Awin)
# 
# current_strat <- master$StratB[1]
# all_strats <- c(all_strats, current_strat)
# #View(master)
# }


#good_plays <- 0:31
#good_plays <- c(2 * 0:7, 16:23) # After removing duplicates
#good_plays <- c(8, 12, 16:19, 21, 23) # After removing non-equilibria
good_plays <- c(8, 12, 16, 17, 21) # After removing weakly dominated options
#good_plays <- c(0, 4, 8, 12, 16, 17, 18, 19)
#good_plays <- c(0, 8, 16, 17)
#good_plays <- c (8, 16, 17)

StratA <- good_plays
StratB <- good_plays

population <- tibble(
  strat = 0:31,
  share = c(0.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
)


master <- tibble(
  StratA <- good_plays,
  StratB <- good_plays
)
master <- master %>%
  expand(StratA, StratB)

master <- master %>%
  mutate(Aa = million_trial(StratA, StratA)) %>%
  mutate(Ab = million_trial(StratA, StratB)) %>%
  mutate(Ba = million_trial(StratB, StratA)) %>%
  mutate(Bb = million_trial(StratB, StratB)) %>%
  mutate(Awin = Aa + Ab - Ba - Bb)

master_wide <- master %>%
  select(StratA, StratB, Ab) %>%
  pivot_wider(names_from = StratB, values_from = Ab)

# master_best <- tibble(StratA = good_plays, overall = 0)
# 
# for (i in 1:length(good_plays)){
#        master_best$overall[i] <- filter(
#          master, StratA == master_best$StratA[i], StratB == master_best$StratA[i]
#        )$Aa[1] -
#          mean(
#          filter(
#            master, StratB == master_best$StratA[i]
#          )$Ab)
# }
# 
# master_best <- master_best %>%
#   arrange(-overall) %>%
#   filter(overall > 0)
# 
# 
# #t <- nrow(master_best) - 1
# good_plays <- master_best$StratA

#View(master_best)


#for (i in 1:length(good_plays)){
#  l = min(filter(master, StratA == good_plays[i])$Awin)
#  master_best$shortage[i] <- l
#}

#population <- tibble(
#  strat = 0:31,
#  share = c(0.47, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.5, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.01)
#)

population <- tibble(
  strat = good_plays,
  share = 1/length(good_plays) + runif(length(good_plays))/20
)

init_pop <- population

for (gen in 1:100){
  scoreboard <- master %>%
    left_join(population, by = c("StratB" = "strat")) %>%
    group_by(StratA) %>%
    summarise(result = weighted.mean(Ab, share), .groups = "drop") %>%
    left_join(population, by = c("StratA" = "strat")) %>%
    mutate(new_pop = result * share)
 t <- sum(scoreboard$new_pop)
 population <- scoreboard %>%
   mutate(strat = StratA, share = new_pop/t) %>%
   select(strat, share)
}

sampler <- tibble(
  a = 1 - runif(10000)^(1/3),
  b = (1 - runif(10000)^(1/2)) * (1-a),
  c = (1 - a - b) * runif(10000),
  d = 1 - a - b - c
)

sampler <- sampler %>%
  add_column(winner = "unknown")

for (trials in 1:12000){

population <- tibble(
  strat = good_plays,
  share = sampler %>% slice(trials) %>% select(1:4) %>% as.numeric()
)

for (gen in 1:100){
  scoreboard <- master %>%
    left_join(population, by = c("StratB" = "strat")) %>%
    group_by(StratA) %>%
    summarise(result = weighted.mean(Ab, share), .groups = "drop") %>%
    left_join(population, by = c("StratA" = "strat")) %>%
    mutate(new_pop = result * share)
  t <- sum(scoreboard$new_pop)
  population <- scoreboard %>%
    mutate(strat = StratA, share = new_pop/t) %>%
    select(strat, share)
}

population <- population %>% arrange(-share)

sampler$winner[trials] <- population$strat[1]

}

sampler_sum <- sampler %>%
  group_by(winner) %>%
  tally()

sampler_complete <- sampler %>%
  slice(1:5500)

sampler_17 <- sampler_complete %>%
  filter(winner == 17)
