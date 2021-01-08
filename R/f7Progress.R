#' Framework7 progress bar
#'
#' \link{f7Progress} creates a progress bar.
#'
#' @param id Progress id. Must be unique.
#' @param value Progress value. Between 0 and 100. If NULL the progress bar is infinite.
#' @param color Progress color. See \url{http://framework7.io/docs/progressbar.html}.
#'
#' @rdname progress
#'
#' @examples
#' # Progress bars
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'    ui = f7Page(
#'     title = "Progress",
#'     f7SingleLayout(
#'      navbar = f7Navbar(title = "f7Progress"),
#'      f7Block(f7Progress(id = "pg1", value = 10, color = "pink")),
#'      f7Block(f7Progress(id = "pg2", value = 100, color = "green")),
#'      f7Block(f7Progress(id = "pg3", value = 50, color = "orange"))
#'     )
#'    ),
#'    server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Progress <- function(id, value = NULL, color) {

  if (!is.null(value)) {
    stopifnot(value >= 0, value <= 100)
  }
  progressCl <- "progressbar"
  if (!is.null(color)) progressCl <- paste0(progressCl, " color-", color)

  shiny::tags$div(
    class = progressCl,
    id = id,
    `data-progress` = value,
    shiny::span()
  )
}




#' Update Framework7 progress bar
#'
#' \link{updateF7Progress} update a framework7 progress bar from the server side
#'
#' @param id Unique progress bar id.
#' @param value New value.
#' @param session Shiny session object.
#'
#' @rdname progress
#' @export
#'
#' @examples
#' # Update progress
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'    ui = f7Page(
#'      title = "Update Progress",
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
#'        updateF7Progress(id = "pg1", value = input$obs)
#'      })
#'    }
#'  )
#' }
updateF7Progress <- function(id, value, session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage(
    type = "update-progress",
    message = list(id = id, progress = value)
  )
}
