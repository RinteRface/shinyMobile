#' Create a Framework7 panel
#'
#' Build a Framework7 panel
#'
#' @param ... Panel content.
#' @param title Panel title.
#' @param side Panel side: "left" or "right".
#' @param theme Panel background color: "dark" or "light".
#' @param style Whether the panel should behave when opened: "cover" or "reveal".
#'
#' @note When style is "reveal", makes the app freeze.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Panel <- function(..., title = NULL, side = c("left", "right"), theme = c("dark", "light"),
                    style = c("reveal", "cover")) {

  side <- match.arg(side)
  style <- match.arg(style)
  theme <- match.arg(theme)
  panelCl <- sprintf("panel panel-%s panel-%s", side, style, " theme-%s", theme)

  shiny::tags$div(
    class = panelCl,
    shiny::tags$div(
      class = "view",
      shiny::tags$div(
        class = "page",
        # Panel Header
        shiny::tags$div(
          class = "navbar",
          shiny::tags$div(
            class = "navbar-inner",
            shiny::tags$div(class = "title", title)
          )
        ),
        # Panel content
        shiny::tags$div(
          class = "page-content",
          f7Block(...)
        )
      )
    )
  )
}
