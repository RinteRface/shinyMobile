#' Create a Framework7 dialog window
#'
#' @param inputId Input associated to the alert. Works when type is one of
#' "confirm", "prompt" or "login".
#' @param title Dialog title
#' @param text Dialog text.
#' @param type Dialog type: \code{c("alert", "confirm", "prompt", "login")}.
#' @param session shiny session.
#'
#' @export
#' @examples
#' # simple alert
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
#'          title = "Dialog title",
#'          text = "This is an alert dialog",
#'          session = session
#'         )
#'       })
#'     }
#'   )
#' }
#' # confirm alert
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyF7)
#'  shinyApp(
#'    ui = f7Page(
#'      title = "My App",
#'      f7SingleLayout(
#'        navbar = f7Navbar(title = "f7Dialog"),
#'        f7Button(inputId = "goButton", "Go!")
#'      )
#'    ),
#'    server = function(input, output, session) {
#'
#'      observeEvent(input$goButton,{
#'        f7Dialog(
#'          inputId = "test",
#'          title = "Dialog title",
#'          type = "confirm",
#'          text = "This is an alert dialog",
#'          session = session
#'        )
#'      })
#'
#'      observeEvent(input$test, {
#'        f7Toast(session, text = paste("Alert input is:", input$test))
#'      })
#'
#'    }
#'  )
#' }
#' # login dialog
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyF7)
#'  shinyApp(
#'    ui = f7Page(
#'      title = "My App",
#'      f7SingleLayout(
#'        navbar = f7Navbar(title = "f7Dialog"),
#'        f7Button(inputId = "goButton", "Go!"),
#'        uiOutput("ui")
#'      )
#'    ),
#'    server = function(input, output, session) {
#'
#'      observe({
#'        print(input$login)
#'      })
#'
#'      observeEvent(input$goButton,{
#'        f7Dialog(
#'          inputId = "login",
#'          title = "Dialog title",
#'          type = "login",
#'          text = "This is an login dialog",
#'          session = session
#'        )
#'      })
#'
#'      output$ui <- renderUI({
#'        req(input$login$user == "David" & input$login$password == "prout")
#'        img(src = "https://media2.giphy.com/media/12gfL8Xxrhv7C1fXiV/giphy.gif")
#'      })
#'    }
#'  )
#' }
f7Dialog <- function(inputId = NULL, title = NULL, text,
                     type = c("alert", "confirm", "prompt", "login"), session) {

  type <- match.arg(type)

  message <- dropNulls(
    list(
      id = inputId,
      title = title,
      text = text,
      type = type
    )
  )
  # see my-app.js function
  session$sendCustomMessage(type = "dialog", message = message)

}
