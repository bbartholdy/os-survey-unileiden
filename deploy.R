## Code to deploy the dashboard
rsconnect::setAccountInfo(
  name = Sys.getenv("SHINYAPPS_NAME"),
  token = Sys.getenv("SHINYAPPS_TOKEN"),
  secret = Sys.getenv("SHINYAPPS_SECRET")
)

rsconnect::deployApp(
  appDir = ".",
  appFileManifest = "appFileManifest",
  appPrimaryDoc = "dashboard.qmd",
  appName = "osSurveyLeiden",
  appMode = "quarto-shiny"
)
