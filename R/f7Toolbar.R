#' Framework7 Toolbar
#'
#' \code{f7Toolbar} is a layout element located at the bottom or top. It is
#' internally used by \link{f7Tabs}.
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
#' @export
f7Toolbar <- function(..., position = c("top", "bottom"), hairline = TRUE, shadow = TRUE,
                      icons = FALSE, scrollable = FALSE) {

   position <- match.arg(position)

   toolbarCl <- if (icons)  "toolbar tabbar tabbar-labels" else "toolbar"
   if (!hairline) toolbarCl <- paste0(toolbarCl, " no-hairline")
   if (!shadow) toolbarCl <- paste0(toolbarCl, " no-shadow")
   if (scrollable) toolbarCl <- paste0(toolbarCl, " tabbar-scrollable")
   toolbarCl <- paste0(toolbarCl, " toolbar-", position)

   shiny::tags$div(
      class = toolbarCl,
      shiny::tags$div(
         class = "toolbar-inner",
         ...
      )
   )
}
