#' Util function to validate a given shinyMobile Input
#'
#' @param inputId Input to validate.
#' @param info Additional text to display below the input field.
#' @param pattern Pattern for validation. Regex.
#' @param error Error text.
#' @param session Shiny session object.
#'
#' @export
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'      title = "My app",
#'      f7SingleLayout(
#'        navbar = f7Navbar(title = "f7Text"),
#'        f7Text(
#'          inputId = "caption",
#'          label = "Caption",
#'          value = "Data Summary"
#'        ),
#'        verbatimTextOutput("value"),
#'        hr(),
#'        f7Text(
#'          inputId = "caption2",
#'          label = "Enter a number",
#'          value = 1
#'        )
#'      )
#'    ),
#'    server = function(input, output, session) {
#'      observe({
#'        f7ValidateInput(inputId = "caption", info = "Whatever")
#'        f7ValidateInput(
#'          inputId = "caption2",
#'          pattern = "[0-9]*",
#'          error = "Only numbers please!"
#'        )
#'      })
#'      output$value <- renderPrint({ input$caption })
#'    }
#'  )
#' }
f7ValidateInput <- function(inputId, info = NULL, pattern = NULL, error = NULL,
                            session = shiny::getDefaultReactiveDomain()) {
  message <- dropNulls(
    list(
      target = inputId,
      info = info,
      pattern = pattern,
      error = error
    )
  )
  session$sendCustomMessage(type = "validate", message)
}



