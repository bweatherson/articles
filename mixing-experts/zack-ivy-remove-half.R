require(tidyverse)

master <- expand_grid(marked_ball = 0:1, 
                      who_first = c("Ivy", "Zack"),
                      how_round = 0:1,
                      first_white = 0:20, 
                      white_remove = 0:10) %>% 
  filter(white_remove <= first_white - marked_ball) %>%
  filter(first_white >= marked_ball) %>%
  filter(first_white <= 19 + marked_ball) %>%
  mutate(first_black = 20 - first_white,
         black_remove = 10 - white_remove) %>%
  filter(black_remove <= first_black - 1 + marked_ball) %>%
  mutate(second_white = first_white - white_remove,
         second_black = first_black - black_remove,
         second_total = second_white + second_black,
         first_white_display = case_when(first_white %% 2 == 0 ~ first_white / 2,
                                         TRUE ~ first_white/2 - 0.5 + how_round),
         first_white_display = as.integer(first_white_display),
         ivy_white = case_when(who_first == "Ivy" ~ first_white_display,
                               TRUE ~ second_white),
         zack_white = case_when(who_first == "Zack" ~ first_white_display,
                               TRUE ~ second_white),
         first_prob = dhyper(first_white - marked_ball, 25 - marked_ball, 24 + marked_ball, 19),
         remove_prob = dhyper(white_remove, first_white - marked_ball, first_black - 1 + marked_ball, 10),
         all_prob = 1/8 * first_prob * remove_prob)

player <- master %>%
  group_by(ivy_white, zack_white) %>%
  summarise(prob = weighted.mean(marked_ball, all_prob), .groups = 'drop') %>%
  rename(Ivy = ivy_white, Zack = zack_white, Probability = prob) %>%
  mutate(Ivy = Ivy/10,
         Zack = Zack / 10,
         Probability = round(Probability, 3)) %>%
  pivot_wider(values_from = Probability,
              names_from = Zack) %>%
  rename(`Ivy/Zack` = Ivy)

display_table <- pivot_wider(player,
            values_from = Probability,
            names_from = Zack
            ) %>%
  rename(`Ivy/Zack` = Ivy)