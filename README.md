# WDDA Lecture Materials

This repository contains R code examples and lecture notes for the WDDA (Datenmanagement und Datenanalyse) course at BUAS. The materials focus on practical data analysis using R, demonstrating various syntax styles and data manipulation techniques. All instructional content is written in German.

## Repository Structure

```
├── code/
│   ├── lecture_01.R to lecture_08.R          # R code examples from Lectures 1-8
│   └── exercise_04/05/06_solutions.R         # Exercise solutions
├── data/
│   └── WDDA_01.xlsx to WDDA_08.xlsx          # Excel data files (multiple sheets each)
├── exercise_guides/
│   └── exercise_01 to 06_guide.Rmd/.pdf      # Exercise guides with solutions
├── img/                                      # Images for notes and slides
├── notes/
│   ├── notes_lecture_01 to 07.Rmd/.html      # Detailed lecture notes
│   └── galton_ox_problem.Rmd/.pdf            # Special topic (Beamer slides)
└── solutions/
    └── solutions_set_chapter1.Rmd            # Additional solution materials
```

## Getting Started

### Prerequisites

- R (>= 4.1.0)
- RStudio (recommended)
- Required R packages:
  ```R
  install.packages(c("readxl", "tidyverse", "mosaic", "e1071", "plotrix",
                     "corrplot", "scatterplot3d", "rgl", "car", "ISLR",
                     "lubridate", "vioplot"))
  ```

### Usage

- **R scripts** (`code/`): Run directly from the repo root (e.g., in RStudio with the project open). Data paths assume the working directory is the repo root.
- **Lecture notes** (`notes/`): Render to HTML:
  ```bash
  Rscript -e 'rmarkdown::render("notes/notes_lecture_01.Rmd")'
  ```
- **Exercise guides** (`exercise_guides/`): Render to PDF (requires xelatex):
  ```bash
  Rscript -e 'rmarkdown::render("exercise_guides/exercise_01_guide.Rmd")'
  ```

## Content Overview

**Lectures 01-08** form a progressive series covering:
- Data import and manipulation
- Different R syntax styles (classic vs pipe syntax)
- Descriptive statistics (tabular and graphical)
- Inferential statistics (sampling, confidence intervals, bootstrap)
- Simple and multiple linear regression
- Inference in regression models
- Non-linear relationships

**Special Topics:**
- Galton's Ox problem (`notes/galton_ox_problem.Rmd`)

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
