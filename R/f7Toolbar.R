#' Create a Framework7 Toolbar
#'
#' Build a Framework7 Toolbar
#'
#' @param ... Slot for \link{f7Link} or any other element.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Toolbar <- function(...) {
 shiny::tags$div(
   class = "toolbar",
   shiny::tags$div(
     class = "toolbar-inner",
     ...
   )
 )
}
