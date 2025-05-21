# WDDA Lecture Materials

This repository contains R code examples and lecture notes for the WDDA (Datenmanagement und Datenanalyse) course at BUAS. The materials focus on practical data analysis using R, demonstrating various syntax styles and data manipulation techniques.

## Repository Structure

```
├── code/
│   ├── lecture_01.R       # R code examples from Lecture 1
│   ├── lecture_02.R       # R code examples from Lecture 2
│   ├── lecture_03.R       # R code examples from Lecture 3
│   ├── lecture_04.R       # R code examples from Lecture 4
│   ├── lecture_05.R       # R code examples from Lecture 5
│   ├── lecture_06.R       # R code examples from Lecture 6
│   ├── exercise_04_solutions.R  # Solutions for Exercise 4
│   └── exercise_05_solutions.R  # Solutions for Exercise 5
├── data/
│   └── WDDA_01.xlsx to WDDA_06.xlsx  # Data files for lectures
├── exercise_guides/
│   ├── exercise_01_guide.Rmd  # Exercise 1 instructions
│   ├── exercise_01_guide.pdf
│   ├── exercise_02_guide.Rmd  # Exercise 2 instructions
│   ├── exercise_02_guide.pdf
│   ├── exercise_03_guide.Rmd  # Exercise 3 instructions
│   ├── exercise_03_guide.pdf
│   ├── exercise_04_guide.Rmd  # Exercise 4 instructions
│   └── exercise_04_guide.pdf
├── img/
│   ├── galton.png
│   ├── ox.png
│   └── voxpopuli.png
├── notes/
│   ├── notes_lecture_01.Rmd   # Detailed notes for Lecture 1
│   ├── notes_lecture_02.Rmd   # Detailed notes for Lecture 2
│   ├── notes_lecture_03.Rmd   # Detailed notes for Lecture 3
│   ├── notes_lecture_04.Rmd   # Detailed notes for Lecture 4
│   ├── notes_lecture_05.Rmd   # Detailed notes for Lecture 5
│   ├── notes_lecture_06.Rmd   # Detailed notes for Lecture 6
│   ├── galton_ox_problem.Rmd  # Special topic notes
│   └── galton_ox_problem.pdf
└── solutions/
    └── solutions_set_chapter1.Rmd  # Additional solution materials
```

## Getting Started

### Prerequisites

- R (>= 4.1.0)
- RStudio (recommended)
- Required R packages:
  - readxl
  - tidyverse

### Installation

1. Clone this repository:
```bash
git clone [repository-url]
```

2. Install required R packages:
```R
install.packages(c("readxl", "tidyverse"))
```

3. Open the project in RStudio:
   - File -> Open Project -> Navigate to the cloned directory

### Usage

1. The `code/` directory contains standalone R scripts that can be run directly
2. The `notes/` directory contains R Markdown files that can be rendered to HTML/PDF for detailed explanations
3. The `exercise_guides/` directory contains instructions for practical exercises
4. The `data/` directory contains Excel files used in the lectures and exercises

## Content Overview

- **Lecture 01-06**: Progressive series covering:
  - Data import and manipulation
  - Different R syntax styles (classic vs pipe syntax)
  - Statistical analysis techniques
  - Linear regression (see lecture_05.R with line functions)
  - Bootstrap methods (see exercise_04_solutions.R)

- **Special Topics**:
  - Galton's Ox problem (see notes/galton_ox_problem.Rmd)

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
