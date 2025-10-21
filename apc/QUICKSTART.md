# Quick Start Guide

## Minimal Setup (3 steps)

1. **Copy these files to your project folder:**
   - `ergoclass.cls` (your existing class file)
   - `ergo-article.qmd` (or `ergo-article-multi.qmd`)
   - `title.tex` (or `title-multi.tex`)
   - `before-body.tex`
   - `preamble.tex`
   - `ergodescription.lua`
   - `references.bib` (your bibliography)

2. **Edit the YAML header** in the `.qmd` file with your information:
   - Title, author, affiliation, email
   - Volume, issue, year, DOI
   - Abstract

3. **Render:**
   ```bash
   quarto render ergo-article.qmd
   ```

## Single Author vs Multi-Author

**Single Author:** Use `title.tex` partial
```yaml
template-partials:
  - before-body.tex
  - title.tex
author:
  - name: "Your Name"
    affiliation: "Your Institution"
    email: "your@email.com"
```

**Multi-Author (2-3 authors):** Use `title-multi.tex` partial
```yaml
template-partials:
  - before-body.tex
  - title-multi.tex
ergo-authors:
  - name: "First Author"
    affiliation: "First Affiliation"
    email: "first@email.com"
  - name: "Second Author"
    affiliation: "Second Affiliation"
    email: "second@email.com"
```

## Writing Tips

### Definition Lists (for cases/scenarios)
```markdown
Case Name
:   Description of the case goes here.

Another Case
:   Another description.
```

### Add a title to your definition block:
```markdown
Case 1
:   Description.

{.ergodescription title="My Cases"}
```

### Citations
```markdown
@author2020 says something.
Multiple citations [@author2020; @other2021].
```

### Drop Cap
```markdown
\lettrine{F}{or} the first paragraph...
```

## File You Can Modify

- **Your `.qmd` file**: Write your content here in Markdown
- **`preamble.tex`**: Add extra LaTeX packages if needed
- **`references.bib`**: Your bibliography entries

## Files You Shouldn't Need to Modify

- `ergoclass.cls`
- `title.tex` / `title-multi.tex`
- `before-body.tex`
- `ergodescription.lua`

## Common Issues

**Problem:** "Cannot find ergoclass.cls"
**Solution:** Make sure the `.cls` file is in the same directory as your `.qmd` file

**Problem:** Definition lists aren't formatting correctly
**Solution:** Make sure `ergodescription.lua` is in the same directory and listed in `filters:`

**Problem:** Citations not appearing
**Solution:** Make sure `references.bib` exists and is referenced in your YAML header

## Output

Running `quarto render` will create:
- `ergo-article.pdf` - Your final PDF
- `ergo-article.tex` - The intermediate LaTeX file (useful for debugging)

See `README.md` for full documentation.
