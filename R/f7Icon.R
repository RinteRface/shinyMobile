#' @title Framework7 icons
#'
#' @description Use Framework7 icons in shiny applications,
#'  see complete list of icons here : \url{https://framework7.io/icons/}.
#'
#' @param ... Icon name and \link{f7Badge}.
#' @param lib Library to use: NULL, "ios" or "md". Leave \code{NULL} by default. Specify, md or ios
#'  if you want to hide/show icons on specific devices.
#' @param color Icon color, if any.
#' @param style CSS styles to be applied on icon, for example
#'  use \code{font-size: 56px;} to have a bigger icon.
#' @param old Deprecated. This was to handle old and new icons but shinyMobile only uses
#' new icons from now. This parameter will be removed in a future release.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'   ui = f7Page(
#'     title = "Icons",
#'     f7SingleLayout(
#'      navbar = f7Navbar(title = "icons"),
#'      f7List(
#'       f7ListItem(
#'         title = tagList(
#'          f7Icon("envelope")
#'         )
#'       ),
#'       f7ListItem(
#'         title = tagList(
#'          f7Icon("envelope_fill", color = "green")
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
f7Icon <- function(..., lib = NULL, color = NULL, style = NULL, old = NULL) {
  call_ <- as.list(match.call())
  if (!is.null(call_$old)) {
    warning(
      "Deprecated. This was to handle old and new icons. ",
      "This parameter will be removed in a future release."
    )
  }
  if (!is.null(lib)) {
    if (identical(lib, "ios")) {
      iconCl <- "icon f7-icons ios-only"
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

  iconTag <- add_f7icons_dependencies(shiny::tags$i(class = iconCl, style = style, ...))
  htmltools::browsable(iconTag)
}

