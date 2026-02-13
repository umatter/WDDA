# WDDA Lecture Materials

This repository contains R code examples and lecture notes for the WDDA (Datenmanagement und Datenanalyse) course at BUAS. The materials focus on practical data analysis using R, demonstrating various syntax styles and data manipulation techniques.

## Repository Structure

```
├── code/
│   ├── lecture_01.R to lecture_08.R        # R code examples from Lectures 1-8
│   ├── exercise_04_solutions.R            # Solutions for Exercise 4
│   ├── exercise_05_solutions.R            # Solutions for Exercise 5
│   └── exercise_06_solutions.R            # Solutions for Exercise 6
├── data/
│   └── WDDA_01.xlsx to WDDA_08.xlsx       # Data files for lectures
├── exercise_guides/
│   ├── exercise_01_guide.Rmd/.pdf         # Exercise guides 1-6
│   └── ...through exercise_06_guide.Rmd/.pdf
├── img/                                   # Images for notes and slides
├── notes/
│   ├── notes_lecture_01.Rmd to notes_lecture_07.Rmd  # Detailed lecture notes
│   └── galton_ox_problem.Rmd/.pdf         # Special topic (Beamer slides)
└── solutions/
    └── solutions_set_chapter1.Rmd         # Additional solution materials
```

## Getting Started

### Prerequisites

- R (>= 4.1.0)
- RStudio (recommended)
- Required R packages:
  - readxl, tidyverse, mosaic, e1071, plotrix
  - corrplot, scatterplot3d, rgl, car, ISLR

### Installation

1. Clone this repository:
```bash
git clone https://github.com/umatter/WDDA.git
```

2. Install required R packages:
```R
install.packages(c("readxl", "tidyverse", "mosaic", "e1071", "plotrix",
                   "corrplot", "scatterplot3d", "rgl", "car", "ISLR"))
```

3. Open the project in RStudio:
   - File -> Open Project -> Navigate to the cloned directory

### Usage

1. The `code/` directory contains standalone R scripts that can be run directly
2. The `notes/` directory contains R Markdown files that can be rendered to HTML/PDF for detailed explanations
3. The `exercise_guides/` directory contains instructions for practical exercises
4. The `data/` directory contains Excel files used in the lectures and exercises

## Content Overview

- **Lectures 01-08**: Progressive series covering:
  - Data import and manipulation
  - Different R syntax styles (classic vs pipe syntax)
  - Descriptive statistics (tabular and graphical)
  - Inferential statistics (sampling, confidence intervals, bootstrap)
  - Simple and multiple linear regression
  - Inference in regression models
  - Non-linear relationships

- **Special Topics**:
  - Galton's Ox problem (see notes/galton_ox_problem.Rmd)

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
