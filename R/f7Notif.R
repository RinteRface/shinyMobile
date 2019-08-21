#' Create a Framework7 notification
#'
#' @param text Notification content.
#' @param title Notification title.
#' @param titleRightText Notification right text.
#' @param subtitle Notification subtitle
#' @param closeTimeout Time before notification close.
#' @param closeButton Whether to display a close button.
#' FALSE by default.
#' @param session shiny session.
#'
#' @export
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyF7)
#'   shinyApp(
#'     ui = f7Page(
#'       color = "pink",
#'       title = "My app",
#'       init = f7Init(theme = "ios"),
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "f7Notif"),
#'         f7Button(inputId = "goButton", "Go!")
#'       )
#'     ),
#'     server = function(input, output, session) {
#'       shiny::observeEvent(input$goButton,{
#'         f7Notif(
#'           text = "test",
#'           title = "Notification",
#'           subtitle = "A subtitle",
#'           titleRightText = "now",
#'           session = session
#'         )
#'       })
#'     }
#'   )
#' }
f7Notif <- function(text, title, titleRightText, subtitle = NULL,
                    closeTimeout = 5000, closeButton = TRUE, session) {

  message <- dropNulls(
    list(
      title = title,
      titleRightText = titleRightText,
      subtitle = subtitle,
      text = text,
      closeTimeout = closeTimeout,
      closeButton = tolower(closeButton)
    )
  )
  # see my-app.js function
  session$sendCustomMessage(type = "notif", message = message)

}

