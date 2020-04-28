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
#' @param old Use \code{TRUE} for old icons, default is \code{TRUE},
#'  but in a future version of shinyMobile default will be \code{FALSE}.
#'
#' @examples
#'
#' f7Icon("close", old = TRUE)
#' f7Icon("multiply", old = FALSE)
#'
#' # Icon size
#' f7Icon("multiply", style = "font-size: 56px;", old = FALSE)
#'
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
#'          f7Icon("envelope", old = FALSE)
#'         )
#'       ),
#'       f7ListItem(
#'         title = tagList(
#'          f7Icon("envelope_fill", color = "green", old = FALSE)
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
f7Icon <- function(..., lib = NULL, color = NULL, style = NULL, old = TRUE) {
  call_ <- as.list(match.call())
  if (is.null(call_$old)) {
    warning(
      "In a future version of shinyMobile, default for ",
      "old argument will be FALSE, to continue to use old icons ",
      "specify explicitly old = TRUE."
    )
  }
  if (!is.null(lib)) {
    if (identical(lib, "ios")) {
      if (isTRUE(old)) {
        iconCl <- "icon f7-icons-old ios-only"
      } else {
        iconCl <- "icon f7-icons ios-only"
      }
    }
    if (identical(lib, "md")) {
      iconCl <- "icon material-icons md-only"
    }
  } else {
    # class icon is necessary so that icons with labels render well,
    # for instance
    if (isTRUE(old)) {
      iconCl <- "icon f7-icons-old"
    } else {
      iconCl <- "icon f7-icons"
    }
  }

  if (!is.null(color)) {
    iconCl <- paste0(iconCl, " color-", color)
  }

  iconTag <- htmltools::attachDependencies(
    x = shiny::tags$i(class = iconCl, style = style, ...),
    value = html_dependencies_f7Icons(old = old)
  )
  htmltools::browsable(iconTag)
}

