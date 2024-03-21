#' Framework7 Toolbar
#'
#' \code{f7Toolbar} is a layout element located at the bottom or top. It is
#' internally used by \link{f7Tabs} and can be used in the toolbar slot of
#' \link{f7Page}.
#'
#' @param ... Slot for \link{f7Link} or any other element.
#' @param position Tabs position: "top" or "bottom". Or use different positions for iOS, MD themes
#'  by using: "top-ios", "top-md", "bottom-ios", or "bottom-md".
#' @param hairline `r lifecycle::badge("deprecated")`:
#' removed from Framework7.
#' @param shadow `r lifecycle::badge("deprecated")`:
#' removed from Framework7.
#' @param icons Whether to use icons instead of text. Either ios or md icons.
#' @param scrollable Whether to allow scrolling. FALSE by default.
#'
#' @example inst/examples/toolbar/app.R
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Toolbar <- function(..., position = c("top", "bottom"), hairline = deprecated(), shadow = deprecated(),
                      icons = FALSE, scrollable = FALSE) {
  if (lifecycle::is_present(hairline)) {
    lifecycle::deprecate_warn(
      when = "1.1.0",
      what = "f7Toolbar(hairline)",
      details = "hairline has been
      removed from Framework7 and will be removed from shinyMobile
      in the next release."
    )
  }

  if (lifecycle::is_present(shadow)) {
    lifecycle::deprecate_warn(
      when = "1.1.0",
      what = "f7Toolbar(shadow)",
      details = "shadow has been
      removed from Framework7 and will be removed from shinyMobile
      in the next release."
    )
  }

  position <- match.arg(position)

  toolbarCl <- if (icons) "toolbar tabbar tabbar-icons" else "toolbar"
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
