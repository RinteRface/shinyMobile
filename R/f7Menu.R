#' Create a framework7 menu
#'
#' @param ... Slot for \link{f7MenuItem} or \link{f7MenuDropdown}.
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     title = "My app",
#'     f7SingleLayout(
#'       navbar = f7Navbar(
#'         title = "f7Menu",
#'         hairline = FALSE,
#'         shadow = TRUE
#'       ),
#'       f7Button("toggle", "Toggle menu"),
#'       f7Menu(
#'         f7MenuDropdown(
#'           id = "menu1",
#'           label = "Menu 1",
#'           f7MenuItem(inputId = "item1", "Item 1"),
#'           f7MenuItem(inputId = "item2", "Item 2"),
#'           f7MenuDropdownDivider(),
#'           f7MenuItem(inputId = "item3", "Item 3")
#'         )
#'       )
#'     )
#'   ),
#'   server = function(input, output, session) {
#'     observeEvent(input$toggle, {
#'       f7OpenMenuDropdown("menu1")
#'     })
#'
#'     observeEvent(input$item1, {
#'       f7Notif(text = "Well done!")
#'     })
#'
#'     observe({
#'       print(input$item1)
#'       print(input$menu1)
#'     })
#'   }
#'  )
#' }
f7Menu <- function(...) {
  shiny::tags$div(
    class = "menu",
    shiny::tags$div(
      class = "menu-inner",
      ...
    )
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
#' @param id Dropdown menu id. This is required when once wants to programmatically toggle
#' the dropdown on the server side with \link{f7OpenMenuDropdown}.
#' @param label Button label.
#' @param side Dropdown opening side. Choose among \code{c("left", "center", "right")}.
#' @export
f7MenuDropdown <- function(..., id = NULL, label, side = c("left", "center", "right")) {

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
    id = id,
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



#' Toggle \link{f7MenuDropdown} on the server side
#'
#' @param id Menu to target.
#' @param session Shiny session object.
#' @export
f7OpenMenuDropdown <- function(id, session = shiny::getDefaultReactiveDomain()) {
  session$sendInputMessage(inputId = id, message = NULL)
}
