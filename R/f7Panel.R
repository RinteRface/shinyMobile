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
  panelCl <- sprintf("panel panel-%s panel-%s theme-%s", side, style, theme)

  panelTag <- shiny::tags$div(
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

  f7Shadow(panelTag, intensity = 24)

}



# #' Create a Framework7 sidebar menu
# #'
# #' Build a Framework7 sidebar menu
# #'
# #' @param ... Slot for \link{f7PanelItem}.
# #'
# #' @author David Granjon, \email{dgranjon@@ymail.com}
# #'
# #' @export
# f7PanelMenu <- function(...) {
#   shiny::tags$div(
#     class = "list links-list",
#     shiny::tags$ul(...)
#   )
# }
#
#
#
#
# #' Create a Framework7 sidebar menu item
# #'
# #' Build a Framework7 sidebar menu item
# #'
# #' @param id Item id.
# #'
# #' @author David Granjon, \email{dgranjon@@ymail.com}
# #'
# #' @export
# f7PanelItem <- function(id) {
#   shiny::tags$li(
#     shiny::tags$a(
#       href = id,
#       class = "panel-close",
#       `data-view` = ".page"
#     )
#   )
# }

