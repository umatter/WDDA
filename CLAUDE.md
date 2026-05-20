# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Teaching repository for the WDDA (Datenmanagement und Datenanalyse) course at BUAS. Contains R code examples, lecture notes, exercise guides, and solutions for a data analysis course. All instructional content is written in German.

## Repository Structure

- `code/` - Standalone R scripts: `lecture_01.R` through `lecture_08.R` and `exercise_01_solutions.R` through `exercise_06_solutions.R`
- `notes/` - R Markdown lecture notes (`notes_lecture_01.Rmd` through `notes_lecture_07.Rmd`) rendered to HTML, plus special topics (e.g., `galton_ox_problem.Rmd` as Beamer slides)
- `exercise_guides/` - Exercise instructions as Rmd source + compiled PDF (`exercise_01_guide` through `exercise_06_guide`)
- `solutions/` - Additional solution materials (`solutions_set_chapter1.Rmd`, `solutions_set_chapter2.Rmd`)
- `data/` - Excel workbooks (`WDDA_01.xlsx` through `WDDA_08.xlsx`) with multiple sheets per file
- `materials/` - Moodle semester overview (`moodle_materials_formatted.Rmd` with `moodle_preamble.tex`), rendered to PDF via pdflatex
- `img/` - Images referenced in notes

## Key Technical Details

- **R >= 4.1.0** required (uses native pipe `|>`)
- Core packages: `readxl`, `tidyverse`, `mosaic`, `e1071`, `plotrix`, `corrplot`, `scatterplot3d`, `rgl`, `car`, `ISLR`, `lubridate`, `vioplot`
- Data is loaded from Excel files via `readxl::read_excel()` with sheet names
- Code intentionally demonstrates both classic nested R syntax and modern pipe syntax for pedagogical purposes

## Rendering R Markdown

Render lecture notes to HTML:
```bash
Rscript -e 'rmarkdown::render("notes/notes_lecture_01.Rmd")'
```

Render exercise guides to PDF (requires xelatex):
```bash
Rscript -e 'rmarkdown::render("exercise_guides/exercise_01_guide.Rmd")'
```

Render Beamer slides (e.g., Galton problem):
```bash
Rscript -e 'rmarkdown::render("notes/galton_ox_problem.Rmd")'
```

## Data Path Conventions

R scripts in `code/` are run from the **repo root** and use paths like `data/WDDA_01.xlsx`. Rmd files in `notes/` and `exercise_guides/` are rendered from their own subdirectory and use `../data/WDDA_01.xlsx`. Some notes Rmd files contain a **dual-chunk pattern**: a visible `eval=FALSE` chunk showing the simple path students see (e.g., `"WDDA_01.xlsx"`) and a hidden `echo=FALSE` chunk with the real relative path (e.g., `"../data/WDDA_01.xlsx"`). Preserve both chunks when editing.

## Code Style

- 2 spaces for indentation
- Follow the [tidyverse style guide](https://style.tidyverse.org/)
- Comments in German explaining statistical concepts alongside code
- Section dividers using `# ---` notation in R scripts
- Linear, teaching-oriented code structure (avoid complex abstractions)
