#' Framework7 tapHold module
#'
#' \link{f7TapHold} is triggered after long press on an element, from the server.
#'
#' @param target Element to apply the tapHold event on. Must be a jQuery selector,
#' such as "#id" or ".class", ".class1, .class2", "a"...
#' @param callback Javascript callback.
#' @param session Shiny session object.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#' library(shiny)
#' library(shinyMobile)
#'
#'  shinyApp(
#'    ui = f7Page(
#'      title = "Taphold",
#'      f7SingleLayout(
#'        navbar = f7Navbar(title = "f7TapHold"),
#'        f7Button(inputId = "pressme", label = "Press me")
#'      )
#'    ),
#'    server = function(input, output, session) {
#'     observe({
#'       f7TapHold(
#'        target = "#pressme",
#'        callback = "app.dialog.alert('Tap hold fired!');"
#'       )
#'     })
#'    }
#'  )
#' }
f7TapHold <- function(target, callback, session = shiny::getDefaultReactiveDomain()) {

  message <- dropNulls(
    list(
      target = target,
      callback = callback
    )
  )

  session$sendCustomMessage(type = "tapHold", message)
}
