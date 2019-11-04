#' Create a Framework7 progress bar
#'
#' Build a Framework7 progress bar
#'
#' @param id Progress id. Must be unique.
#' @param value Progress value. Between 0 and 100.
#' @param color Progress color. See \url{http://framework7.io/docs/progressbar.html}.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'     title = "Progress",
#'     f7SingleLayout(
#'      navbar = f7Navbar(title = "f7Progress"),
#'      f7Block(
#'      f7Progress(id = "pg1", value = 10, color = "pink"),
#'      f7Progress(id = "pg2", value = 100, color = "green"),
#'      f7Progress(id = "pg3", value = 50, color = "orange")
#'     )
#'     )
#'    ),
#'    server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Progress <- function(id, value, color) {

  progressCl <- "progressbar"
  if (!is.null(color)) progressCl <- paste0(progressCl, " color-", color)

  initProgress <- shiny::tags$script(
    shiny::HTML(
      paste0(
        "$(function() {
          app.progressbar.show('#", id, "', ", value, ", '", color, "');
        });
        "
      )
    )
  )

  progressTag <- shiny::tags$div(
    class = progressCl,
    id = id,
    shiny::span()
  )

  shiny::tagList(
    shiny::singleton(shiny::tags$head(initProgress)),
    progressTag
  )

}




#' update a framework7 progress bar from the server side
#'
#' @param session Shiny session object.
#' @param id Unique progress bar id.
#' @param value New value.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'      title = "Progress",
#'      f7SingleLayout(
#'        navbar = f7Navbar(title = "f7Progress"),
#'        f7Block(
#'          f7Progress(id = "pg1", value = 10, color = "blue")
#'        ),
#'        f7Slider(
#'          inputId = "obs",
#'          label = "Progress value",
#'          max = 100,
#'          min = 0,
#'          value = 50,
#'          scale = TRUE
#'        )
#'      )
#'    ),
#'    server = function(input, output, session) {
#'      observeEvent(input$obs, {
#'        updateF7Progress(session, id = "pg1", value = input$obs)
#'      })
#'    }
#'  )
#' }
updateF7Progress <- function(session, id, value) {
  session$sendCustomMessage(type = id, message = value)
}



#' Create a Framework7 infinite progress bar
#'
#' Build a Framework7 infinite progress bar
#'
#' @param color Progress color. See \url{http://framework7.io/docs/progressbar.html}.
#'
#' @note Buggy display when status is not NULL.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'     title = "Progress Infinite",
#'     f7SingleLayout(
#'      navbar = f7Navbar(title = "f7ProgressInf"),
#'      f7Block(
#'      f7ProgressInf(),
#'      f7ProgressInf(color = "yellow")
#'     )
#'     )
#'    ),
#'    server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7ProgressInf <- function(color = NULL) {

  progressCl <- "progressbar-infinite"
  if (!is.null(color)) progressCl <- paste0(progressCl, " color-", color)

  initProgress <- shiny::tags$script(
    shiny::HTML(
      paste0(
        "$(function() {
          determinateLoading = false;
          app.progressbar.show('.progressbar-infinite', '", color, "');
        })
        "
      )
    )
  )

  progressTag <- shiny::tags$div(class = progressCl)

  shiny::tagList(
    shiny::singleton(shiny::tags$head(initProgress)),
    progressTag
  )
}
