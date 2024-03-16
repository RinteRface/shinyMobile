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


#' Framework7 row container
#'
#' `r lifecycle::badge("deprecated")`
#' \link{f7Grid} is a replacement
#'
#' @param ... Row content.
#' @param gap Whether to display gap between columns. TRUE by default.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @keywords internal
#' @export
f7Row <- function(..., gap = TRUE) {
  lifecycle::deprecate_warn("1.1.0", "f7Row()", "f7Grid()")
  shiny::tags$div(class = if (gap) "row" else "row no-gap", ...)
}

#' Framework7 column container
#'
#' `r lifecycle::badge("deprecated")`
#' \link{f7Grid} is a replacement
#'
#' @param ... Column content. The width is automatically handled depending
#' on the number of columns.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @note The dark theme does not work for items embedded in a column. Use \link{f7Flex}
#' instead.
#'
#' @keywords internal
#' @export
f7Col <- function(...) {
  lifecycle::deprecate_warn("1.1.0", "f7Row()", "f7Grid()")
  shiny::tags$div(class = "col", ...)
}

#' Framework7 flex container
#'
#' `r lifecycle::badge("deprecated")`
#' \link{f7Grid} is a replacement
#'
#' @param ... Items.
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
#' @keywords internal
f7Flex <- function(...) {
  lifecycle::deprecate_warn("1.1.0", "f7Row()", "f7Grid()")
  shiny::tags$div(
    class = "display-flex justify-content-space-between align-items-flex-start",
    ...
  )
}
