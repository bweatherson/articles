decade_cites <- all_cites |>
  filter(TRUE) |>
  group_by(old) |>
  tally(name = "dec_cites") |>
  slice_max(order_by = dec_cites, n = 120, with_ties = FALSE)
dec_ps_cites <- all_cites |>
  filter(TRUE,
         new_journal == "Philosophical Studies",
         old %in% decade_cites$old) |>
  group_by(old) |>
  tally(name = "dec_ps_cites")
decade_cites <- decade_cites |>
  left_join(dec_ps_cites,
            by = "old") |>
  replace_na(list(dec_ps_cites = 0)) |>
  mutate(ratio = dec_ps_cites/dec_cites,
         decade = the_decade) |>
  left_join(short_bib,
            by = c("old" = "id")) |>
  select(-cites) |>
  mutate(Citation = paste0("@", str_replace(old, ":", ""))) |>
  select(Citation, `PS Citations` = dec_ps_cites, `All Citations` = dec_cites, Ratio = ratio, everything()) |>
  arrange(decade, -Ratio, `All Citations`) |>
  rowid_to_column(var = "Rank")
decade_comparison <- decade_comparison |>
  bind_rows(decade_cites) 

most_cited <- all_cites |>
  filter(new_year >= 1980, new_year <= 2019, old_year > 1960) |>
  group_by(old) |>
  tally(name = "all_cites") |>
  slice_max(order_by = all_cites, n = 80, with_ties = TRUE)

ps_top_cites <- all_cites |>
  filter(new_journal == "Philosophical Studies",
         new_year >= 1980,
         new_year <= 2019,
         old %in% most_cited$old) |>
  group_by(old) |>
  tally(name = "ps_cites") |>
  left_join(most_cited, by = "old") |>
  left_join(short_bib,
            by = c("old" = "id")) |>
  mutate(Citation = paste0("@", str_replace(old, ":", ""))) 
ps_base_rate <- sum(ps_top_cites$ps_cites) / sum(ps_top_cites$all_cites)
ps_top_cites <- ps_top_cites |>
  mutate(ps_prob = pbinom(ps_cites, all_cites, ps_base_rate)) |>
  arrange(ps_prob)
  
