#' Framework7 tooltip
#'
#' \link{f7Tooltip} creates a tooltip, UI side.
#'
#' @param tag Tooltip target.
#' @param text Tooltip content.
#'
#' @export
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
