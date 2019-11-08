#' Create a Framework7 notification
#'
#' @param text Notification content.
#' @param icon Notification icon.
#' @param title Notification title.
#' @param titleRightText Notification right text.
#' @param subtitle Notification subtitle
#' @param closeTimeout Time before notification closes.
#' @param closeButton Whether to display a close button.
#' FALSE by default.
#' @param closeOnClick Whether to close the notification on click. TRUE by default.
#' @param swipeToClose If enabled, notification can be closed by swipe gesture.
#'
#' @param session shiny session.
#'
#' @export
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'   shinyApp(
#'     ui = f7Page(
#'       color = "pink",
#'       title = "My app",
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "f7Notif"),
#'         f7Button(inputId = "goButton", "Go!")
#'       )
#'     ),
#'     server = function(input, output, session) {
#'       shiny::observeEvent(input$goButton,{
#'         f7Notif(
#'           text = "test",
#'           icon = f7Icon("bolt_fill"),
#'           title = "Notification",
#'           subtitle = "A subtitle",
#'           titleRightText = "now",
#'           session = session
#'         )
#'       })
#'     }
#'   )
#' }
f7Notif <- function(text, icon = NULL, title = NULL, titleRightText = NULL, subtitle = NULL,
                    closeTimeout = 5000, closeButton = FALSE,
                    closeOnClick = TRUE, swipeToClose = TRUE, session) {

  message <- dropNulls(
    list(
      title = title,
      icon = icon,
      titleRightText = titleRightText,
      subtitle = subtitle,
      text = text,
      closeOnClick = tolower(closeOnClick),
      swipeToClose = tolower(swipeToClose),
      closeButton = tolower(closeButton),
      closeTimeout = closeTimeout
    )
  )
  # see my-app.js function
  session$sendCustomMessage(type = "notif", message = message)

}

