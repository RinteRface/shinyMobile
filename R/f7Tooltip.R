#' Framework7 tooltip
#'
#' \code{f7Tooltip} creates a static tooltip, UI side.
#'
#' @param tag Tooltip target.
#' @param text Tooltip content.
#'
#' @example inst/examples/tooltip/app.R
#'
#' @export
#' @rdname tooltip

f7Tooltip <- function(tag, text) {
  tag %>% shiny::tagAppendAttributes(
    class = "tooltip-init",
    `data-tooltip` = text
  )
}



#' Add Framework7 tooltip
#'
#' \code{addF7Tooltip} adds a dynamic tooltip to the given target. The tooltip can
#' be modified later.
#'
#' @param id Tooltip target id.
#' @param selector jQuery selector. Allow more customization for the target (nested tags).
#' @param options List of options to pass to the tooltip.
#' See \url{https://v5.framework7.io/docs/tooltip.html#tooltip-parameters}.
#' @param session Shiny session object.
#' @export
#' @rdname tooltip
#' @example inst/examples/tooltip/app.R

addF7Tooltip <- function(id = NULL, selector = NULL, options,
                         session = shiny::getDefaultReactiveDomain()) {
  # We use already defined popover functions
  validateSelector(id, selector)
  if (!is.null(id)) id <- paste0("#", session$ns(id))
  options$targetEl <- id %OR% selector
  sendCustomMessage("add_tooltip", options, session)
}




#' Update Framework7 tooltip
#'
#' \code{updateF7Tooltip} updates a tooltip from the server. Either toggle or update the text
#' content.
#'
#' @param id Tooltip target id.
#' @param selector jQuery selector. Allow more customization for the target (nested tags).
#' @param action Either toggle or update the tooltip.
#' @param text New tooltip text value.
#' See \url{https://framework7.io/docs/tooltip#tooltip-parameters}.
#' @param session Shiny session object.
#' @export
#' @rdname tooltip
updateF7Tooltip <- function(id = NULL, selector = NULL,
                            action = c("toggle", "update"), text = NULL,
                            session = shiny::getDefaultReactiveDomain()) {
  validateSelector(id, selector)
  if (!is.null(id)) id <- paste0("#", session$ns(id))
  targetEl <- id %OR% selector
  message <- dropNulls(list(targetEl = targetEl, action = action, text = text))
  sendCustomMessage("update_tooltip", message, session)
}
