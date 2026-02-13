# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Teaching repository for the WDDA (Datenmanagement und Datenanalyse) course at BUAS. Contains R code examples, lecture notes, exercise guides, and solutions for a data analysis course. All instructional content is written in German.

## Repository Structure

- `code/` - Standalone R scripts: `lecture_01.R` through `lecture_08.R` and `exercise_*_solutions.R`
- `notes/` - R Markdown lecture notes (`notes_lecture_*.Rmd`) rendered to HTML, plus special topics
- `exercise_guides/` - Exercise instructions as Rmd source + compiled PDF
- `solutions/` - Additional solution materials (Rmd)
- `data/` - Excel workbooks (`WDDA_01.xlsx` through `WDDA_08.xlsx`) with multiple sheets per file
- `img/` - Images referenced in notes

## Key Technical Details

- **R >= 4.1.0** required (uses native pipe `|>`)
- Core packages: `readxl`, `tidyverse`, `mosaic`, `plotrix`, `scatterplot3d`, `rgl`, `car`, `corrplot`
- Data is loaded from Excel files via `readxl::read_excel()` with sheet names
- Code intentionally demonstrates both classic nested R syntax and modern pipe syntax for pedagogical purposes

## Rendering R Markdown

- Exercise guides: render to PDF via `xelatex` engine (`rmarkdown::render()`)
- Lecture notes: render to HTML (`rmarkdown::render()`)
- Rmd files use relative paths (e.g., `../data/WDDA_01.xlsx`)

## Code Style

- 2 spaces for indentation
- Follow the [tidyverse style guide](https://style.tidyverse.org/)
- Comments in German explaining statistical concepts alongside code
- Section dividers using `#----` notation
- Linear, teaching-oriented code structure (avoid complex abstractions)
