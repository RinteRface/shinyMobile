#' Create a Framework7 Toolbar
#'
#' Build a Framework7 Toolbar
#'
#' @param ... Slot for \link{f7Link} or any other element.
#' @param position Tabs position: "top" or "bottom".
#' @param hairline Whether to display a thin border on the top of the toolbar. TRUE by default.
#' @param shadow Whether to display a shadow. TRUE by default.
#' @param icons Whether to use icons instead of text. Either ios or md icons.
#' @param scrollable Whether to allow scrolling. FALSE by default.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @note Does not render properly on iOS.
#'
#' @export
f7Toolbar <- function(..., position = c("top", "bottom"), hairline = TRUE, shadow = TRUE,
                      icons = FALSE, scrollable = FALSE) {

   position <- match.arg(position)

   toolbarCl <- if (icons)  "toolbar tabbar" else "toolbar"
   if (!hairline) toolbarCl <- paste0(toolbarCl, " no-hairline")
   if (!shadow) toolbarCl <- paste0(toolbarCl, " no-shadow")
   if (icons) toolbarCl <- paste0(toolbarCl, " tabbar-labels")
   if (scrollable) toolbarCl <- paste0(toolbarCl, " tabbar-scrollable")
   if (position == "bottom") toolbarCl <- paste0(toolbarCl, " toolbar-bottom")

   shiny::tags$div(
      class = toolbarCl,
      shiny::tags$div(
         class = "toolbar-inner",
         ...
      )
   )
}
