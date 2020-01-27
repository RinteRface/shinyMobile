#' Create a Framework7 icon
#'
#' Build a Framework7 icon
#'
#' @param ... Icon name and \link{f7Badge}.
#' @param lib Library to use: NULL, "ios" or "md". Leave NULL by default. Specify, md or ios
#' if you want to hide/show icons on specific devices.
#' @param color Icon color, if any.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     title = "Icons",
#'     init = f7Init(theme = "light", skin = "ios"),
#'     f7SingleLayout(
#'      navbar = f7Navbar(title = "icons"),
#'      f7List(
#'       f7ListItem(
#'         title = tagList(
#'          f7Icon("email")
#'         )
#'       ),
#'       f7ListItem(
#'         title = tagList(
#'          f7Icon("email_fill", color = "green")
#'         )
#'       ),
#'       f7ListItem(
#'         title = f7Icon("home", f7Badge("1", color = "red"))
#'       ),
#'       f7ListItem(
#'         title = f7Icon("email_fill", lib = "md"),
#'         "This will not appear since only for material design"
#'       )
#'      )
#'     )
#'   ),
#'   server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Icon <- function(..., lib = NULL, color = NULL) {
  if (!is.null(lib)) {
    if (lib == "ios") iconCl <- "icon f7-icons ios-only"
    if (lib == "md") iconCl <- "icon material-icons md-only"
  } else {
    # class icon is necessary so that icons with labels render well,
    # for instance
    iconCl <- "icon f7-icons"
  }

  if (!is.null(color)) iconCl <- paste0(iconCl, " color-", color)

  shiny::tags$i(class = iconCl, ...)
}
