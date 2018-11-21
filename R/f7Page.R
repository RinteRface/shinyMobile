#' Create a Framework7 page
#'
#' Build a Framework7 page
#'
#' @param ... Any element. They are inserted in a grid. Use the shiny fluidRow function
#' to create a row and insert metroUiCol inside. The maximum with is 12
#' (3 columns or lenght 4, 4 columns of lenght 3, ...).
#' @param title Page title.
#' @param navbar Slot for \link{f7Navbar}.
#' @param navbarHideScroll Whether to hide the navbar on scroll. FALSE by default.
#' @param dark_mode Whether to enable the dark mode. FALSE by default.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(title = "My app"),
#'    server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Page <- function(..., title = NULL, navbar = NULL, navbarHideScroll = FALSE, dark_mode = FALSE){

  shiny::tags$html(
    # Head
    shiny::tags$head(
      shiny::tags$meta(charset = "utf-8"),
      shiny::tags$meta(
        name = "viewport",
        content = "
          width=device-width,
          initial-scale=1,
          maximum-scale=1,
          minimum-scale=1,
          user-scalable=no,
          minimal-ui,
          viewport-fit=cover"
      ),
      shiny::tags$meta(name = "apple-mobile-web-app-capable", content = "yes"),
      shiny::tags$meta(name = "theme-color", content = "#2196f3"),

      shiny::tags$title(title),
      shiny::includeCSS(path = "https://fonts.googleapis.com/icon?family=Material+Icons")
    ),
    # Body
    addDeps(
      shiny::tags$body(
        class = if (dark_mode) "theme-dark" else NULL,
        shiny::tags$div(
          id = "app",
          # panels
          shiny::tags$div(
            class = "view view-main view-init",
            #shiny::tags$div(
            #  class = "page page-current",
            #  `data-name` = "home",
              # navbar
              # toolbar
              # main content
              shiny::tags$div(
                class = if (navbarHideScroll) {
                  "page-content hide-navbar-on-scroll"
                } else {
                  "page-content"
                },
                ...
              )
            #)
          )
        )
      )
    )
  )
}




#' Create a Framework7 page with tabbar layout
#'
#' Build a Framework7 page with tabbar layout
#'
#' @param ... Slot for \link{f7Tabs} and/or \link{f7Navbar}.
#' @param title Page title.
#' @param dark_mode Whether to enable the dark mode. FALSE by default.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'    ui = f7TabbarLayout(
#'     title = "My app",
#'     f7Tabs(
#'      f7Tab(
#'       tabName = "Tab 1",
#'       icon = NULL,
#'       active = TRUE,
#'       f7Badge(1, color = "blue")
#'      ),
#'      f7Tab(
#'       tabName = "Tab 2",
#'       icon = NULL,
#'       active = FALSE,
#'       f7Badge(2, color = "green")
#'      ),
#'      f7Tab(
#'       tabName = "Tab 3",
#'       icon = NULL,
#'       active = FALSE,
#'       f7Badge(3, color = "orange")
#'      )
#'     )
#'    ),
#'    server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7TabLayout <- function(..., title = NULL, dark_mode = FALSE) {
  shiny::tags$html(
    # Head
    shiny::tags$head(
      shiny::tags$meta(charset = "utf-8"),
      shiny::tags$meta(
        name = "viewport",
        content = "
          width=device-width,
          initial-scale=1,
          maximum-scale=1,
          minimum-scale=1,
          user-scalable=no,
          minimal-ui,
          viewport-fit=cover"
      ),
      shiny::tags$meta(name = "apple-mobile-web-app-capable", content = "yes"),
      shiny::tags$meta(name = "theme-color", content = "#2196f3"),

      shiny::tags$title(title),
      shiny::includeCSS(path = "https://fonts.googleapis.com/icon?family=Material+Icons")
    ),
    # Body
    addDeps(
      shiny::tags$body(
        class = if (dark_mode) "theme-dark" else NULL,
        shiny::tags$div(
          id = "app",
          shiny::tags$div(
            class = "page",
            ...
          )
        )
      )
    )
  )
}
