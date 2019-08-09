#' Create a Framework7 timeline
#'
#' Build a Framework7 timeline
#'
#' @param ... Slot for \link{f7TimelineItem}.
#' @param sides Enable side-by-side timeline mode.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     title = "Timelines",
#'     f7Timeline(
#'      sides = TRUE,
#'      f7TimelineItem(
#'      "Another text",
#'       date = "01 Dec",
#'       card = FALSE,
#'       time = "12:30",
#'       title = "Title",
#'       subtitle = "Subtitle",
#'       side = "left"
#'       ),
#'       f7TimelineItem(
#'       "Another text",
#'       date = "02 Dec",
#'       card = TRUE,
#'       time = "13:00",
#'       title = "Title",
#'       subtitle = "Subtitle"
#'       ),
#'       f7TimelineItem(
#'       "Another text",
#'       date = "03 Dec",
#'       card = FALSE,
#'       time = "14:45",
#'       title = "Title",
#'       subtitle = "Subtitle"
#'       )
#'      )
#'   ),
#'   server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon and Isabelle Rudolf, \email{dgranjon@@ymail.com}
#'
#' @export
f7Timeline <- function(..., sides = FALSE) {

  timelineCl <- "timeline"
  if (sides) timelineCl <- paste0(class = timelineCl, " timeline-sides")

  shiny::tags$div(
    class = timelineCl,
    ...
  )
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



