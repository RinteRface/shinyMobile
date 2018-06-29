#' Create a Framework7 page
#'
#' Build a Framework7 page
#'
#' @param ... Any element. They are inserted in a grid. Use the shiny fluidRow function
#' to create a row and insert metroUiCol inside. The maximum with is 12
#' (3 columns or lenght 4, 4 columns of lenght 3, ...).
#' @param title Page title.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(title = "My app"),
#'    server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Page <- function(..., title = NULL){

  shiny::tags$html(
    # Head
    shiny::tags$head(
      shiny::tags$meta(charset = "utf-8"),
      shiny::tags$meta(
        name = "viewport",
        content = "
          width=device-width,
          initial-scale=1,
          maximum-scale=1,
          minimum-scale=1,
          user-scalable=no,
          minimal-ui,
          viewport-fit=cover"
      ),
      shiny::tags$meta(name = "apple-mobile-web-app-capable", content = "yes"),
      shiny::tags$meta(name = "theme-color", content = "#2196f3"),

      shiny::tags$title(title),

      # CSS
      shiny::includeCSS(system.file("css/framework7.min.css", package = "shinyF7")),
      shiny::includeCSS(system.file("css/framework7-icons.css", package = "shinyF7")),
      shiny::includeCSS(system.file("css/my-app.css", package = "shinyF7"))

    ),
    # Body
    shiny::tags$body(
      shiny::tags$div(id = "app", ...),
      # JS
      shiny::includeScript(system.file("js/framework7.min.js", package = "shinyF7")),
      shiny::includeScript(system.file("js/my-app.js", package = "shinyF7"))
    )
  )
}
