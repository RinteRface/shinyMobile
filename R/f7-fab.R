#' Create a Framework7 container for fast action button (FAB)
#'
#' Build a Framework7 container for fast action button (FAB)
#'
#' @param ... Slot for \link{f7Fab}.
#' @param position Container position.
#' @param color Container color.
#' @param sideOpen When the container is pressed, indicate where buttons are displayed.
#'
#' @note hideOnScroll does not work yet.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     color = "pink",
#'     title = "My app",
#'     f7Fabs(
#'       position = "center-top",
#'       color = "yellow",
#'       sideOpen = "right",
#'       lapply(1:4, function(i) f7Fab(paste0("btn", i), i))
#'     ),
#'     lapply(1:4, function(i) verbatimTextOutput(paste0("res", i))),
#'
#'     f7Fabs(
#'       position = "center-center",
#'       color = "purple",
#'       sideOpen = "center",
#'       lapply(5:8, function(i) f7Fab(paste0("btn", i), i))
#'     ),
#'     lapply(5:8, function(i) verbatimTextOutput(paste0("res", i))),
#'
#'     f7Fabs(
#'       position = "left-bottom",
#'       color = "pink",
#'       sideOpen = "top",
#'       lapply(9:12, function(i) f7Fab(paste0("btn", i), i))
#'     )
#'
#'   ),
#'   server = function(input, output) {
#'     lapply(1:12, function(i) {
#'       output[[paste0("res", i)]] <- renderPrint(input[[paste0("btn", i)]])
#'     })
#'   }
#'  )
#' }
#'
#' @export
f7Fabs <- function(..., position = c(
  "right-top",
  "right-center",
  "right-bottom",
  "left-top",
  "left-center",
  "left-bottom",
  "center-right",
  "center-center",
  "center-left",
  "center-top",
  "center-bottom"
), color = NULL,
                       sideOpen = c("left", "right", "top", "bottom", "center")) {

  position <- match.arg(position)
  fabCl <- paste0("fab fab-", position, if(!is.null(color)) " color-", color)

  sideOpen <- match.arg(sideOpen)

  shiny::tags$div(
    class = fabCl,
    style = "background-color: gainsboro;",
    shiny::a(
      href = "#",
      shiny::tags$i(class="icon f7-icons", "add"),
      shiny::tags$i(class="icon f7-icons", "close")
    ),
    shiny::tags$div(class = paste0("fab-buttons fab-buttons-", sideOpen), ...)
  )
}




#' Create a Framework7 fast action button (FAB)
#'
#' Build a Framework7 fast action button (FAB)
#'
#' @inheritParams shiny::actionButton
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Fab <- function(inputId, label, width = NULL, ...) {
  value <- shiny::restoreInput(id = inputId, default = NULL)
  shiny::tags$a(id = inputId, style = if (!is.null(width))
    paste0("width: ", shiny::validateCssUnit(width), ";"),
    type = "button",
    class = "btn btn-default action-button",
    `data-val` = value,
    list(label, ...))
}
