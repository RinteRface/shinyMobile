#' Framework7 swipeout element
#'
#' \code{f7Swipeout} is designed to be used in combination with \link{f7ListItem}.
#'
#' @param tag Tag to be swiped.
#' @param ... `r lifecycle::badge("deprecated")`.
#' @param left When side is "both", put the left \link{f7SwipeoutItem}.
#' @param right When side is "both", put the right \link{f7SwipeoutItem}.
#' @param side `r lifecycle::badge("deprecated")`.
#'
#' @export
#' @rdname swipeout
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   media_item <- function(j) {
#'     f7ListItem(
#'       title = letters[j],
#'       subtitle = "subtitle",
#'       "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
#'             Nulla sagittis tellus ut turpis condimentum, ut dignissim
#'             lacus tincidunt.",
#'       media = tags$img(
#'         src = paste0(
#'           "https://cdn.framework7.io/placeholder/people-160x160-", j, ".jpg"
#'         )
#'       ),
#'       right = "Right Text"
#'     )
#'   }
#'   shinyApp(
#'     ui = f7Page(
#'       title = "Swipeout",
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "Swipeout"),
#'         # simple list
#'         f7List(
#'           mode = "media",
#'           strong = TRUE,
#'           outline = TRUE,
#'           inset = TRUE,
#'           lapply(1:3, function(j) {
#'             if (j == 1) {
#'               f7Swipeout(
#'                 tag = media_item(j),
#'                 left = tagList(
#'                   f7SwipeoutItem(id = "alert", "Alert"),
#'                   f7SwipeoutItem(id = "notification", color = "green", "Notif")
#'                 ),
#'                 right = f7SwipeoutItem(id = "toast", "Click me!")
#'               )
#'             } else {
#'               media_item(j)
#'             }
#'           })
#'         )
#'       )
#'     ),
#'     server = function(input, output, session) {
#'       observe({
#'         print(input$alert)
#'         print(input$notification)
#'       })
#'
#'       observeEvent(input$notification, {
#'         f7Notif(
#'           text = "test",
#'           icon = f7Icon("bolt_fill"),
#'           title = "Notification",
#'           subtitle = "A subtitle",
#'           titleRightText = "now"
#'         )
#'       })
#'
#'       observeEvent(input$alert, {
#'         f7Dialog(
#'           title = "Dialog title",
#'           text = "This is an alert dialog"
#'         )
#'       })
#'
#'       observeEvent(input$toast, {
#'         f7Toast("This is a toast.")
#'       })
#'     }
#'   )
#' }
f7Swipeout <- function(tag, ..., left = NULL, right = NULL, side = deprecated()) {
  if (lifecycle::is_present(side)) {
    lifecycle::deprecate_warn(
      when = "2.0.0",
      what = "f7Swipeout(side)",
      details = "side will be removed in the next release."
    )
  }

  if (length(list(...)) > 0) {
    lifecycle::deprecate_warn(
      when = "2.0.0",
      what = "f7Swipeout()",
      details = "... will be removed in the next release."
    )
  }

  if (length(tag$children) == 0) {
    stop("Swipeout can't be used on an empty tag")
  }

  tag$attribs$class <- "swipeout swiper-no-swiping"
  tag$children[[1]] <- shiny::div(class = "swipeout-content", tag$children[[1]])

  shiny::tagAppendChildren(
    tag,
    shiny::tags$div(class = "swipeout-actions-left", left),
    shiny::tags$div(class = "swipeout-actions-right", right)
  )
}

#' Framework7 swipeout item
#'
#' \code{f7SwipeoutItem} is inserted in \link{f7Swipeout}.
#'
#' @param id  Item unique id.
#' @param label Item label.
#' @param color Item color.
#'
#' @export
#' @rdname swipeout
f7SwipeoutItem <- function(id, label, color = NULL) {
  # Don't remove: needed by JS
  itemCl <- "swipeout-item"
  if (!is.null(color)) itemCl <- paste(itemCl, sprintf("color-%s", color))
  shiny::a(href = "#", label, id = id, class = itemCl)
}
