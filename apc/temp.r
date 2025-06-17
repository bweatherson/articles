
require(tidyverse)
require(slider)
require(stringr)
require(knitr)
require(lsa)
require(wesanderson)

load("/Users/weath/Documents/citations-2025/philo_bib_through_2024.RData")
load("/Users/weath/Documents/citations-2025/philo_cite_through_2024.RData")
load("/Users/weath/Documents/articles/apc/active_journal_list.RData")

# Summarise bibliography by journal
journal_summary <- active_philo_bib %>%
    group_by(journal) %>% # nolint: indentation_linter.
    summarise(
        earliest_year = min(year, na.rm = TRUE),
        latest_year = max(year, na.rm = TRUE),
        n_articles = n()
    )

# Outbound citations: join articles to their journal, count refs per journal
outbound_cites <- active_philo_cite %>%
    left_join(active_philo_bib %>% select(id, journal), by = "id") %>%
    group_by(journal) %>%
    summarise(outbound_citations = n())

# Inbound citations: join refs to their journal, count refs per journal
inbound_cites <- active_philo_cite %>%
    left_join(active_philo_bib %>% select(id, journal), by = c("refs" = "id")) %>%
    group_by(journal) %>%
    summarise(inbound_citations = n())

# Combine all summaries
journal_summary <- journal_summary %>%
    left_join(outbound_cites, by = "journal") %>%
    left_join(inbound_cites, by = "journal") %>%
    replace_na(list(outbound_citations = 0, inbound_citations = 0))

# Show the summary table
journal_summary %>%
    arrange(desc(n_articles)) %>%
    kable()