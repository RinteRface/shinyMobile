#' Framework7 tooltip
#'
#' \link{f7Tooltip} creates a static tooltip, UI side.
#'
#' @param tag Tooltip target.
#' @param text Tooltip content.
#'
#' @export
#' @rdname tooltip
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shinyApp(
#'    ui = f7Page(
#'      title = "Tooltip",
#'      f7SingleLayout(
#'        navbar = f7Navbar(title = "f7Tooltip"),
#'        f7Tooltip(
#'          f7Badge("Hover on me", color = "pink"),
#'          text = "A tooltip!"
#'        )
#'      )
#'    ),
#'    server = function(input, output, session) {
#'    }
#'  )
#' }
f7Tooltip <- function(tag, text) {
  tag %>% shiny::tagAppendAttributes(
    class = "tooltip-init",
    `data-tooltip` = text
  )
}



#' Add Framework7 tooltip
#'
#' \link{addF7Tooltip} adds a dynamic tooltip to the given target. The tooltip can
#' be modified later.
#'
#' @param id Tooltip target id.
#' @param selector jQuery selector. Allow more customization for the target (nested tags).
#' @param options List of options to pass to the tooltip.
#' See \url{https://v5.framework7.io/docs/tooltip.html#tooltip-parameters}.
#' @param session Shiny session object.
#' @export
#' @rdname tooltip
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  lorem_ipsum <- "Lorem ipsum dolor sit amet!"
#'
#'  tooltips <- data.frame(
#'    id = paste0("target_", 1:2),
#'    text = paste("Tooltip content", 1:2, lorem_ipsum),
#'    stringsAsFactors = FALSE
#'  )
#'
#'
#'  shinyApp(
#'    ui = f7Page(
#'      options = list(theme = "ios"),
#'      title = "f7Tooltip",
#'      f7SingleLayout(
#'        navbar = f7Navbar(
#'          title = "f7Tooltip",
#'          subNavbar = f7SubNavbar(
#'            f7Toggle(
#'              inputId = "toggle",
#'              "Enable tootlips",
#'              color = "green",
#'              checked = TRUE
#'            )
#'          )
#'        ),
#'        f7Segment(
#'          lapply(seq_len(nrow(tooltips)), function(i) {
#'            f7Button(
#'              inputId = sprintf("target_%s", i),
#'              sprintf("Target %s", i)
#'            )
#'          })
#'        ),
#'        f7Text("tooltip_text", "Tooltip new text", placeholder = "Type a text")
#'      )
#'    ),
#'    server = function(input, output, session) {
#'      # Update content
#'      observeEvent(input$tooltip_text, {
#'        lapply(seq_len(nrow(tooltips)), function(i) {
#'          updateF7Tooltip(
#'            id = tooltips[i, "id"],
#'            action = "update",
#'            text = input$tooltip_text
#'          )
#'        })
#'      }, ignoreInit = TRUE)
#'
#'      observeEvent(input$toggle, {
#'        lapply(seq_len(nrow(tooltips)), function(i) {
#'          updateF7Tooltip(id = tooltips[i, "id"], action = "toggle")
#'        })
#'      }, ignoreInit = TRUE)
#'
#'      # Create
#'      lapply(seq_len(nrow(tooltips)), function(i) {
#'        observeEvent(input[[tooltips[i, "id"]]], {
#'          addF7Tooltip(
#'            id = tooltips[i, "id"],
#'            options = list(
#'              text = tooltips[i, "text"]
#'            )
#'          )
#'        })
#'      })
#'    }
#'  )
#' }
addF7Tooltip <- function(id = NULL, selector = NULL, options,
                         session = shiny::getDefaultReactiveDomain()) {
  # We use already defined popover functions
  validatePopoverSelector(id, selector)
  if (!is.null(id)) id <- paste0("#", session$ns(id))
  options$targetEl <- id %OR% selector
  sendPopoverMessage("add_tooltip", options, session)
}




#' Update Framework7 tooltip
#'
#' \link{updateF7Tooltip} updates a tooltip from the server. Either toggle or update the text
#' content.
#'
#' @param id Tooltip target id.
#' @param selector jQuery selector. Allow more customization for the target (nested tags).
#' @param action Either toggle or update the tooltip.
#' @param text New tooltip text value.
#' See \url{https://v5.framework7.io/docs/tooltip.html#tooltip-parameters}.
#' @param session Shiny session object.
#' @export
#' @rdname tooltip
updateF7Tooltip <- function(id = NULL, selector = NULL,
                            action = c("toggle", "update"), text = NULL,
                            session = shiny::getDefaultReactiveDomain()) {
  validatePopoverSelector(id, selector)
  if (!is.null(id)) id <- paste0("#", session$ns(id))
  targetEl <- id %OR% selector
  message <- dropNulls(list(targetEl = targetEl, action = action, text = text))
  sendPopoverMessage("update_tooltip", message, session)
}
