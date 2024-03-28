#' @title Framework7 icons
#'
#' @description Use Framework7 icons in shiny applications,
#'  see complete list of icons here : \url{https://framework7.io/icons/}.
#'
#' @param ... Icon name and \link{f7Badge}.
#' @param lib Library to use: NULL, "ios" or "md".
#' Leave \code{NULL} by default. Specify, md or ios
#'  if you want to hide/show icons on specific devices. If you choose
#' "md" be sure to include the corresponding fonts
#' as they are not provided by shinyMobile. You can get them
#' at \url{https://github.com/marella/material-icons/}.
#' @param color Icon color, if any.
#' @param style CSS styles to be applied on icon, for example
#'  use \code{font-size: 56px;} to have a bigger icon.
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   shinyApp(
#'     ui = f7Page(
#'       title = "Icons",
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "icons"),
#'         f7List(
#'           f7ListItem(
#'             title = tagList(
#'               f7Icon("envelope")
#'             )
#'           ),
#'           f7ListItem(
#'             title = tagList(
#'               f7Icon("envelope_fill", color = "green")
#'             )
#'           ),
#'           f7ListItem(
#'             title = f7Icon("house", f7Badge("1", color = "red"))
#'           ),
#'           f7ListItem(
#'             title = f7Icon("home", lib = "md"),
#'             "Only for material design"
#'           )
#'         )
#'       )
#'     ),
#'     server = function(input, output) {}
#'   )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Icon <- function(..., lib = NULL, color = NULL, style = NULL) {
  if (!is.null(lib)) {
    if (identical(lib, "ios")) {
      iconCl <- "icon f7-icons if-not-md"
    }
    if (identical(lib, "md")) {
      iconCl <- "icon material-icons md-only"
    }
  } else {
    # class icon is necessary so that icons with labels render well,
    # for instance
    iconCl <- "icon f7-icons"
  }

  if (!is.null(color)) {
    iconCl <- paste0(iconCl, " color-", color)
  }

  iconTag <- shiny::tags$i(class = iconCl, style = style, ...)
  htmltools::browsable(iconTag)
}
