#' Framework7 dialog window
#'
#' \link{f7Dialog} generates a modal window.
#'
#' @param id Input associated to the alert. Works when type is one of
#' "confirm", "prompt" or "login".
#' @param title Dialog title
#' @param text Dialog text.
#' @param type Dialog type: \code{c("alert", "confirm", "prompt", "login")}.
#' @param session shiny session.
#'
#' @export
#'
#' @examples
#' # simple alert
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'   shinyApp(
#'     ui = f7Page(
#'       title = "Simple Dialog",
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "f7Dialog"),
#'         f7Button(inputId = "goButton", "Go!")
#'       )
#'     ),
#'     server = function(input, output, session) {
#'       observeEvent(input$goButton,{
#'         f7Dialog(
#'          title = "Dialog title",
#'          text = "This is an alert dialog"
#'         )
#'       })
#'     }
#'   )
#' }
#' # confirm alert
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shinyApp(
#'    ui = f7Page(
#'      title = "Confirm Dialog",
#'      f7SingleLayout(
#'        navbar = f7Navbar(title = "f7Dialog"),
#'        f7Button(inputId = "goButton", "Go!")
#'      )
#'    ),
#'    server = function(input, output, session) {
#'
#'      observeEvent(input$goButton,{
#'        f7Dialog(
#'          id = "test",
#'          title = "Dialog title",
#'          type = "confirm",
#'          text = "This is an alert dialog"
#'        )
#'      })
#'
#'      observeEvent(input$test, {
#'        f7Toast(text = paste("Alert input is:", input$test))
#'      })
#'
#'    }
#'  )
#' }
#' # prompt dialog
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shinyApp(
#'    ui = f7Page(
#'      title = "Prompt Dialog",
#'      f7SingleLayout(
#'        navbar = f7Navbar(title = "f7Dialog"),
#'        f7Button(inputId = "goButton", "Go!"),
#'        uiOutput("res")
#'      )
#'    ),
#'    server = function(input, output, session) {
#'
#'      observe({
#'        print(input$prompt)
#'      })
#'
#'      observeEvent(input$goButton,{
#'        f7Dialog(
#'          id = "prompt",
#'          title = "Dialog title",
#'          type = "prompt",
#'          text = "This is a prompt dialog"
#'        )
#'      })
#'
#'      output$res <- renderUI(f7BlockTitle(title = input$prompt, size = "large"))
#'    }
#'  )
#' }
#'
#' # login dialog
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shinyApp(
#'    ui = f7Page(
#'      title = "Login Dialog",
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
#'          id = "login",
#'          title = "Dialog title",
#'          type = "login",
#'          text = "This is an login dialog"
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
f7Dialog <- function(id = NULL, title = NULL, text,
                     type = c("alert", "confirm", "prompt", "login"),
                     session = shiny::getDefaultReactiveDomain()) {

  type <- match.arg(type)

  if (is.null(id) && type %in% c("confirm", "prompt", "login")) {
    stop("Missing id.")
  }

  # force to render shiny.tag and convert it to character
  # since text does not accept anything else
  text <- if (class(text) %in% c("shiny.tag" , "shiny.tag.list")) as.character(force(text)) else text

  message <- dropNulls(
    list(
      id = id,
      title = title,
      text = text,
      type = type
    )
  )
  # see my-app.js function
  session$sendCustomMessage(
    type = "dialog",
    message = jsonlite::toJSON(
      message,
      auto_unbox = TRUE,
      json_verbatim = TRUE
    )
  )

}
