w# Quarto Setup for Ergo Journal Class

This setup allows you to write Ergo journal articles in Quarto (Markdown) while using the official `ergoclass.cls` LaTeX class for typesetting.

## Files Overview

### Core Files
- **`ergoclass.cls`**: The Ergo journal LaTeX class (provided by you)
- **`ergo-article.qmd`**: Example Quarto document (single author)
- **`ergo-article-multi.qmd`**: Example Quarto document (multi-author)

### Template Partials
- **`title.tex`**: Handles title, author, abstract, and metadata for single-author papers
- **`title-multi.tex`**: Enhanced version with multi-author support (up to 3 authors)
- **`before-body.tex`**: Inserts `\maketitle` command
- **`preamble.tex`**: For additional LaTeX packages (currently minimal)

### Filters
- **`ergodescription.lua`**: Converts Pandoc definition lists to `ergodescription` environments

## Installation & Setup

### 1. Place Files in Your Project Directory

```
your-project/
├── ergoclass.cls          # The class file
├── ergo-article.qmd       # Your Quarto document
├── title.tex              # Or title-multi.tex
├── before-body.tex
├── preamble.tex
├── ergodescription.lua
└── references.bib         # Your bibliography
```

### 2. Install Quarto

If you haven't already, install Quarto from https://quarto.org/docs/get-started/

## Usage

### Basic Single-Author Document

```yaml
---
title: "Your Article Title"
format:
  pdf:
    documentclass: ergoclass
    template-partials:
      - before-body.tex
      - title.tex
    include-in-header:
      - preamble.tex
    keep-tex: true
    cite-method: natbib
    biblio-style: "apalike"
filters:
  - ergodescription.lua
author:
  - name: "Your Name"
    affiliation: "Your Affiliation"
    email: "your.email@institution.edu"
abstract: |
  Your abstract text here.
ergo:
  volume: "1"
  issue: "1"
  year: "2025"
  doi: "https://doi.org/---"
  startpage: 1
bibliography: references.bib
---
```

### Multi-Author Document

For papers with 2-3 authors, use `title-multi.tex` and the `ergo-authors` field:

```yaml
---
title: "Multi-Author Paper"
format:
  pdf:
    documentclass: ergoclass
    template-partials:
      - before-body.tex
      - title-multi.tex  # Note: use title-multi.tex
    include-in-header:
      - preamble.tex
    keep-tex: true
    cite-method: natbib
filters:
  - ergodescription.lua
ergo-authors:
  - name: "First Author"
    affiliation: "First Affiliation"
    email: "first@institution.edu"
  - name: "Second Author"
    affiliation: "Second Affiliation"
    email: "second@institution.edu"
  - name: "Third Author"
    affiliation: "Third Affiliation"
    email: ""  # Can leave blank
abstract: |
  Your abstract here.
ergo:
  volume: "1"
  issue: "1"
  year: "2025"
  doi: "https://doi.org/---"
  startpage: 1
  authornote: "Optional author note"
bibliography: references.bib
---
```

### Writing Content

#### Sections

Use standard Markdown headings:

```markdown
# Section
## Subsection
### Subsubsection
```

#### Definition Lists (Cases/Scenarios)

The Lua filter automatically converts Pandoc definition lists to `ergodescription` environments:

```markdown
Trolley
:   The trolley is heading toward five people...

Case 1
:   In this variant, you can pull a lever...
```

To add a title to the description block, add attributes after the list:

```markdown
Trolley
:   The trolley is heading toward five people...

Case 1
:   In this variant, you can pull a lever...

{.ergodescription title="Classic Trolley Cases"}
```

#### Citations

Use standard Pandoc citation syntax:

```markdown
This was argued by @smith2020.
Several authors have noted this [@jones2019; @brown2021].
```

#### Drop Cap (Lettrine)

For the drop cap at the start of your article, you'll need to use raw LaTeX:

```markdown
\lettrine{F}{or} articles starting without a section...
```

## Rendering Your Document

### Command Line

```bash
quarto render ergo-article.qmd
```

This will produce `ergo-article.pdf` and (because of `keep-tex: true`) `ergo-article.tex`.

### RStudio

Open the `.qmd` file in RStudio and click the "Render" button.

### VS Code

Install the Quarto extension and use the render command or preview pane.

## Customization

### Adding LaTeX Packages

Edit `preamble.tex` to add additional packages:

```latex
\usepackage{booktabs}
\usepackage{longtable}
\usepackage{yourpackage}
```

### Modifying the Lua Filter

By default, `ergodescription.lua` converts **all** definition lists to `ergodescription` environments. 

To only convert lists explicitly marked with the `.ergodescription` class:

1. Open `ergodescription.lua`
2. Find and comment out this line:
   ```lua
   if not is_ergodesc then
     is_ergodesc = true  -- Convert all definition lists by default
   end
   ```
3. Then you must explicitly mark lists in your markdown:
   ```markdown
   Term
   :   Definition
   
   {.ergodescription}
   ```

### Bibliography Styles

The default is `apalike`. To change it, modify the YAML:

```yaml
biblio-style: "plainnat"  # or other natbib-compatible style
```

## Troubleshooting

### "Class file not found" error

Make sure `ergoclass.cls` is in the same directory as your `.qmd` file, or in your LaTeX search path.

### Definition lists not converting

1. Check that `ergodescription.lua` is in the same directory
2. Verify it's listed under `filters:` in your YAML
3. Make sure you're using the correct definition list syntax (term on one line, `:` and definition on the next)

### Citations not working

1. Ensure `references.bib` exists and is referenced in your YAML
2. Check that `cite-method: natbib` is set
3. Verify your `.bib` file has valid BibTeX entries

### Keep the intermediate .tex file

The `keep-tex: true` option in the YAML ensures the generated LaTeX file is kept. This is useful for debugging or making final manual adjustments.

## Advanced: Custom Templates

If you need more control over the LaTeX output, you can create a full custom Pandoc template. However, the partial templates approach used here is usually sufficient for most needs.

## Notes

- The `ergoclass.cls` requires specific LaTeX packages (natbib, mathpazo, etc.) which should be installed with a full TeX distribution
- Page dimensions are set by the class file (7in x 10in)
- The class uses specific fonts (Palatino/mathpazo)
- Headers and footers are automatically formatted per Ergo journal style

## Example Output Structure

Your rendered document will have:
- Ergo journal header with logo
- Title in small caps
- Author name(s) in uppercase
- Affiliation(s) in italics
- Abstract with indentation
- Contact information as footnote
- Properly formatted sections
- Custom description environments for cases
- Bibliography in Ergo format
