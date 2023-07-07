util <- function(x){tanh(x)}

init_wealth <- 0.01
amount_win <- 4
amount_lose <- 3
win_prob <- 0.5

init_welfare <- util(init_wealth)
bet_welfare <- win_prob * util((init_wealth + amount_win)) + (1 - win_prob) * util((init_wealth - amount_lose))
bet_gain <- bet_welfare - init_welfare

# # strategy - bet, then pass if win, bet if lose
# 
# prob_win_one <- win_prob
# prob_lose_both <- (1 - win_prob) ^ 2
# prob_lose_win <- (1 - win_prob) * win_prob
# 
# strategy_welfare <- prob_win_one * util((init_wealth + amount_win)) +
#                     prob_lose_both * util((init_wealth - 2 * amount_lose)) +
#                     prob_lose_win * util((init_wealth - amount_lose + amount_win))

# Make bet twice (without being told first result)

prob_win_both <- win_prob^2
prob_lose_both <- (1 - win_prob) ^ 2
prob_lose_win <- 2 * (1 - win_prob) * win_prob

strategy_welfare <- prob_win_both * util((init_wealth + 2 * amount_win)) +
                    prob_lose_both * util((init_wealth - 2 * amount_lose)) +
                    prob_lose_win * util((init_wealth - amount_lose + amount_win))
strategy_gain <- strategy_welfare - init_welfare
