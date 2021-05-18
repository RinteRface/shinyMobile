#' Framework7 menu container
#'
#' \code{f7Menu} is a container for \link{f7MenuItem} and/or \link{f7MenuDropdown}.
#'
#' @param ... Slot for \link{f7MenuItem} or \link{f7MenuDropdown}.
#' @export
#' @rdname menu
#'
#' @examples
#' # Menu container
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shinyApp(
#'   ui = f7Page(
#'     title = "Menus",
#'     f7SingleLayout(
#'       navbar = f7Navbar(
#'         title = "f7Menu",
#'         hairline = FALSE,
#'         shadow = TRUE
#'       ),
#'       f7Button(inputId = "toggle", label = "Toggle menu"),
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
#'       updateF7MenuDropdown("menu1")
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



#' Framework7 menu item
#'
#' \code{f7MenuItem} creates a special action button for \link{f7Menu}.
#'
#' @rdname menu
#' @param inputId Menu item input id.
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



#' Framework7 dropdown menu
#'
#' \code{f7MenuDropdown} creates a dropdown menu for \link{f7Menu}.
#'
#' @param ... Slot for \link{f7MenuItem} and \link{f7MenuDropdownDivider}.
#' @param id Dropdown menu id. This is required when once wants to programmatically toggle
#' the dropdown on the server side with \link{updateF7MenuDropdown}.
#' @param label Button label.
#' @param side Dropdown opening side. Choose among \code{c("left", "center", "right")}.
#' @rdname menu
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



#' Framework7 dropdown menu divider
#'
#' \code{f7MenuDropdownDivider} creates a dropdown divider for \link{f7MenuDropdown}.
#'
#' @rdname menu
#' @export
f7MenuDropdownDivider <- function() {
  shiny::tags$div(class = "menu-dropdown-divider")
}



#' Update Framework7 menu
#'
#' \code{updateF7MenuDropdown} toggles \link{f7MenuDropdown} on the client.
#'
#' @param id Menu to target.
#' @param session Shiny session object.
#' @rdname menu
#' @export
updateF7MenuDropdown <- function(id, session = shiny::getDefaultReactiveDomain()) {
  session$sendInputMessage(inputId = id, message = NULL)
}
