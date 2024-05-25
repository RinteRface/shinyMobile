#' Create a download button
#'
#' Use these functions to create a download button;
#' when clicked, it will initiate a browser download. The
#' filename and contents are specified by the corresponding
#' shiny downloadHandler() defined in the server function.
#'
#' @param outputId The name of the output slot that the downloadHandler is assigned to.
#' @param label The label that should appear on the button.
#' @param class Additional CSS classes to apply to the tag, if any.
#' @param ... Other arguments to pass to the container tag function.
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  ui = f7Page(
#'   f7SingleLayout(
#'     navbar = f7Navbar(title = "File handling"),
#'     f7Block(f7DownloadButton("download","Download!"))
#'   )
#'  )
#'
#'  server = function(input, output, session) {
#'    # Our dataset
#'    data <- mtcars
#'
#'    output$download = downloadHandler(
#'      filename = function() {
#'        paste("data-", Sys.Date(), ".csv", sep="")
#'      },
#'      content = function(file) {
#'        write.csv(data, file)
#'      }
#'    )
#'  }
#'
#'  shinyApp(ui, server)
#' }
f7DownloadButton <- function (outputId, label = "Download", class = NULL, ...) {
  tag <- shiny::tags$a(
    id = outputId,
    class = "button button-fill external shiny-download-link",
    href = "", target = "_blank",
    download = NA,
    shiny::icon("download"),
    label, ...
  )

  if (!is.null(class)) {
    tagAppendAttributes(
      tag,
      class = class
    )
  } else {
    tag
  }
}


