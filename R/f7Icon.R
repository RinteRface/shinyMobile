#' Create a Framework7 icon
#'
#' Build a Framework7 icon
#'
#' @param ... Icon name and \link{f7Badge}.
#' @param lib Library to use: NULL, "ios" or "md".
#' @param fill Whether to fill or not. FALSE by default.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     title = "Icons",
#'     f7Init(theme = "auto"),
#'     f7ListCard(
#'      f7ListCardItem(
#'        title = tagList(
#'         f7Icon("email_fill", lib = "ios"),
#'         "This does not appear for material design devices."
#'        )
#'      ),
#'      f7ListCardItem(
#'        title = f7Icon("home", f7Badge("1", color = "red"))
#'      ),
#'      f7ListCardItem(
#'        title = f7Icon("email", lib = "md")
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
f7Icon <- function(..., lib = NULL, fill = FALSE) {
  if (!is.null(lib)) {
    if (lib == "ios") iconCl <- "icon f7-icons ios-only"
    if (lib == "md") iconCl <- "icon material-icons md-only"
  } else {
    iconCl <- "icon f7-icons"
  }

  if (fill) iconCl <- paste0(iconCl, " icon-fill")

  shiny::tags$i(class = iconCl, ...)
}
