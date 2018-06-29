#' Create a Framework7 toolbar/tabbar
#'
#' Build a Framework7 toolbar/tabbar
#'
#' @param ... Slot for f7ToolbarItem.
#' @param bottom Toolbar position. FALSE by default, the toolbar is displayed
#' below the navbar. If TRUE, it is displayed at the bottom of the page.
#' @param hairline Whether to display a thin border on the top of the toolbar. TRUE by default.
#' @param shadow Whether to display a shadow. TRUE by default.
#' @param tabs Whether to use the toolbar with tabs. See f7TabList and f7Tab. FALSE
#' by default.
#' @param labels Whether to use icons instead of text. Only use when tabbar is TRUE.
#' @param scrollable Whether to allow scrolling. FALSE by default.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Toolbar <- function(..., bottom = FALSE, hairline = TRUE, shadow = TRUE,
                      tabs = FALSE, labels = FALSE, scrollable = FALSE) {

  toolbarClass <- "toolbar"
  if (!is.null(bottom)) toolbarClass <- paste0(toolbarClass, " toolbar-bottom-md")
  if (!hairline) toolbarClass <- paste0(toolbarClass, " no-hairline")
  if (!shadow) toolbarClass <- paste0(toolbarClass, " no-shadow")
  if (tabs) toolbarClass <- paste0(toolbarClass, " tabbar")
  if (tabs) {
    if (labels) toolbarClass <- paste0(toolbarClass, " tabbar-labels")
  }
  if (scrollable) toolbarClass <- paste0(toolbarClass, " tabbar-scrollable")

  toolbarTag <- shiny::tags$div(
    class = toolbarClass,
    shiny::tags$div(
      class = "toolbar-inner",
      ...
    )
  )
}



#' Create a Framework7 toolbar/tabbar item
#'
#' Build a Framework7 toolbar/tabbar item
#'
#' @param name Item name.
#' @param href Item link to. Should be related to the unique id of the tab if
#' it is used in a tabbar.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7ToolbarItem <- function(name, href) {
  shiny::tags$a(href = href, class = "link", name)
}
