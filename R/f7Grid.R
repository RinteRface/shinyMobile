#' Framework7 grid container
#'
#' Grid container for elements
#'
#' @param ... Row content.
#' @param cols Columns number. Numeric between 1 and 20.
#' @param gap Whether to display gap between columns. TRUE by default.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' @export
f7Grid <- function(..., cols, gap = TRUE) {
  cl <- sprintf("grid grid-cols-%s", cols)
  if (gap) cl <- paste(cl, "grid-gap")
  shiny::tags$div(class = cl, ...)
}
