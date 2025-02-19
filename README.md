# WDDA Lecture Materials

This repository contains R code examples and lecture notes for the WDDA (Web Data and Digital Analytics) course. The materials focus on practical data analysis using R, demonstrating various syntax styles and data manipulation techniques.

## Repository Structure

```
├── code/
│   └── lecture_01.R       # R code examples from Lecture 1
├── notes/
│   └── notes_lecture_01.Rmd   # Detailed notes and explanations
└── data/                  # Data files (not tracked in git)
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
2. The `notes/` directory contains R Markdown files that can be rendered to HTML for detailed explanations
3. Place your data files in the `data/` directory (note: data files are not tracked in git)

## Content Overview

- **Lecture 01**: 
  - Data import from Excel files
  - Different R syntax styles (classic vs pipe syntax)
  - Dataframe navigation and manipulation
  - Working with R's search path (attach/detach)
  - Understanding R object dimensions

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
