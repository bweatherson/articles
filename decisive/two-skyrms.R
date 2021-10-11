require(tidyverse)
#set.seed(1)

## These aren't really PD and Stag
## Just quickly seeing how Asymmetric Death in Damascus works in this model

pd_payoff <- c(0, 90,10,0)
stag_payoff <- c(0,40,10,0)

stag_hunt <- function(play, predict){
  t <- 2 * play + predict + 1
  stag_payoff[t]
}
pris_dill <- function(play, predict){
  t <- 2 * play + predict + 1
  pd_payoff[t]
}

second_play_calculate <- function(strat, play, predict){
  t <- strat %% 16  
  g <- 3 - 2*play - predict
  t <- floor((t %% (2^(g + 1)))/(2^g))
  t
}

# Function for results given play X, predict Y
strat_pair <- function(x, y){
  score <- 0
  
  # Work out what they play on first round
  first_play <- case_when(
    x < 16 ~ 0,
    TRUE ~ 1
  )
  first_predict<- case_when(
    y < 16 ~ 0,
    TRUE ~ 1
  )
  
  #Play first round
  score <- score + pris_dill(first_play, first_predict)
  
  second_play <- second_play_calculate(x, first_play, first_predict)
  second_predict<- second_play_calculate(y, first_play, first_predict)
  
  #Play Second Round  
  score <- score + stag_hunt(second_play, second_predict)
  
  score
}


good_plays <- 0:31
#good_plays <- c(2 * 0:7, 16:23) # After removing duplicates
#good_plays <- c(8, 12, 16:19, 21, 23) # After removing non-equilibria
#good_plays <- c(8, 12, 16, 17, 21) # After removing weakly dominated options
#good_plays <- c(0, 4, 8, 12, 16, 17, 18, 19)
#good_plays <- c(4, 12, 18)
#good_plays <- c(0, 8, 16, 17)
#good_plays <- c (8, 16, 17)

StratA <- good_plays
StratB <- good_plays

master <- tibble(
  StratA <- good_plays,
  StratB <- good_plays
)
master <- master %>%
  expand(StratA, StratB)

master <- master %>%
  mutate(Aa = strat_pair(StratA, StratA)) %>%
  mutate(Ab = strat_pair(StratA, StratB)) %>%
  mutate(Ba = strat_pair(StratB, StratA)) %>%
  mutate(Bb = strat_pair(StratB, StratB)) %>%
  mutate(Awin = Aa + Ab - Ba - Bb)

master_wide <- master %>%
  select(StratA, StratB, Ab) %>%
  pivot_wider(names_from = StratB, values_from = Ab)

# # Wedgwood
# 
# benchmark <- c()
# 
# for (i in 1:16){
#   top <- max((master %>% filter(StratB == good_plays[i]))$Ab)
#   bottom <- min((master %>% filter(StratB == good_plays[i]))$Ab)
#   benchmark[i] <- (top + bottom) /2
# }
# 
# surplus <- c()
# 
# for (j in 1:16){
#   surplus[j] <- (master %>% filter(StratA == good_plays[j]))$Aa[1] - benchmark[j]
# }
# 
# # Winners are 17 and 19, with 8 and 12 close behind; 16 (the 'right' option) is a long long way off
# 
# # Gallow
# 
# gallow_pair_comp <- master %>%
#   select(StratA, StratB, Awin) %>%
#   arrange(-Awin) %>%
#   filter(Awin > 0)
# 
# ##16, 18, 20 and 22 are all 5 points ahead of 17
# ## But
# ## 12 is already behind 17
# ## 12 beats 16, 18, 22 and 20 by a mile
# ## It's very close between 17 and 8, but 17 just edges it.

## Skyrms

scoreboard <- tibble(
  strategy = good_plays,
  wins = 0
)

prob_list <- c()

the_matrix <- master %>%
  select(StratA, StratB, Ab)

for (trials in 1:1){
  adj_matrix <- the_matrix
  
#  start_prob = c(0.144, 0.144, 0.144, 0.144, 
#                 0.036, 0.036, 0.036, 0.036, 
#                 0.036, 0.036, 0.036, 0.036,
#                 0.009, 0.009, 0.009, 0.009, 
#                 0.016, 0.004, 0.004, 0.001,
#                 0.016, 0.004, 0.004, 0.001,
#                 0.016, 0.004, 0.004, 0.001,
#                 0.016, 0.004, 0.004, 0.001)

  # f <- function(x){0.8^4 / (4 ^ x)}
  # 
  # prob_row <- c(f(0), f(1), f(1), f(2))
  # prob_half <- c(prob_row, prob_row / 4, prob_row/4, prob_row / 16)  
  # start_prob <- c(prob_half * 0.9, prob_half * 0.1)
  # 
  # #changer <- sample(1:32, 2)
  # changer <- c(1, 17)
  # start_prob[changer[1]] <- start_prob[changer[1]] + 0.0001
  # start_prob[changer[2]] <- start_prob[changer[2]] - 0.0001
  
  current_prob <- tibble(
    strategy = good_plays,
    #prob = start_prob
    prob = 1 / length(good_plays)
    #prob = runif(length(good_plays))
  )  
  

  scaledown = sum(current_prob$prob)
  
  current_prob <- current_prob %>%
    mutate(prob = prob / scaledown)

  
  for (gens in 1:21){
    
    adj_matrix <- the_matrix %>%
      left_join(current_prob, by = c("StratA" = "strategy")) %>%
      rename(ProbA = prob) %>%
      left_join(current_prob, by = c("StratB" = "strategy")) %>%
      rename(ProbB = prob) %>%
      mutate(prob = ProbA * ProbB) %>%
      mutate(ev_contribution = prob * Ab)
    
    by_strategy <- adj_matrix %>%
      group_by(StratA) %>%
      summarise(ev = weighted.mean(Ab, ProbB)) %>%
      mutate(pcov = pmax(ev - sum(adj_matrix$ev_contribution), 0))
    
    spcov = sum(by_strategy$pcov)
    
    current_prob <- current_prob %>%
      left_join(by_strategy, by = c("strategy" = "StratA")) %>%
      mutate(prob = (10* prob + pcov)/(10 + spcov)) %>%
      select(strategy, prob)
    
  }
t <- current_prob %>%
  pivot_wider(names_from = strategy, values_from = prob, names_prefix = "s")

prob_list <- bind_rows(prob_list, t)
#  winprob = max(current_prob$prob)
#  winners = sum(current_prob$prob == winprob)
#  
#  current_prob <- current_prob %>%
#    mutate(winner = case_when(prob == winprob ~ 1 / winners,
#                              TRUE ~ 0))
#  
#  scoreboard$wins <- scoreboard$wins + current_prob$winner
}

View(prob_list)

# Note that the final probabilities are fractions out of 31
# If you round small numbers to 0, multiply others by 31, you get clean answers

# The subgame perfect equilibrium is an equilibrium (duh), but it's super unstable
# Haven't found anything that 