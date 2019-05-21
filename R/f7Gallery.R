#' @title Launch the shinyF7 Gallery
#'
#' @description A gallery of all components available in shinyF7.
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
  if (!requireNamespace(package = "g2r"))
    message("Package 'g2r' is required to run this function")

  shiny::shinyAppFile(
    system.file(
      "examples/gallery/app.R",
      package = 'shinyF7',
      mustWork = TRUE
    )
  )
}
