#' Change the value of a checkbox input on the client
#'
#' @param session The session object passed to function given to the server.
#' @param inputId The id of the input object.
#' @param label	The label to set for the input object.
#' @param value The value to set for the input object.
#'
#' @seealso \code{\link{checkboxInput}}
#'
#' @examples
#' ## Only run examples in interactive R sessions
#' if (interactive()) {
#'
#' ui <- f7Page(
#'   f7Init(),
#'   f7Slider(
#'    inputId = "controller",
#'    label = "Number of observations",
#'    max = 10,
#'    min = 0,
#'    value = 1,
#'    step = 1,
#'    scale = TRUE
#'   ),
#'   f7checkBox(
#'    inputId = "check",
#'    label = "Checkbox"
#'   )
#' )
#'
#' server <- function(input, output, session) {
#'   observe({
#'     # TRUE if input$controller is odd, FALSE if even.
#'     x_even <- input$controller %% 2 == 1
#'
#'     if (x_even) {
#'      showNotification(
#'       id = "notif",
#'       paste("The slider is ", input$controller, "and the checkbox is", input$check),
#'       duration = NULL,
#'       type = "warning"
#'      )
#'     } else {
#'      removeNotification("notif")
#'     }
#'
#'     updateF7Checkbox(session, "check", value = x_even)
#'   })
#' }
#'
#' shinyApp(ui, server)
#' }
#' @export
updateF7Checkbox <- function(session, inputId, label = NULL, value = NULL) {
  message <- dropNulls(list(label=label, value=value))
  session$sendInputMessage(inputId, message)
}
