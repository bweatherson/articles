word_graphs <- function(x){
  active_docs <- ps_uni |>
    filter(ngram %in% x)
  
  active_docs |>
    group_by(year, ngram) |>
    summarise(#docs = n_distinct(wos_id), 
              words = sum(count),
              .groups = "drop") |>
    left_join(word_count_by_year, by = "year") |>
    mutate(proportion = words/wordcount) |>
    ggplot(aes(x = year, y = proportion)) +
    geom_point() +
    facet_wrap(vars(ngram), ncol = 2) +
    scale_x_continuous(limits = c(1980, 2019),
                       breaks = c(1990, 2010),
                       minor_breaks = 396:404 * 5) +
    labs(x = element_blank(), y = element_blank())
    
}

word_graphs(c("utilitarian", "utilitarianism", "kantian", "utility"))

ps_to_ps <- ps_cites |>
  filter(id %in% short_bib_with_gamma$id)

word_graphs(c("slur", "slurs"))
word_graphs(c("testimony", "trust", "friend", "blame"))