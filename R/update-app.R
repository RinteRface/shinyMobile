#' Update Framework7 configuration
#'
#' \code{updateF7App} allows to update a shinyMobile app at run time by
#' injecting any configuration inside the current running instance. Useful it you want
#' to share the same behavior across multiple elements. It can also be used to
#' update the app theme, dark mode, or color.
#'
#' @note This function may be not work with all options and is intended
#' for advanced/expert usage.
#'
#' @param options List of options.
#' @param session Shiny session object.
#'
#' @example inst/examples/update_app/app.R
#'
#' @export
updateF7App <- function(options, session = shiny::getDefaultReactiveDomain()) {
  sendCustomMessage("update-app", options, session)
}

#' Update Framework7 entity
#'
#' \code{updateF7Entity} allows to update any Framework7 instance from the server.
#' For each entity, the list of updatable properties may significantly vary. Please
#' refer to the Framework7 documentation at \url{https://framework7.io/docs/}.
#' Currently, \code{updateF7Entity} supports \link{f7Gauge},
#' \link{f7Swiper}, \link{f7Searchbar},
#' \link{f7PhotoBrowser}, \link{f7Popup} and
#' \link{f7ListView}.
#'
#' @param id Element id.
#' @param options Configuration list. Tightly depends on the entity.
#' See \url{https://framework7.io/docs/}.
#' @param session Shiny session object.
#'
#' @example inst/examples/update_entity/app.R
#'
#' @export
updateF7Entity <- function(id, options, session = shiny::getDefaultReactiveDomain()) {
  # Convert any shiny tag into character so that toJSON does not cry
  listRenderTags <- function(l) {
    lapply(
      X = l,
      function(x) {
        if (inherits(x, c("shiny.tag", "shiny.tag.list"))) {
          as.character(x)
        } else if (inherits(x, "list")) {
          listRenderTags(x)
        } else {
          x
        }
      }
    )
  }
  options <- listRenderTags(options)

  message <- list(id = id, options = options)
  sendCustomMessage("update-entity", message, session)
}
