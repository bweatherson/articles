require(tidyverse)

r <- 0.5 # Proportion of balls that are white

master <- expand_grid(marked_ball = 0:1, 
                      ivy_white = 0:10, 
                      to_remove = 1:9, 
                      white_remove = 0:9, 
                      white_add = 0:9) %>%
  filter(white_remove <= ivy_white - marked_ball) %>%
  filter(white_remove <= to_remove) %>%
  filter(white_add <= to_remove) %>%
  filter(ivy_white >= marked_ball) %>%
  filter(ivy_white <= 9 + marked_ball) %>%
  mutate(ivy_black = 10 - ivy_white,
         black_remove = to_remove - white_remove,
         black_add = to_remove - white_add) %>%
  filter(black_remove <= ivy_black - 1 + marked_ball) %>%
  mutate(zack_white = ivy_white - white_remove + white_add,
         zack_black = ivy_black - black_remove + black_add,
         zack_total = zack_white + zack_black,
         ivy_prob = dhyper(ivy_white - marked_ball, 50 * r - marked_ball, 50 * (1-r) - 1 + marked_ball, 9),
         remove_prob = dhyper(white_remove, ivy_white - marked_ball, ivy_black - 1 + marked_ball, to_remove),
         add_prob = dhyper(white_add, 50 * r - ivy_white + white_remove, 50 * (1-r) - ivy_black + black_remove, to_remove),
         all_prob = (1-r + marked_ball * (2 * r - 1)) * ivy_prob * remove_prob * add_prob)

player <- master %>%
  group_by(ivy_white, zack_white, to_remove) %>%
  summarise(prob = weighted.mean(marked_ball, all_prob), .groups = 'drop') %>%
  rename(Ivy = ivy_white, Zack = zack_white, Removed = to_remove, Probability = prob) %>%
  mutate(Ivy = Ivy/10, Zack = Zack / 10)

player_plot <- ggplot(player, aes(Removed, Probability)) +
  geom_point(size = 0.2) +
  facet_grid(rows = vars(Ivy), cols = vars(Zack)) +
  theme_light() +
  scale_x_continuous(breaks = seq(2, 8, 3)) +
  scale_y_continuous(breaks = seq(0.2, 0.8, 0.3)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())

#player_plot

filtered_plot <- ggplot(player %>%
                          filter(Ivy >= 0.7, Ivy <= 0.9, Zack >= 0.7, Zack <= 0.9),
                        aes(Removed, Probability)) +
  geom_point(size = 0.2) +
  facet_grid(rows = vars(Ivy), cols = vars(Zack)) +
  theme_light() +
  scale_x_continuous(breaks = seq(2, 8, 3)) +
  scale_y_continuous(breaks = seq(0.7, 0.9, 0.1)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())

#filtered_plot

middle_plot <- ggplot(player %>%
                          filter(Ivy >= 0.3, Ivy <= 0.7, Zack >= 0.3, Zack <= 0.7),
                        aes(Removed, Probability)) +
  geom_point(size = 0.2) +
  facet_grid(rows = vars(Ivy), cols = vars(Zack)) +
  theme_light() +
  scale_x_continuous(breaks = seq(2, 8, 3)) +
  scale_y_continuous(breaks = seq(0.2, 0.8, 0.2)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())

#middle_plot

player$type = "Calculated"

# player_model <- player %>%
#   mutate(Probability = (9-Removed) * ((Ivy * Zack)/100) ^ 0.5 / (((Ivy * Zack)/100) ^ 0.5 + (((10-Ivy) * (10-Zack))/100) ^ 0.5 )/ 9 + (Removed / 9) * (Ivy * Zack) / (Ivy * Zack + (10- Ivy) * (10 - Zack))) %>%
#   mutate(type = "Model")
# 
# all_player <- bind_rows(player, player_model)
# 
# ggplot(all_player %>%
#                           filter(Ivy >= 3, Ivy <= 7, Zack >= 3, Zack <= 7),
#                         aes(Removed, Probability)) +
#   geom_point(size = 1, aes(shape = type)) +
#   facet_grid(rows = vars(Ivy), cols = vars(Zack)) +
#   theme_light() +
#   scale_x_continuous(breaks = seq(2, 8, 3)) +
#   scale_y_continuous(breaks = seq(0.2, 0.8, 0.3)) +
#   theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())


player_model <- player %>%
  mutate(new_proportion = Removed/9,
         power_raise = (new_proportion + 1)/2,
         Prob_if_p = (Ivy * Zack)^power_raise,
         Prob_if_np = ((1-Ivy) * (1-Zack))^power_raise,
         Probability = Prob_if_p/(Prob_if_p + Prob_if_np),
         type = "Model"
  )

all_player <- bind_rows(player, player_model)

ggplot(all_player %>%
         filter(Ivy >= 0.8, Ivy <= 0.9, Zack >= 0.8, Zack <= 0.9),
       aes(Removed, Probability)) +
  geom_point(size = 1, aes(shape = type)) +
  facet_grid(rows = vars(Ivy), cols = vars(Zack)) +
  theme_light() +
  scale_x_continuous(breaks = seq(2, 8, 3)) +
  scale_y_continuous(breaks = seq(0.2, 0.8, 0.3)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())