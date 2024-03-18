require(tidyverse)

x <- seq(from = 0, to = 1, by = 0.01)
pool <- tibble(x = x) |>
  mutate(symm = pnorm(2*qnorm(x, 0, sqrt(2)),0,1)) |>
  mutate(asymm = pnorm(qnorm(x, 0, sqrt(2)) + qnorm(x, 0, sqrt(3)),0,1)) |>
  mutate(many = pnorm(2*qnorm(x, 0, sqrt(3)),0,sqrt(2))) |>
  mutate(geom = x^2 / (x^2 + (1-x)^2))

pool_plot <- pool |>
  pivot_longer(cols = symm:geom)

ggplot(pool_plot) + 
  geom_line(aes(x = x, y = value, color = name))
  


