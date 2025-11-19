
# osSurveyLeiden

<!-- badges: start -->
<!-- badges: end -->

🚚 **currently in the process of moving to codeberg:** https://codeberg.org/bbartholdy/os-survey-unileiden

This repository contains the code and data for the dashboard of the Open Science Survey conducted
at Leiden University in 2023 and again in 2025.

## Run locally

To run the dashboard locally you will need:

- [Quarto](https://quarto.org/)
- [R](https://cran.r-project.org/)
- An IDE (optional)

Clone the repository

```sh
git clone git@github.com:bbartholdy/os-survey-unileiden.git
```

Open the project folder, e.g.,

```sh
cd os-survey-leiden
```

Or in your preferred IDE. Load the R dependencies.

```r
renv::restore()
```

Preview (or render) the dashboard on the command line

```sh
quarto preview dashboard.qmd
```

or in your IDE by opening the *dashboard.qmd* file and pressing the render button (e.g., RStudio, or if you have the Quarto extension for Positron or VS Code).

## Licenses

The code is licensed under the [MIT license](LICENSE).

The data (CSV files) in *data/* are licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
