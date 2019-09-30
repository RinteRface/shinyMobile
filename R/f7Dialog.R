#' Create a Framework7 dialog window
#'
#' @param text Dialog text.
#' @param session shiny session.
#'
#' @export
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyF7)
#'   shinyApp(
#'     ui = f7Page(
#'       title = "My App",
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "f7Dialog"),
#'         f7Button(inputId = "goButton", "Go!")
#'       )
#'     ),
#'     server = function(input, output, session) {
#'       shiny::observeEvent(input$goButton,{
#'         f7Dialog(
#'          text = "This is an alert dialog",
#'          session
#'         )
#'       })
#'     }
#'   )
#' }
f7Dialog <- function(text, session) {

  message <- dropNulls(
    list(
      text = text
    )
  )
  # see my-app.js function
  session$sendCustomMessage(type = "dialog", message = message)

}
