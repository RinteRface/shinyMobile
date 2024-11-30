#' Framework7 grid container
#'
#' Grid container for elements
#'
#' @param ... Row content.
#' @param cols Columns number. Numeric between 1 and 20.
#' @param gap Whether to display gap between columns. TRUE by default.
#' @param responsiveCl Class for responsive behavior. 
#' The format must be `<SIZE-NCOLS>` such as `<medium-4>`, `<large-3>`.
#' SIZE must be one of \code{c("xsmall", "small", "medium", "large", "xlarge")}.
#' NCOLS has to be between 1 and 20.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' @export
f7Grid <- function(..., cols, gap = TRUE, responsiveCl = NULL) {

  cl <- sprintf("grid grid-cols-%s", cols)
                                                                                  
  if (!is.null(responsiveCl)) {                                                  
    # Format must be: <SIZE-NCOLS> like, <medium-4>, <large-3>
    tmp <- strsplit(responsiveCl, "-")[[1]]
    breakpoint <- tmp[1]
    ncols <- as.numeric(tmp[2])
    stopifnot(
      ncols >= 1 && ncols <= 20,
      breakpoint %in% c("xsmall", "small", "medium", "large", "xlarge")
    )
    cl <- paste(cl, sprintf("%s-grid-cols-%s", breakpoint, ncols))
  }                                                                             
                                                                                
  if (gap) cl <- paste(cl, "grid-gap")

  shiny::tags$div(class = cl, ...)
}
