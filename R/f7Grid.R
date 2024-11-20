#' Framework7 grid container
#'
#' Grid container for elements
#'
#' @param ... Row content.
#' @param cols Columns number. Numeric between 1 and 20.
#' @param gap Whether to display gap between columns. TRUE by default.
#' @param medium_cols Columns number for large screens. Numeric between 1 and 20.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' @export
f7Grid <- function(..., cols, gap = TRUE, medium_cols = NULL) {
  cl <- sprintf("grid grid-cols-%s", cols)
                                                                                  
  if (!is.null(medium_cols)) {                                                  
    cl <- paste(cl, sprintf("medium-grid-cols-%s", medium_cols))                
  }                                                                             
                                                                                
  if (gap) cl <- paste(cl, "grid-gap")
  shiny::tags$div(class = cl, ...)
}
