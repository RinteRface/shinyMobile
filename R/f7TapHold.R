#' Framework7 tapHold module
#'
#' Framework7 has a so called "tap hold" event. If tapHold is enabled in \link{f7Page}, it triggers
#' after a sustained, complete touch event. \link{f7TapHold} is triggered from the server.
#'
#' @param target Element to apply the tapHold event on. Must be a jQuery selector,
#' such as "#id" or ".class", ".class1, .class2", "a"...
#' @param callback Javascript callback.
#' @param session Shiny session object.
#'
#' @example inst/examples/tapHold/app.R
#'
#' @export

f7TapHold <- function(target, callback, session = shiny::getDefaultReactiveDomain()) {

  message <- dropNulls(
    list(
      target = target,
      callback = callback
    )
  )

  session$sendCustomMessage(type = "tapHold", message)
}
