library(tidyverse)

count_documents <- function(tibble, word1, word2) {
    # Filter documents where word1 appears 10 or more times
    word1_docs <- tibble %>%
        filter(word == word1 & count >= 10) %>%
        distinct(id)
    
    # Filter documents where both word1 and word2 appear 10 or more times
    both_words_docs <- tibble %>%
        filter((word == word1 | word == word2) & count >= 10) %>%
        group_by(id) %>%
        filter(n() == 2) %>%
        distinct(id)
    
    # Return the counts
    list(
        word1_count = nrow(word1_docs),
        both_words_count = nrow(both_words_docs)
    )
}