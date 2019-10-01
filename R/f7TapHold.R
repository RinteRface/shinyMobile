#' Create a Framework7 tapHold event
#'
#' Triggered after long press on an element.
#'
#' @param target Element to apply the tapHold event on. Must be a jQuery selector,
#' such as "#id" or ".class", ".class1, .class2", "a"...
#' @param callback. Javascript callback. Must be wrapped in \link{I}.
#' @param session Shiny session object.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#' library(shiny)
#' library(shinyF7)
#'
#'  shinyApp(
#'    ui = f7Page(
#'      title = "My app",
#'      f7SingleLayout(
#'        navbar = f7Navbar(title = "f7TapHold"),
#'        f7Button(inputId = "pressme", label = "Press me")
#'      )
#'    ),
#'    server = function(input, output, session) {
#'     observeEvent(input$pressme,{
#'       f7TapHold(
#'        target = "#pressme",
#'        callback = I("app.dialog.alert('Tap hold fired!');"),
#'        session = session
#'       )
#'     })
#'    }
#'  )
#' }
f7TapHold <- function(target, callback, session) {

  message <- dropNulls(
    list(
      target = target,
      callback = callback
    )
  )

  session$sendCustomMessage(type = "tap-hold", message)
}
