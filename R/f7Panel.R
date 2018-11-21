#' Create a Framework7 panel
#'
#' Build a Framework7 panel
#'
#' @param ... Panel content.
#' @param side Panel side: "left" or "right".
#' @param theme Panel background color: "dark" or "light".
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Panel <- function(..., side = c("left", "right"), theme = c("dark", "light")) {

  side <- match.arg(side)
  if (side == "right") style <- "cover" else style <- "reveal"
  theme <- match.arg(theme)
  panelCl <- sprintf("panel panel-%s panel-%s", side, style, " theme-%s", theme)

  shiny::tags$div(
    class = panelCl,
    f7Block(...)
  )
}
