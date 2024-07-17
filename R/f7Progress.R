#' Framework7 progress bar
#'
#' \code{f7Progress} creates a progress bar.
#'
#' @param id Progress id. Must be unique.
#' @param value Progress value. Between 0 and 100.
#' If NULL the progress bar is infinite.
#' @param color Progress color.
#' See \url{https://framework7.io/docs/progressbar.html}.
#'
#' @rdname progress
#'
#' @example inst/examples/progress/app.R
#' @export
f7Progress <- function(id, value = NULL, color) {
  if (!is.null(value)) {
    stopifnot(value >= 0, value <= 100)
  }
  progressCl <- "progressbar"
  if (is.null(value)) progressCl <- paste0(progressCl, "-infinite")
  if (!is.null(color)) progressCl <- paste0(progressCl, " color-", color)

  shiny::tags$div(
    class = progressCl,
    id = id,
    `data-progress` = value,
    shiny::span()
  )
}

#' Update Framework7 progress bar
#'
#' \code{updateF7Progress} update a framework7 progress bar from the server side
#'
#' @param session Shiny session object.
#'
#' @rdname progress
#' @export
updateF7Progress <- function(id, value, session = shiny::getDefaultReactiveDomain()) {
  session$sendCustomMessage(
    type = "update-progress",
    message = list(id = id, progress = value)
  )
}
