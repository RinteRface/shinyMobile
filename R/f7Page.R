#' Create a Framework7 page
#'
#' Build a Framework7 page
#'
#' @param ... Any element.
#' @param title Page title.
#' @param dark_mode Whether to enable the dark mode. FALSE by default.
#' @param color Color theme: See \url{http://framework7.io/docs/color-themes.html}.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Page <- function(..., title = NULL, dark_mode = FALSE, color = NULL){

  bodyCl <- if (dark_mode) {
    if (!is.null(color)) {
      paste0("theme-dark", " color-theme-", color)
    } else {
      "theme-dark"
    }
    "theme-dark"
  } else {
    if (!is.null(color)) paste0("color-theme-", color)
  }

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
          viewport-fit=cover"
      ),
      shiny::tags$meta(name = "apple-mobile-web-app-capable", content = "yes"),
      shiny::tags$meta(name = "theme-color", content = "#2196f3"),

      shiny::tags$title(title),

      # handle background for dark mode
      # need to remove the custom gainsboro color background
      shiny::tags$script(
        "$(function() {
         var dark_mode = $('body').hasClass('theme-dark');
         if (dark_mode) {
          $('.page-content').css('background-color', '');
          $('.page-content.tab').css('background-color', '');
         }
        });
        "
      ),

      # allow for subnavbar. If a subnavbar if provided in the navbar
      # add a custom class to the page so that the subnavbar is rendered
      shiny::tags$script(
        "$(function() {
         var subnavbar = $('.subnavbar');
         if (subnavbar.length == 1) {
          $('.page').addClass('page-with-subnavbar');
         }
        });
        "
      )


    ),
    # Body
    addDeps(
      shiny::tags$body(
        class = bodyCl,
        shiny::tags$div(
          id = "app",
          #f7Init(theme = "ios"),
          ...
        )
      )
    )
  )
}



#' Create a Framework7 single layout
#'
#' Build a Framework7 single layout
#'
#' @param ... Content.
#' @param navbar Slot for \link{f7Navbar}.
#' @param toolbar Slot for \link{f7Toolbar}.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     f7Init("ios"),
#'     title = "My app",
#'     f7SingleLayout(
#'       navbar = f7Navbar(
#'         title = "Single Layout",
#'         hairline = FALSE,
#'         shadow = TRUE
#'       ),
#'       toolbar = f7Toolbar(
#'         position = "bottom",
#'         f7Link(label = "Link 1", src = "https://www.google.com"),
#'         f7Link(label = "Link 2", src = "https://www.google.com", external = TRUE)
#'       ),
#'       # main content
#'       f7Shadow(
#'         intensity = 10,
#'         hover = TRUE,
#'         f7Card(
#'           title = "Card header",
#'           sliderInput("obs", "Number of observations", 0, 1000, 500),
#'           plotOutput("distPlot"),
#'           footer = tagList(
#'             f7Button(color = "blue", label = "My button", src = "https://www.google.com"),
#'             f7Badge("Badge", color = "green")
#'           )
#'         )
#'       )
#'     )
#'   ),
#'   server = function(input, output) {
#'     output$distPlot <- renderPlot({
#'       dist <- rnorm(input$obs)
#'       hist(dist)
#'     })
#'   }
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7SingleLayout <- function(..., navbar, toolbar = NULL) {
  shiny::tags$div(
    class = "page",
    navbar,
    toolbar,
    # main content
    shiny::tags$div(
      class = "page-content",
      style = "background-color: gainsboro;",
      ...
    )
  )
}




#' Create a Framework7 page with tab layout
#'
#' Build a Framework7 page with tab layout
#'
#' @param ... Slot for \link{f7Tabs} and/or \link{f7Navbar} and/or \link{f7Panel}.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     title = "Tab Layout",
#'     f7Init("ios"),
#'     f7TabLayout(
#'       f7Panel(title = "Left Panel", side = "left", theme = "light", "Blabla", style = "cover"),
#'       f7Panel(title = "Right Panel", side = "right", theme = "dark", "Blabla", style = "cover"),
#'       f7Navbar(
#'         title = "Tabs",
#'         hairline = FALSE,
#'         shadow = TRUE,
#'         left_panel = TRUE,
#'         right_panel = TRUE
#'       ),
#'       f7Tabs(
#'         animated = TRUE,
#'         #swipeable = TRUE,
#'         f7Tab(
#'           tabName = "Tab 1",
#'           icon = f7Icon("email"),
#'           active = TRUE,
#'           f7Shadow(
#'             intensity = 10,
#'             hover = TRUE,
#'             f7Card(
#'               title = "Card header",
#'               sliderInput("obs1", "Number of observations", 0, 1000, 500),
#'               plotOutput("distPlot1"),
#'               footer = tagList(
#'                 f7Button(color = "blue", label = "My button", src = "https://www.google.com"),
#'                 f7Badge("Badge", color = "green")
#'               )
#'             )
#'           )
#'         ),
#'         f7Tab(
#'           tabName = "Tab 2",
#'           icon = f7Icon("today"),
#'           active = FALSE,
#'           f7Shadow(
#'             intensity = 10,
#'             hover = TRUE,
#'             f7Card(
#'               title = "Card header",
#'               sliderInput("obs2", "Number of observations", 0, 10000, 5000),
#'               plotOutput("distPlot2"),
#'               footer = tagList(
#'                 f7Button(color = "blue", label = "My button", src = "https://www.google.com"),
#'                 f7Badge("Badge", color = "green")
#'               )
#'             )
#'           )
#'         ),
#'         f7Tab(
#'           tabName = "Tab 3",
#'           icon = f7Icon("cloud_upload"),
#'           active = FALSE,
#'           f7Shadow(
#'             intensity = 10,
#'             hover = TRUE,
#'             f7Card(
#'               title = "Card header",
#'               sliderInput("obs3", "Number of observations", 0, 10, 5),
#'               plotOutput("distPlot3"),
#'               footer = tagList(
#'                 f7Button(color = "blue", label = "My button", src = "https://www.google.com"),
#'                 f7Badge("Badge", color = "green")
#'               )
#'             )
#'           )
#'         )
#'       )
#'     )
#'   ),
#'   server = function(input, output) {
#'     output$distPlot1 <- renderPlot({
#'       dist <- rnorm(input$obs1)
#'       hist(dist)
#'     })
#'     output$distPlot2 <- renderPlot({
#'       dist <- rnorm(input$obs2)
#'       hist(dist)
#'     })
#'     output$distPlot3 <- renderPlot({
#'       dist <- rnorm(input$obs3)
#'       hist(dist)
#'     })
#'   }
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7TabLayout <- function(...) {
  shiny::tags$div(
    class = "page",
    ...
  )
}
