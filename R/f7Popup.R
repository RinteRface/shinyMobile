#' Create a f7 popup
#'
#' @param ... Content.
#' @param id Popup unique id.
#' @param title Title.
#' @param backdrop Enables Popup backdrop (dark semi transparent layer behind). Default to TRUE.
#' @param closeByBackdropClick When enabled, popup will be closed on backdrop click. Default to TRUE.
#' @param closeOnEscape When enabled, popup will be closed on ESC keyboard key press. Default to FALSE.
#' @param animate Whether the Popup should be opened/closed with animation or not. Default to TRUE.
#' @param swipeToClose Whether the Popup can be closed with swipe gesture. Can be true to allow to close popup with swipes to top and to bottom.
#' Default to FALSE.
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
f7Popup <- function(..., id, title, backdrop = TRUE, closeByBackdropClick = TRUE,
                    closeOnEscape = FALSE, animate = TRUE, swipeToClose = FALSE) {

  popupProps <- dropNulls(
    list(
      class = "popup popup-tablet-fullscreen",
      id = id,
      `data-backdrop` = tolower(backdrop),
      `data-close-by-backdrop-click` = tolower(closeByBackdropClick),
      `data-close-on-escape` = tolower(closeOnEscape),
      `data-animate` = tolower(animate),
      `data-swipe-to-close` = tolower(swipeToClose)
    )
  )

  popupTag <- do.call(shiny::tags$div, popupProps)
  popupWrap <- shiny::tagAppendChildren(
    popupTag,
    f7InputsDeps(),
    shiny::br(),
    shiny::br(),
    shiny::div(
      class = "block",
      shiny::p(title),
      shiny::p(shiny::a(class = "link popup-close", href = "#", "Close")),
      shiny::p(...)
    )
  )

  popupWrap
}



#' Toggle \link{f7Popup}.
#'
#' @param id Popup id.
#' @param session Shiny session.

#' @export
f7TogglePopup <- function(id, session = shiny::getDefaultReactiveDomain()) {
  session$sendInputMessage(id, message = NULL)
}
