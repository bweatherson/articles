require(ggplot2)
require(dplyr)

# Function to generate the three graphs
generate_word_graphs <- function(word, d) {
  # Filter data for the specified word
  word_data <- common_ps_words %>% filter(word == !!word)
  
  # Calculate averages for dashed lines
  avg_frequency <- sum(word_data$count) / sum(word_data$all_words) * 1000
  avg_percentage_uses <- mean(word_data$uses / word_data$articles * 100, na.rm = TRUE)
  avg_percentage_topic <- mean(word_data$topic / word_data$articles * 100, na.rm = TRUE)
  
  # Graph 1: Word frequency per 1000 words
  p1 <- ggplot(word_data, aes(x = year, y = (count / all_words) * 1000)) +
    geom_rect(data = tibble(start = d-0.5, end = d+9.5), aes(xmin = start , xmax = end, ymin = -Inf, ymax = Inf),
              inherit.aes=FALSE, alpha = 0.4, fill = rgb(249/300,255/300,255/300)) +
    geom_point() +
    geom_hline(yintercept = avg_frequency, linetype = "dashed", color = "red") +
    labs(title = paste("Word Frequency for:", word),
         x = "Year", y = "Frequency per 1000 Words") +
    theme_minimal()
  
  # Graph 2: Percentage of articles including the word
  p2 <- ggplot(word_data, aes(x = year, y = (uses / articles) * 100)) +
    geom_rect(data = tibble(start = d-0.5, end = d+9.5), aes(xmin = start , xmax = end, ymin = -Inf, ymax = Inf),
              inherit.aes=FALSE, alpha = 0.4, fill = rgb(249/300,255/300,255/300)) +
    geom_point() +
    geom_hline(yintercept = avg_percentage_uses, linetype = "dashed", color = "red") +
    labs(title = paste("Percentage of Articles Including:", word),
         x = "Year", y = "Percentage of Articles") +
    theme_minimal()
  
  # Graph 3: Percentage of articles with 10+ occurrences of the word
  p3 <- ggplot(word_data, aes(x = year, y = (topic / articles) * 100)) +
    geom_rect(data = tibble(start = d-0.5, end = d+9.5), aes(xmin = start , xmax = end, ymin = -Inf, ymax = Inf),
              inherit.aes=FALSE, alpha = 0.4, fill = rgb(249/300,255/300,255/300)) +
    geom_point() +
    geom_hline(yintercept = avg_percentage_topic, linetype = "dashed", color = "red") +
    labs(title = paste("Percentage of Articles with 10+ Uses of:", word),
         x = "Year", y = "Percentage of Articles") +
    theme_minimal()
  
  # Return the plots
  list(frequency_plot = p1, percentage_uses_plot = p2, percentage_topic_plot = p3)
}

generate_word_figures <- function(word) {
  cat(
    paste0(
      '```{r}\n',
      '#| label: fig-', word, '\n',
      '#| fig-cap: "Frequency data: ', tools::toTitleCase(word), '"\n',
      '#| fig-subcap:\n',
      '    - "Frequency"\n',
      '    - "Usage"\n',
      '    - "10 Uses"\n\n',
      'generate_word_graphs("', word, '")[[1]]\n',
      'generate_word_graphs("', word, '")[[2]]\n',
      'generate_word_graphs("', word, '")[[3]]\n',
      '```\n'
    )
  )
}
