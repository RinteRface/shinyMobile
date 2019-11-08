#' Create a Framework7 timeline
#'
#' Build a Framework7 timeline
#'
#' @param ... Slot for \link{f7TimelineItem}.
#' @param sides Enable side-by-side timeline mode.
#' @param horizontal Whether to use the horizontal layout. Not compatible with sides.
#' @param calendar Special type of horizontal layout with current year and month.
#' @param year Current year, only if calendar is TRUE.
#' @param month Current month, only if calendar is TRUE.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  items <- tagList(
#'    f7TimelineItem(
#'      "Another text",
#'      date = "01 Dec",
#'      card = FALSE,
#'      time = "12:30",
#'      title = "Title",
#'      subtitle = "Subtitle",
#'      side = "left"
#'    ),
#'    f7TimelineItem(
#'      "Another text",
#'      date = "02 Dec",
#'      card = TRUE,
#'      time = "13:00",
#'      title = "Title",
#'      subtitle = "Subtitle"
#'    ),
#'    f7TimelineItem(
#'      "Another text",
#'      date = "03 Dec",
#'      card = FALSE,
#'      time = "14:45",
#'      title = "Title",
#'      subtitle = "Subtitle"
#'    )
#'  )
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'      title = "Timelines",
#'      f7SingleLayout(
#'        navbar = f7Navbar(title = "Timelines"),
#'        f7BlockTitle(title = "Horizontal timeline", size = "large") %>%
#'        f7Align(side = "center"),
#'        f7Timeline(
#'          sides = FALSE,
#'          horizontal = TRUE,
#'          items
#'        ),
#'        f7BlockTitle(title = "Vertical side by side timeline", size = "large") %>%
#'        f7Align(side = "center"),
#'        f7Timeline(
#'          sides = TRUE,
#'          items
#'        ),
#'        f7BlockTitle(title = "Vertical timeline", size = "large") %>%
#'        f7Align(side = "center"),
#'        f7Timeline(items),
#'        f7BlockTitle(title = "Calendar timeline", size = "large") %>%
#'        f7Align(side = "center"),
#'        f7Timeline(items, calendar = TRUE, year = "2019", month = "November")
#'      )
#'    ),
#'    server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon and Isabelle Rudolf, \email{dgranjon@@ymail.com}
#'
#' @export
f7Timeline <- function(..., sides = FALSE, horizontal = FALSE, calendar = FALSE,
                       year = NULL, month = NULL) {

  if (sides & horizontal) {
    stop("Choose either sides or horizontal. Not compatible together.")
  }

  timelineCl <- "timeline"
  if (sides) timelineCl <- paste0(timelineCl, " timeline-sides")
  if (horizontal) timelineCl <- paste0(timelineCl, " timeline-horizontal col-50 tablet-20")
  if (calendar) timelineCl <- paste0(timelineCl, " timeline-horizontal col-33 tablet-15")


  timelineTag <- shiny::tags$div(
    class = timelineCl,
    ...
  )

  timelineWrapper <- if (calendar) {

    shiny::tags$div(
      class = "timeline-year",
      shiny::tags$div(
        class = "timeline-year-title",
        shiny::span(year)
      ),
      shiny::tags$div(
        class = "timeline-month",
        shiny::tags$div(
          class = "timeline-month-title",
          shiny::span(month)
        ),
        timelineTag
      )
    )
  } else {
    timelineTag
  }

  timelineWrapper

}


#' Create a Framework7 timeline item
#'
#' Build a Framework7 timeline item
#'
#' @param ... Item content, text for instance.
#' @param date Timeline item date. Required.
#' @param card Whether to wrap the content in a card. FALSE by default.
#' @param time Timeline item time. Optional.
#' @param title Timeline item title. Optional.
#' @param subtitle Timeline item subtitle. Optional.
#' @param side Force element to required side: "right" or "left". Only if sides os TRUE in \link{f7Timeline}
#'
#' @author David Granjon and Isabelle Rudolf, \email{dgranjon@@ymail.com}
#'
#' @export
f7TimelineItem <- function(..., date = NULL, card = FALSE, time = NULL,
                          title = NULL, subtitle = NULL, side = NULL) {

  itemCl <- "timeline-item"
  if (!is.null(side)) itemCl <- paste0(itemCl, " timeline-item-", side)

  shiny::tags$div(
    class = itemCl,
    if (!is.null(date)) shiny::tags$div(class = "timeline-item-date", date),
    shiny::tags$div(class = "timeline-item-divider"),
    shiny::tags$div(
      class = "timeline-item-content",
      if (card) {
        shiny::tags$div(
          class = "timeline-item-inner",
          if (!is.null(time)) shiny::tags$div(class = "timeline-item-time", time),
          if (!is.null(title)) shiny::tags$div(class = "timeline-item-title", title),
          if (!is.null(subtitle)) shiny::tags$div(class = "timeline-item-subtitle", subtitle),
          if (!is.null(...)) shiny::tags$div(class = "timeline-item-text", ...)
        )
      } else {
        shiny::tagList(
          if (!is.null(time)) shiny::tags$div(class = "timeline-item-time", time),
          if (!is.null(title)) shiny::tags$div(class = "timeline-item-title", title),
          if (!is.null(subtitle)) shiny::tags$div(class = "timeline-item-subtitle", subtitle),
          if (!is.null(...)) shiny::tags$div(class = "timeline-item-text", ...)
        )
      }
    )
  )
}



