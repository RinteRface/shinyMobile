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
#' @example inst/examples/validateinput/app.R
#'
#' @rdname validation
#'
#' @export
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
