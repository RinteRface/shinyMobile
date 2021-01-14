#' Framework7 swipeout element
#'
#' \link{f7Swipeout} is designed to be used in combination with \link{f7ListItem}.
#'
#' @param tag Tag to be swiped.
#' @param ... When side is either "right" or "left" use this slot to pass
#' \link{f7SwipeoutItem}.
#' @param left When side is "both", put the left \link{f7SwipeoutItem}.
#' @param right When side is "both", put the right \link{f7SwipeoutItem}.
#' @param side On which side to swipe: "left", "right" or "both".
#'
#' @export
#' @rdname swipeout
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'    ui = f7Page(
#'      title = "Swipeout",
#'      f7SingleLayout(
#'        navbar = f7Navbar(title = "Swipeout"),
#'        # simple list
#'        f7List(
#'          lapply(1:3, function(j) {
#'            if (j == 1) {
#'              f7Swipeout(
#'                tag = f7ListItem(letters[j]),
#'                side = "left",
#'                f7SwipeoutItem(id = "alert", color = "pink", "Alert"),
#'                f7SwipeoutItem(id = "notification", color = "green", "Notif")
#'              )
#'            } else {
#'              f7ListItem(letters[j])
#'            }
#'          })
#'        )
#'      )
#'    ),
#'    server = function(input, output, session) {
#'      observe({
#'        print(input$alert)
#'        print(input$notification)
#'      })
#'
#'      observeEvent(input$notification, {
#'        f7Notif(
#'          text = "test",
#'          icon = f7Icon("bolt_fill"),
#'          title = "Notification",
#'          subtitle = "A subtitle",
#'          titleRightText = "now"
#'        )
#'      })
#'
#'      observeEvent(input$alert, {
#'        f7Dialog(
#'          title = "Dialog title",
#'          text = "This is an alert dialog"
#'        )
#'      })
#'
#'    }
#'  )
#' }
f7Swipeout <- function(tag, ...,left = NULL, right = NULL, side = c("left", "right", "both")) {

  side <- match.arg(side)

  swipeoutTag <- if (side != "both") {
    swipeoutCl <- paste0("swipeout-actions-", side)
    shiny::tags$div(class = swipeoutCl, ...)
  } else {
    shiny::tagList(
      shiny::tags$div(class = "swipeout-actions-left", left),
      shiny::tags$div(class = "swipeout-actions-right", right)
    )
  }

  tag$attribs$class <- "swipeout swiper-no-swiping"
  tag$children[[1]] <- shiny::div(class = "swipeout-content", tag$children[[1]])
  shiny::tagAppendChild(tag, swipeoutTag)
}



#' Framework7 swipeout item
#'
#' \link{f7SwipeoutItem} is inserted in \link{f7Swipeout}.
#'
#' @param id  Item unique id.
#' @param label Item label.
#' @param color Item color.
#'
#' @export
#' @rdname swipeout
f7SwipeoutItem <- function(id, label, color = NULL) {

  itemCl <- "swipeout-item"
  if (!is.null(color)) itemCl <- paste0(itemCl, " color-", color)

  shiny::a(href = "#", label, id = id, class = itemCl)
}
