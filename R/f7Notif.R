#' Framework7 notification
#'
#' Notification with title, text, icon and more.
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
#' @param ... Other options. See \url{https://framework7.io/docs/notification.html}.
#' @param session shiny session.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'   shinyApp(
#'     ui = f7Page(
#'       title = "My app",
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "f7Notif"),
#'         f7Button(inputId = "goButton", "Go!")
#'       )
#'     ),
#'     server = function(input, output, session) {
#'       observeEvent(input$goButton,{
#'         f7Notif(
#'           text = "test",
#'           icon = f7Icon("bolt_fill"),
#'           title = "Notification",
#'           subtitle = "A subtitle",
#'           titleRightText = "now"
#'         )
#'       })
#'     }
#'   )
#' }
f7Notif <- function(text, icon = NULL, title = NULL, titleRightText = NULL, subtitle = NULL,
                    closeTimeout = 5000, closeButton = FALSE,
                    closeOnClick = TRUE, swipeToClose = TRUE,
                    ..., session = shiny::getDefaultReactiveDomain()) {

  if (!is.null(icon)) icon <- as.character(icon)

  message <- dropNulls(
    list(
      title = title,
      icon = icon,
      titleRightText = titleRightText,
      subtitle = subtitle,
      text = text,
      closeOnClick = closeOnClick,
      swipeToClose = swipeToClose,
      closeButton = closeButton,
      closeTimeout = closeTimeout,
      ...
    )
  )
  # see my-app.js function
  session$sendCustomMessage(
    type = "notif",
    message = jsonlite::toJSON(
      message,
      auto_unbox = TRUE,
      json_verbatim = TRUE
    )
  )

}

