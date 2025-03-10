library(tidyverse)

# Read the text file
text_data <- read_lines("defer-infinite.tex")

# Create a vector of all unicode characters in the file
unicode_vector <- str_split(text_data, "") %>% unlist() %>% unique()

# Print the vector
#view(unicode_vector)

new_tex <- text_data |>
  str_replace_all("∀", "$\\\\forall$") |>
  str_replace_all("∧", "$\\\\wedge$") |>
  str_replace_all("λ", "$\\\\lambda$") |>
  str_replace_all("∈", "$\\\\in$") |>
  str_replace_all("½", "$\\\\frac{1}{2}$") |>
  str_replace_all("¬", "$\\\\neg$") |>
  str_replace_all("⊆", "$\\\\subseteq$") |>
  str_replace_all("⩾", "$\\\\geq$") |>
  str_replace_all("⩽", "$\\\\leq$") |>
  str_replace_all("∞", "$\\\\infty$") |>
  str_replace_all("⅔", "$\\\\frac{2}{3}$") |>
  str_replace_all("π", "$\\\\pi$") |>
  str_replace_all("⟨", "$\\\\langle$") |>
  str_replace_all("⟩", "$\\\\rangle$") |>
  str_replace_all("⅓", "$\\\\frac{1}{3}$") |>
  str_replace_all("∅", "$\\\\emptyset$") |>
  str_replace_all("∩", "$\\\\cap$") |>
  str_replace_all("•", "$\\\\cdot$") |>
  str_replace_all("Σ", "$\\\\Sigma$") |>
  str_replace_all("⟩", "$\\\\rangle$") |>
  str_replace_all("⟩", "$\\\\rangle$") |>
  str_replace_all("defer-infinite_files/figure-pdf/","") |>
  paste(collapse = "\n")

write_file(new_tex, "defer-infinite-modified.tex")