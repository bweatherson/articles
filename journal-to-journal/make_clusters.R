require(igraph)

graph_input <- cross_citation_count_distinct |>
  select(old_journal, new_journal, weight = ratio_score)

main_graph <- graph_from_data_frame(graph_input, directed = TRUE)

main_clusters <- cluster_optimal(main_graph)

temp <- communities(main_clusters) 

the_categories <- membership(main_clusters) %>%
  enframe() %>%
  mutate(old = as.character(name)) %>% 
  select(-name) %>% 
  left_join(main_bib, by = "old") %>%
  arrange(-n, value) 