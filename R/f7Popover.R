#' Add Framework7 popover
#'
#' \code{addF7Popover} adds a popover to the given target and show it if enabled
#' by \link{toggleF7Popover}.
#'
#' @param id Popover target id.
#' @param selector jQuery selector. Allow more customization for the target (nested tags).
#' @param options List of options to pass to the popover. See \url{https://framework7.io/docs/popover.html#popover-parameters}.
#' @param session Shiny session object.
#' @export
#' @rdname popover
#' @example inst/examples/popover/app.R
addF7Popover <- function(id = NULL, selector = NULL, options, session = shiny::getDefaultReactiveDomain()) {
  validateSelector(id, selector)
  if (!is.null(id)) id <- paste0("#", session$ns(id))
  options$targetEl <- id %OR% selector
  sendCustomMessage("add-popover", options, session)
}

#' Toggle Framework7 popover
#'
#' \code{toggleF7Popover} toggles the visibility of popover. See example for use case.
#'
#' @export
#' @rdname popover
toggleF7Popover <- function(id = NULL, selector = NULL, session = shiny::getDefaultReactiveDomain()) {
  validateSelector(id, selector)
  if (!is.null(id)) id <- paste0("#", session$ns(id))
  targetEl <- id %OR% selector
  sendCustomMessage("toggle-popover", targetEl, session)
}
