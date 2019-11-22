#' Create a Framework7 pull to refresh event
#'
#' Triggered after scroll down or up
#'
#' @param id Unique ptr id.
#' @param bottom Whether to pull from bottom. FALSE by default.
#' @param closeTimeout Time before the ptr is done.
#' @param session Shiny session object
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyF7)
#'
#' }
f7PullToRefresh <- function(id, bottom = FALSE, closeTimeout = 2000, session) {

  message <- dropNulls(
    list(
      id = id,
      timeout = closeTimeout,
      bottom = tolower(bottom)
    )
  )

  session$sendCustomMessage(type = "pullToRefresh", message)
}
