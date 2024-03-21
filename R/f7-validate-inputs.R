#' Framework7 input validation
#'
#' \code{validateF7Input} is a function to validate a given shinyMobile input.
#'
#' @param inputId Input to validate.
#' @param info Additional text to display below the input field.
#' @param pattern Pattern for validation. Regex.
#' @param error Error text.
#' @param session Shiny session object.
#'
#' @note Only works for \link{f7Text}, \link{f7Password}, \link{f7TextArea} and \link{f7Select}.
#' See more at \url{https://framework7.io/docs/inputs.html}.
#'
#' @export
#' @rdname validation
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   shinyApp(
#'     ui = f7Page(
#'       title = "Validate inputs",
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "validateF7Input"),
#'         f7Text(
#'           inputId = "caption",
#'           label = "Caption",
#'           value = "Data Summary"
#'         ),
#'         verbatimTextOutput("value"),
#'         hr(),
#'         f7Text(
#'           inputId = "caption2",
#'           label = "Enter a number",
#'           value = 1
#'         )
#'       )
#'     ),
#'     server = function(input, output, session) {
#'       observe({
#'         validateF7Input(inputId = "caption", info = "Whatever")
#'         validateF7Input(
#'           inputId = "caption2",
#'           pattern = "[0-9]*",
#'           error = "Only numbers please!"
#'         )
#'       })
#'       output$value <- renderPrint({
#'         input$caption
#'       })
#'     }
#'   )
#' }
validateF7Input <- function(inputId, info = NULL, pattern = NULL, error = NULL,
                            session = shiny::getDefaultReactiveDomain()) {
  message <- dropNulls(
    list(
      target = inputId,
      info = info,
      pattern = pattern,
      error = error
    )
  )
  session$sendCustomMessage(type = "validate-input", message)
}
