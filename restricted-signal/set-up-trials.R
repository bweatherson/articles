require(tidyverse)

set.seed(22031848)

main_scoreboard <- tribble(
  ~reality, ~c7, ~c8, ~c9, ~c10
)

for (trials in 1:(10^6)){
urn <- runif(1)
samples <- rbinom(10, 10, urn)
main_scoreboard <- main_scoreboard |>
  add_row(
    reality = urn,
    c7 = sum(samples >= 7),
    c8 = sum(samples >= 8),
    c9 = sum(samples >= 9),
    c10 = sum(samples >= 10)
  )
}

main_scoreboard <- main_scoreboard |>
  mutate(target = (reality >= 0.81))
