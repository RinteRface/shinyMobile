#' Create a framework7 menu
#'
#' @param ... Slot for \link{f7MenuItem} or \link{f7MenuDropown}.
#' @param id Menu id. This is required when once wants to programmatically toggle
#' the menu on the server side with \link{f7ToggleMenu}.
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'
#' }
f7Menu <- function(..., id = NULL) {
  menuTag <- shiny::tags$div(
    class = "menu",
    id = id,
    shiny::tags$div(
      class = "menu-inner",
      ...
    )
  )

  shiny::tagList(
    # javascript initialization
    f7InputsDeps(),
    menuTag
  )
}



#' Create a special action button for \link{f7Menu}.
#'
#' @param inputId Input id.
#' @param label Button label.
#' @export
f7MenuItem <- function(inputId, label) {
  shiny::tags$a(
    class = "menu-item action-button",
    href = "#",
    id = inputId,
    shiny::tags$div(class = "menu-item-content", label)
  )
}



#' Create dropdown menu for \link{f7Menu}.
#'
#' @param ... Slot for \link{f7MenuItem} and \link{f7MenuDropdownDivider}.
#' @param label Button label.
#' @param side Dropdown opening side. Choose among \code{c("left", "center", "right")}.
#' @export
f7MenuDropdown <- function(..., label, side = c("left", "center", "right")) {

  side <- match.arg(side)

  # need to slightly transform f7MenuItem
  items <- lapply(list(...), function(x) {
    # do not target dividers
    if (x$attribs$class != "menu-dropdown-divider") {
      x$attribs$class <- "menu-dropdown-link menu-close action-button"
      x$children <- x$children[[1]]$children[[1]]
    }
    x
  })

  shiny::tags$div(
    class = "menu-item menu-item-dropdown",
    shiny::tags$div(class = "menu-item-content", label),
    shiny::tags$div(
      class = sprintf("menu-dropdown menu-dropdown-%s", side),
      shiny::tags$div(
        class = "menu-dropdown-content",
        style = "max-height: 200px",
        items
      )
    )
  )
}



#' Dropdown divider for \link{f7MenuDropdown}.
#' @export
f7MenuDropdownDivider <- function() {
  shiny::tags$div(class = "menu-dropdown-divider")
}



#' Toggle \link{f7Menu} on the server side
#'
#' @param id Menu to target.
#' @param session Shiny session object.
#' @export
f7ToggleMenu <- function(id, session = shiny::getDefaultReactiveDomain()) {
  session$sendInputMessage(inputId = id, message)
}
