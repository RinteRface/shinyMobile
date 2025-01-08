#' File Upload Control
#'
#' Create a file upload control that can be used
#' to upload one or more files.
#'
#' @param inputId The input slot that will be used to access the value.
#' @param label Display label for the control, or NULL for no label.
#' @param multiple Whether the user should be allowed to select and
#' upload multiple files at once. Does not work on older browsers, including Internet Explorer 9 and earlier.
#' @param accept A character vector of MIME types; gives the browser a hint of what kind of files the server is expecting.
#' @param width The width of the input, e.g. 400px.
#' @param buttonLabel The label used on the button. Can be text or an HTML tag object.
#' @param placeholder The text to show before a file has been uploaded.
#' @export
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   ui <- f7Page(
#'     f7SingleLayout(
#'       navbar = f7Navbar(title = "File handling"),
#'       f7Block(f7File("up", "Upload!"))
#'     )
#'   )
#'
#'   server <- function(input, output) {
#'     data <- reactive(input$up)
#'     observe(print(data()))
#'   }
#'
#'   shinyApp(ui, server)
#' }
f7File <- function(inputId, label, multiple = FALSE, accept = NULL, width = NULL,
                   buttonLabel = "Browse...", placeholder = "No file selected") {
  restoredValue <- shiny::restoreInput(id = inputId, default = NULL)
  if (!is.null(restoredValue) && !is.data.frame(restoredValue)) {
    warning("Restored value for ", inputId, " has incorrect format.")
    restoredValue <- NULL
  }
  if (!is.null(restoredValue)) {
    restoredValue <- jsonlite::toJSON(restoredValue, strict_atomic = FALSE)
  }
  inputTag <- shiny::tags$input(
    id = inputId, name = inputId, type = "file",
    style = "display: none;", `data-restore` = restoredValue
  )
  if (multiple) {
    inputTag$attribs$multiple <- "multiple"
  }
  if (length(accept) > 0) {
    inputTag$attribs$accept <- paste(accept, collapse = ",")
  }
  shiny::div(
    class = "form-group shiny-input-container",
    style = if (!is.null(width)) {
      paste0("width: ", shiny::validateCssUnit(width), ";")
    },
    shinyInputLabel(
      inputId,
      label
    ),
    shiny::div(
      class = "input-group",
      shiny::tags$label(
        class = "input-group-btn",
        shiny::span(
          class = "button button-fill btn-file",
          buttonLabel,
          inputTag
        )
      ),
      shiny::tags$input(
        type = "text",
        class = "form-control",
        placeholder = placeholder,
        readonly = "readonly"
      )
    ),
    shiny::tags$div(
      id = paste(inputId, "_progress", sep = ""),
      class = "shiny-file-input-progress"
    )
  )
}
