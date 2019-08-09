#' Create an appbar
#'
#' Build a Framework7 appbar
#'
#' @param ... Any UI content.
#' @export
f7Appbar <- function(...) {
  shiny::tags$div(
    class = "appbar",
    shiny::tags$div(
      class = "appbar-inner",
      ...
    )
  )
}
