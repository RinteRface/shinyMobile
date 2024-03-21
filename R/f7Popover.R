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
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   lorem_ipsum <- "Lorem ipsum dolor sit amet,
#'            consectetur adipiscing elit. Quisque ac diam ac quam euismod
#'            porta vel a nunc. Quisque sodales scelerisque est, at porta
#'            justo cursus ac."
#'
#'   popovers <- data.frame(
#'     id = paste0("target_", 1:10),
#'     content = paste("Popover content", 1:10, lorem_ipsum),
#'     stringsAsFactors = FALSE
#'   )
#'
#'
#'   shinyApp(
#'     ui = f7Page(
#'       options = list(theme = "ios"),
#'       title = "f7Popover",
#'       f7SingleLayout(
#'         navbar = f7Navbar(
#'           title = "f7Popover",
#'           subNavbar = f7SubNavbar(
#'             f7Toggle(
#'               inputId = "toggle",
#'               "Enable popover",
#'               color = "green",
#'               checked = TRUE
#'             )
#'           )
#'         ),
#'         f7Segment(
#'           lapply(seq_len(nrow(popovers)), function(i) {
#'             f7Button(
#'               inputId = sprintf("target_%s", i),
#'               sprintf("Target %s", i)
#'             )
#'           })
#'         )
#'       )
#'     ),
#'     server = function(input, output, session) {
#'       # Enable/disable (don't run first)
#'       observeEvent(input$toggle,
#'         {
#'           lapply(seq_len(nrow(popovers)), function(i) toggleF7Popover(id = popovers[i, "id"]))
#'         },
#'         ignoreInit = TRUE
#'       )
#'
#'       # show
#'       lapply(seq_len(nrow(popovers)), function(i) {
#'         observeEvent(input[[popovers[i, "id"]]], {
#'           addF7Popover(
#'             id = popovers[i, "id"],
#'             options = list(
#'               content = popovers[i, "content"]
#'             )
#'           )
#'         })
#'       })
#'     }
#'   )
#' }
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
#' @param id Popover target id.
#' @param selector jQuery selector. Allow more customization for the target (nested tags).
#' @param session Shiny session object.
#' @export
#' @rdname popover
toggleF7Popover <- function(id = NULL, selector = NULL, session = shiny::getDefaultReactiveDomain()) {
  validateSelector(id, selector)
  if (!is.null(id)) id <- paste0("#", session$ns(id))
  targetEl <- id %OR% selector
  sendCustomMessage("toggle-popover", targetEl, session)
}
