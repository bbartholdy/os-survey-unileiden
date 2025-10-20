## Script will not run as it requires a Qualtrics access token ##

# Load the httr2 library
library(qualtRics)
library(dplyr)

# Retrieve survey --------------------------------------------------------

qualtrics_api_credentials(
  api_key = Sys.getenv("QUALTRICS_TOKEN"),
  base_url = "fra1.qualtrics.com"
)

responses_raw <- fetch_survey(
  surveyID = Sys.getenv("QUALTRICS_SURVEY"),
  include_display_order = FALSE
)

# Data cleaning ----------------------------------------------------------

responses_raw$wave <- 2025

# Only create the 2025_questions.csv file if it doesn't exist
if(!file.exists("data/2025_questions.csv")) {
  questions <- survey_questions(surveyID = Sys.getenv("QUALTRICS_SURVEY"))
  questions <- questions |>
    mutate(
      question = qualtRics:::remove_html(question),
      options = NA
    )

# extract the response options and collapse to a single line
  options <- extract_colmap(responses_raw) |>
    mutate(options = stringi::stri_extract(description, regex = "(?<=Selected\\sChoice\\s-\\s).*")) |>
    group_by(ImportId) |>
    mutate(options = paste0(options, collapse = ";")) |>
    ungroup() |>
    distinct(ImportId, .keep_all = TRUE) |>
    select(!qname) |>
    right_join(questions, c("ImportId" = "qid")) |>
    select(qname, question, options)

  readr::write_csv(options, "data/2025_questions.csv")
}

half_full <- responses_raw |>
  mutate(
    Progress = as.numeric(Progress),
    Duration = as.numeric(`Duration (in seconds)`)
  ) |>
  mutate(across(
    where(is.character),
    ~ stringi::stri_replace(., regex = "^Other, namely:.*", "Other")
  )) |>
  filter(
    Q29 == "Yes (continue to questions)", # include only consenting respondents
    Progress > 50 # include only surveys 50%+ completed
  ) |>
  select(!c(StartDate, EndDate, Status, RecordedDate, DistributionChannel, UserLanguage, Q29, `Duration (in seconds)`, email_interview)) # deselect columns that aren't needed

readr::write_csv(half_full, here::here("data/2025_responses-wide.csv"))
