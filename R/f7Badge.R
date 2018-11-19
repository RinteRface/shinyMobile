#' Create a Framework7 badge
#'
#' Build a Framework7 badge
#'
#' @param ... Badge content. Avoid long text.
#' @param color Badge color: see here for valid colors \url{https://framework7.io/docs/badge.html}.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     title = "My app",
#'     f7Badge(32, color = "blue"),
#'     f7Badge("Badge", color = "green")
#'   ),
#'   server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Badge <- function(..., color = NULL) {
  badgeCl <- "badge"
  if (!is.null(color)) badgeCl <- paste0(badgeCl, " color-", color)
  shiny::tags$span(class = badgeCl, ...)
}
