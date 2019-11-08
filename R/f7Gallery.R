#' @title Launch the shinyMobile Gallery
#'
#' @description A gallery of all components available in shinyMobile.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'
#'  f7Gallery()
#'
#' }
f7Gallery <- function() { # nocov start
  if (!requireNamespace(package = "shiny"))
    message("Package 'shiny' is required to run this function")
  if (!requireNamespace(package = "plotly"))
    message("Package 'plotly' is required to run this function")

  shiny::shinyAppFile(
    system.file(
      "examples/gallery/app.R",
      package = 'shinyMobile',
      mustWork = TRUE
    )
  )
}
