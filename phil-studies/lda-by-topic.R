# loop through topics for LDA

require(tidyverse)
require(tm)
require(topicmodels)
require(tidytext)
require(lsa)

#load("ps_cites.RData")
#load("ps_meta.RData")
#load("ps_join.RData")

cats <- 3
seed_min <- 2e5
seed_max <- 9e5
r0_models <- 4
r1_models <- 3
r2_models <- 2
r3_models <- 1

ps_to_ps <- ps_cites |>
  left_join(ps_join,
            by = c("id" = "wos_id")) |>
  filter(!is.na(jstor_id)) |>
  rename(new = jstor_id) |>
  select(-id) |>
  left_join(ps_join,
            by = c("refs" = "wos_id")) |>
  filter(!is.na(jstor_id)) |>
  rename(old = jstor_id) |>
  select(-refs)

topic_list <- c(
  "lda-Epistemology",
  "lda-Ethics",
  "lda-Language",
  "lda-Metaphysics",
  "lda-Mind"
)

for (the_topic in topic_list){
  topic_articles <- ps_uni |>
    filter(!!rlang::sym(the_topic) > 0.5)
  
  topic_articles_wos_id <- distinct(topic_articles, wos_id)$wos_id
  topic_articles_jstor_id <- distinct(topic_articles, jstor_id)$jstor_id
  
  ps_to_ps_topic_only <- ps_to_ps |>
    filter(new %in% topic_articles_jstor_id,
           old %in% topic_articles_jstor_id)
  
  topic_dtm <- cast_dtm(topic_articles, jstor_id, ngram, count)

  scoreboard <- tribble(
    ~seed, ~cats, ~topic, ~score
  )
  
  first_scoreboard <- tribble(
    ~seed, ~cats, ~topic, ~score
  )
  
  seed_list <- sample(seed_min:seed_max, r0_models)
  
  for (seed in seed_list){
    
    topic_lda <- LDA(topic_dtm,
                      k = cats,
                      control = list(
                        seed = seed,
                        verbose = 0,
                        em = list(iter.max = 0, tol = 10^-9)
                      )
    )
    
    all_journals_gamma <- tidy(topic_lda, matrix = "gamma")
    
    all_journals_classifications <- all_journals_gamma |>
      group_by(document) |>
      top_n(1, gamma) |>
      ungroup()
    
    all_journals_titles_and_topics <-   left_join(all_journals_classifications,
                                                  ps_join,
                                                  by = c("document" = "jstor_id"))
    
    for (cc in 1:cats){
      active_articles <- all_journals_titles_and_topics |>
        filter(topic == cc)
      
      active_gamma <- all_journals_gamma |>
        filter(document %in% active_articles$document) |>
        group_by(topic) |>
        summarise(gamma = mean(gamma))
      
      cites_gamma <- ps_to_ps_topic_only |>
        filter(new %in% active_articles$document) |>
        left_join(all_journals_gamma,
                  by = c("old" = "document"),
                  relationship = "many-to-many"
        ) |>
        ungroup() |>
        group_by(topic) |>
        summarise(gamma = mean(gamma))
      
      sim_score <-  cites_gamma$gamma[cc]
      
      first_scoreboard <- first_scoreboard |>
        add_row(
          seed = seed,
          cats = cats,
          topic = cc,
          score = sim_score
        )
    }
  }
  
  first_seeds <- (
    first_scoreboard |>
      ungroup() |>
      group_by(seed) |>
      summarise(score = min(score)) |>
      arrange(-score)
  )$seed[1:r1_models]

  
  for (seed in first_seeds){
    
    topic_lda <- LDA(topic_dtm,
                      k = cats,
                      control = list(
                        seed = seed,
                        verbose = 0,
                        em = list(iter.max = 5, tol = 10^-9)
                      )
    )
    
    all_journals_gamma <- tidy(topic_lda, matrix = "gamma")
    
    all_journals_classifications <- all_journals_gamma |>
      group_by(document) |>
      top_n(1, gamma) |>
      ungroup()
    
    all_journals_titles_and_topics <-   left_join(all_journals_classifications,
                                                  ps_join,
                                                  by = c("document" = "jstor_id"))
    
    for (cc in 1:cats){
      active_articles <- all_journals_titles_and_topics |>
        filter(topic == cc)
      
      active_gamma <- all_journals_gamma |>
        filter(document %in% active_articles$document) |>
        group_by(topic) |>
        summarise(gamma = mean(gamma))
      
      cites_gamma <- ps_to_ps_topic_only |>
        filter(new %in% active_articles$document) |>
        left_join(all_journals_gamma,
                  by = c("old" = "document"),
                  relationship = "many-to-many"
        ) |>
        ungroup() |>
        group_by(topic) |>
        summarise(gamma = mean(gamma))
      
      sim_score <- as.numeric(
        cosine(
          active_gamma$gamma,
          cites_gamma$gamma
        )
      )
      
      scoreboard <- scoreboard |>
        add_row(
          seed = seed,
          cats = cats,
          topic = cc,
          score = sim_score
        )
      
    }
    
    save(topic_lda, 
         file = 
           paste0(
             "phil-studies/lda_storage/ps_lda_s",
             seed,
             "_c",
             cats,
             "_r5.RData"
           ))
  }
  
  save(
    scoreboard,
    file = 
      paste0(
        "ps_lda_scoreboard_s",
        seed_min,
        "-s",
        seed_max,
        "_c",
        cats,
        "_r5.RData"
      )
  )
  
  best_seeds <- (
    scoreboard |>
      ungroup() |>
      group_by(seed) |>
      summarise(score = mean(score)) |>
      arrange(-score)
  )$seed[1:r2_models]
  
  second_scoreboard <- tribble(
    ~seed, ~cats, ~topic, ~score
  )
  
  for (the_seed in best_seeds){
    
    the_cats <- cats
    
    load(         
      paste0(
        "phil-studies/lda_storage/ps_lda_s",
        the_seed,
        "_c",
        cats,
        "_r5.RData"
      ))
    
    topic_lda <- LDA(topic_dtm,
                      k = the_cats,
                      model = topic_lda,
                      control = list(
                        initialize = "model",
                        verbose = 20,
                        var = list(iter.max = 95, tol = 10^-9),
                        em = list(iter.max = 95, tol = 10^-9)
                      )
    )
    
    save(topic_lda,
         file = paste0(
           "phil-studies/lda_storage/ps_lda_s",
           the_seed,
           "_c",
           cats,
           "_r100.RData"
         ))
    
    all_journals_gamma <- tidy(topic_lda, matrix = "gamma") 
    
    all_journals_classifications <- all_journals_gamma |>
      group_by(document) |>
      top_n(1, gamma) |>
      ungroup()
    
    all_journals_titles_and_topics <- left_join(all_journals_classifications,
                                                ps_join,
                                                by = c("document" = "jstor_id"))
    
    for (cc in 1:cats){
      active_articles <- all_journals_titles_and_topics |>
        filter(topic == cc)
      
      active_gamma <- all_journals_gamma |>
        filter(document %in% active_articles$document) |>
        group_by(topic) |>
        summarise(gamma = mean(gamma))
      
      cites_gamma <- ps_to_ps_topic_only |>
        filter(new %in% active_articles$document) |>
        left_join(all_journals_gamma,
                  by = c("old" = "document"),
                  relationship = "many-to-many"
        ) |>
        ungroup() |>
        group_by(topic) |>
        summarise(gamma = mean(gamma))
      
      sim_score <- as.numeric(
        cosine(
          active_gamma$gamma,
          cites_gamma$gamma
        )
      )
      
      second_scoreboard <- second_scoreboard |>
        add_row(
          seed = the_seed,
          cats = the_cats,
          topic = cc,
          score = sim_score
        )
    }
  }
  
  final_seeds <- (
    second_scoreboard |>
      ungroup() |>
      group_by(seed) |>
      summarise(score = mean(score)) |>
      arrange(-score)
  )$seed[1:r3_models]
  
  for (the_seed in final_seeds){
    the_cats <- cats
    
    load(         
      paste0(
        "phil-studies/lda_storage/ps_lda_s",
        the_seed,
        "_c",
        cats,
        "_r100.RData"
      ))
    
    topic_lda <- LDA(topic_dtm,
                      k = the_cats,
                      model = topic_lda,
                      control = list(
                        initialize = "model",
                        verbose = 20,
                        var = list(iter.max = 200, tol = 10^-9),
                        em = list(iter.max = 200, tol = 10^-9)
                      )
    )
    
    my_lda <- topic_lda
    
    save(my_lda,
         file = paste0(
           "ps_lda_s",
           the_seed,
           "_c",
           cats,
           "_r300.RData"
         ))
    
    all_journals_gamma <- tidy(topic_lda, matrix = "gamma") 
    
    all_journals_classifications <- all_journals_gamma |>
      group_by(document) |>
      top_n(1, gamma) |>
      ungroup()
    
    all_journals_titles_and_topics <- left_join(all_journals_classifications,
                                                ps_meta,
                                                by = c("document" = "jstor_id"))
    
    phil_topics <- tidy(topic_lda, matrix = "beta")
    
    word_score <- phil_topics |>
      group_by(term) |>
      dplyr::summarise(avgbeta = mean(beta), sdbeta = sd(beta))
    
    busy_topics <- phil_topics |>
      left_join(word_score, by = "term") |>
      right_join(common_ps_words_ethics, by = c("term" = "ngram")) |>
      mutate(score = (beta - avgbeta) * log(tn) / sdbeta)
    
    distinctive_topics <- busy_topics %>%
      group_by(topic) %>%
      slice_max(n = 20, score) %>%
      ungroup() %>%
      arrange(desc(-topic))
    
    distinctive_articles <- all_journals_titles_and_topics |>
      ungroup() |>
      group_by(topic) |>
      slice_max(order_by = gamma, n = 15)
    
    save(
      distinctive_topics,
      file = 
        paste0(
          "ps_lda_words_s",
          the_seed,
          "_c",
          cats,
          ".RData"
        )
    )
    
    save(
      distinctive_articles,
      file = 
        paste0(
          "ps_lda_articles_s",
          the_seed,
          "_c",
          cats,
          ".RData"
        )
    )
    
    short_scoreboard <- tribble(
      ~seed, ~cats, ~topic, ~score
    )
    
    for (cc in 1:cats){
      active_articles <- all_journals_titles_and_topics |>
        filter(topic == cc)
      
      active_gamma <- all_journals_gamma |>
        filter(document %in% active_articles$document) |>
        group_by(topic) |>
        summarise(gamma = mean(gamma))
      
      cites_gamma <- ps_to_ps_topic_only |>
        filter(new %in% active_articles$document) |>
        left_join(all_journals_gamma,
                  by = c("old" = "document"),
                  relationship = "many-to-many"
        ) |>
        ungroup() |>
        group_by(topic) |>
        summarise(gamma = mean(gamma))
      
      sim_score <- as.numeric(
        cosine(
          active_gamma$gamma,
          cites_gamma$gamma
        )
      )
      
      short_scoreboard <- short_scoreboard |>
        add_row(
          seed = the_seed,
          cats = the_cats,
          topic = cc,
          score = sim_score
        )
      
    }
    
    save(short_scoreboard,
         file = paste0(
           "ps_lda_scoreboard_s",
           the_seed,
           "_c",
           cats,
           ".RData"
         ))
    
    
    
    quarto::quarto_render("lda_summary.qmd",
                          output_format = "pdf",
                          output_file = paste0(
                            "ps-lda-summary-",
                            "_",
                            the_topic,
                            "_",
                            the_seed,
                            "-",
                            cats,
                            ".pdf"
                          ),
                          execute_params = list(
                            seed = the_seed,
                            cats = the_cats
                          ))
  }
}
