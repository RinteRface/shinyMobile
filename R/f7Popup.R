#' Create a f7 popup
#'
#' @param ... Content.
#' @param id Popup unique id.
#' @param label Popup trigger label.
#' @param title Title.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyF7)
#'  shiny::shinyApp(
#'    ui = f7Page(
#'      color = "pink",
#'      title = "My app",
#'      f7SingleLayout(
#'       navbar = f7Navbar(
#'         title = "Single Layout",
#'         hairline = FALSE,
#'         shadow = TRUE
#'       ),
#'       f7Popup(
#'        id = "popup1",
#'        label = "Open",
#'        title = "My first popup",
#'        "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
#'          Quisque ac diam ac quam euismod porta vel a nunc. Quisque sodales
#'          scelerisque est, at porta justo cursus ac"
#'       )
#'      )
#'    ),
#'    server = function(input, output) {}
#'  )
#' }
f7Popup <- function(..., id, label = "Open", title) {

  shiny::tagList(
    shiny::tags$div(
      class = "block",
      # button handler (maybe twick f7Buttons to be able to trigger a popup)
      shiny::a(
        class = "link popup-open",
        href = "#",
        `data-popup` = paste0("#", id),
        label
      )
    ),
    shiny::tags$div(
      class = "popup popup-tablet-fullscreen",
      id = id,
      shiny::br(),
      shiny::br(),
      shiny::p(title),
      shiny::p(shiny::a(class = "link popup-close", href = "#", "Close")),
      shiny::p(...)
    )
  )
}
