#' Create a Framework 7 appbar
#'
#' Displayed on top of \link{f7Navbar}. Interestingly, \link{f7Appbar} can also
#' trigger \link{f7Panel}.
#'
#' @param ... Any UI content.
#' @param left_panel Whether to enable the left panel. FALSE by default.
#' @param right_panel Whether to enable the right panel. FALSE by default.
#' @export
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyF7)
#'
#'  cities <- names(precip)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'      title = "My app",
#'      init = f7Init(theme = "ios"),
#'      f7Appbar(
#'        left_panel = TRUE,
#'        right_panel = TRUE,
#'        f7Searchbar(id = "search1", inline = TRUE)
#'      ),
#'      f7SingleLayout(
#'        navbar = f7Navbar(
#'          title = "f7Searchbar",
#'          hairline = FALSE,
#'          shadow = TRUE
#'        ),
#'        panels = tagList(
#'          f7Panel(title = "Left Panel", side = "left", theme = "light", "Blabla", style = "cover"),
#'          f7Panel(title = "Right Panel", side = "right", theme = "dark", "Blabla", style = "cover")
#'        ),
#'        f7List(
#'          lapply(seq_along(cities), function(i) {
#'            f7ListItem(cities[i])
#'          })
#'        ) %>% f7Found()
#'      )
#'    ),
#'    server = function(input, output) {}
#'  )
#' }
f7Appbar <- function(..., left_panel = FALSE, right_panel = FALSE) {

  panelToggle <- if (left_panel | right_panel) {
    shiny::tags$a(
      href = "#",
      class = "button button-small panel-toggle display-flex",
      `data-panel` = NA,
      f7Icon("bars")
    )
  }

  setPanelToggle <- function(item, side) {
    item$attribs$`data-panel` <- side
    return(item)
  }

  shiny::tags$div(
    class = "appbar",
    shiny::tags$div(
      class = "appbar-inner",
      if (left_panel) {
        shiny::tags$div(
          class = "left",
          setPanelToggle(panelToggle, "left")
        )
      },
      ...,
      if (right_panel) {
        shiny::tags$div(
          class = "right",
          setPanelToggle(panelToggle, "right")
        )
      }
    )
  )
}
