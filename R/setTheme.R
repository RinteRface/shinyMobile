#' Custom theme setup
#'
#' @param theme App theme: "ios", "md", "auto".
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
setTheme <- function(theme = c("ios", "md", "auto")) {
  theme <- match.arg(theme)
  #shiny::singleton(
    shiny::tags$head(
      shiny::tags$script(paste0("$(document).ready(function() { app.theme.set(", theme, "); });"))
    )
  #)
}
