#' @title Create a f7 popup
#'
#' @description Popup is a popup window with any UI content that pops up over App's main content.
#'  Popup as all other overlays is part of so called "Temporary Views".
#'
#' @param ... UI elements for the body of the popup window.
#' @param id Popup unique id.
#' @param title Title for the popup window, use \code{NULL} for no title.
#' @param backdrop Enables Popup backdrop (dark semi transparent layer behind).
#'  Default to \code{TRUE}.
#' @param closeByBackdropClick When enabled, popup will be closed on backdrop click.
#'  Default to \code{TRUE}.
#' @param closeOnEscape When enabled, popup will be closed on ESC keyboard key press.
#'  Default to \code{FALSE}.
#' @param animate Whether the Popup should be opened/closed with animation or not.
#'  Default to \code{TRUE}.
#' @param swipeToClose Whether the Popup can be closed with swipe gesture.
#'  Can be true to allow to close popup with swipes to top and to bottom.
#'  Default to \code{FALSE}.
#' @param fullsize Open popup in full width or not. Default to \code{FALSE}.
#' @param closeButton Add or not a button to easily close the popup.
#'  Default to \code{TRUE}.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shiny::shinyApp(
#'    ui = f7Page(
#'      color = "pink",
#'      title = "My app",
#'      f7SingleLayout(
#'       navbar = f7Navbar(
#'         title = "f7Popup",
#'         hairline = FALSE,
#'         shadow = TRUE
#'       ),
#'       f7Button("togglePopup", "Toggle Popup"),
#'       f7Popup(
#'        id = "popup1",
#'        title = "My first popup",
#'        f7Text("text", "Popup content", "This is my first popup ever, I swear!"),
#'        verbatimTextOutput("popupContent")
#'       )
#'      )
#'    ),
#'    server = function(input, output, session) {
#'
#'     output$popupContent <- renderPrint(input$text)
#'
#'     observeEvent(input$togglePopup, {
#'      f7TogglePopup(id = "popup1")
#'     })
#'
#'     observeEvent(input$popup1, {
#'
#'      popupStatus <- if (input$popup1) "opened" else "closed"
#'
#'      f7Toast(
#'       session,
#'       position = "top",
#'       text = paste("Popup is", popupStatus)
#'      )
#'     })
#'    }
#'  )
#' }
f7Popup <- function(..., id, title = NULL,
                    backdrop = TRUE,
                    closeByBackdropClick = TRUE,
                    closeOnEscape = FALSE,
                    animate = TRUE,
                    swipeToClose = FALSE,
                    fullsize = FALSE,
                    closeButton = TRUE) {

  config <- dropNulls(list(
    backdrop = backdrop,
    closeByBackdropClick = closeByBackdropClick,
    closeOnEscape = closeOnEscape,
    animate = animate,
    swipeToClose = swipeToClose
  ))

  content <- shiny::tags$div(
    class = "block",
    if (!is.null(title)) shiny::tags$div(class = "block-title", title),
    ...
  )

  if (isTRUE(closeButton)) {
    content <- htmltools::tagAppendChild(
      content,
      shiny::tags$a(
        class = "link popup-close",
        style = "position: absolute; top: -15px; right: 10px;",
        href = "#",
        f7Icon("close")
      )
    )
  }

  shiny::tags$div(
    id = id,
    class = "popup",
    class = if (isTRUE(fullsize)) "popup-tablet-fullscreen",
    style = "overflow-y: auto;",
    f7InputsDeps(),
    content,
    shiny::tags$script(
      type = "application/json",
      `data-for` = id,
      jsonlite::toJSON(
        x = config,
        auto_unbox = TRUE,
        json_verbatim = TRUE
      )
    )
  )
}



#' Toggle \link{f7Popup}.
#'
#' @param id Popup id.
#' @param session Shiny session.

#' @export
f7TogglePopup <- function(id, session = shiny::getDefaultReactiveDomain()) {
  session$sendInputMessage(id, message = NULL)
}
