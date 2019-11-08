#' Create a framework7 swipeout element
#'
#' To be used in combination with \link{f7ListItem}
#'
#' @param tag Tag to be swiped.
#' @param ... When side is either "right" or "left" use this slot to pass
#' \link{f7SwipeoutItem}.
#' @param left When side is "both", put the left \link{f7SwipeoutItem}.
#' @param right When side is "both", put the right \link{f7SwipeoutItem}.
#' @param side On which side to swipe: "left", "right" or "both".
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'      title = "My app",
#'      f7SingleLayout(
#'        navbar = f7Navbar(title = "f7List"),
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
#'          titleRightText = "now",
#'          session = session
#'        )
#'      })
#'
#'      observeEvent(input$alert, {
#'        f7Dialog(
#'          title = "Dialog title",
#'          text = "This is an alert dialog",
#'          session = session
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

  tag$attribs$class <- "swipeout"
  tag$children[[1]] <- shiny::div(class = "swipeout-content", tag$children[[1]])
  shiny::tagAppendChild(tag, swipeoutTag)
}



#' Create a framework7 swipeout item
#'
#' Insert in \link{f7Swipeout}
#'
#' @param id  Item unique id.
#' @param label Item label.
#' @param color Item color.
#'
#' @export
f7SwipeoutItem <- function(id, label, color = NULL) {

  itemCl <- if (!is.null(color)) paste0("color-", color)

  shiny::tagList(
    shiny::singleton(
      shiny::tags$head(
        shiny::tags$script(
          paste0(
            "$(function(){
              // reset value of the previous swipe on opening animation
              $('.swipeout').on('swipeout:open', function() {
                Shiny.setInputValue('", id, "', null);
              });
              // once clicked on the action button inside the swipout
              // set the input value to TRUE
              $('#", id, "').on('click', function() {
               Shiny.setInputValue('", id, "', true);
               // close the swipeout element
               app.swipeout.close('.swipeout');
              });
            });
            "
          )
        )
      )
    ),
    shiny::a(href = "#", label, id = id, class = itemCl)
  )
}
