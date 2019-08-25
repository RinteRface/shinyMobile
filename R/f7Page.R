#' Create a Framework7 page
#'
#' Build a Framework7 page
#'
#' @param ... Any element.
#' @param init App configuration. See \link{f7Init}.
#' @param title Page title.
#' @param dark_mode Whether to enable the dark mode. FALSE by default.
#' @param preloader Whether to display a preloader before the app starts.
#' FALSE by default.
#' @param loading_duration Preloader duration.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Page <- function(..., init = f7Init(theme = "auto"), title = NULL,
                   dark_mode = FALSE, preloader = FALSE,
                   loading_duration = 3){

  bodyCl <- if (dark_mode)  "theme-dark"

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

      # PAW properties
      shiny::tags$meta(name = "apple-mobile-web-app-capable", content = "yes"),
      shiny::tags$meta(name = "theme-color", content = "#2196f3"),
      shiny::tags$meta(name = "apple-mobile-web-app-status-bar-style", content="black-translucent"),
      shiny::tags$link(rel = "apple-touch-icon", href = "assets/icons/apple-touch-icon.png"),
      shiny::tags$link(rel = "icon", href = "assets/icons/favicon.png"),
      shiny::tags$link(rel = "manifest", href = "/manifest.json"),

      shiny::tags$title(title)
    ),
    # Body
    addCSSDeps(
      shiny::tags$body(
        class = bodyCl,
        # preloader
        onLoad = if (preloader) {
          duration <- loading_duration * 1000
          paste0(
            "$(function() {
             // Preloader
             app.dialog.preloader();
             setTimeout(function () {
              app.dialog.close();
              }, ", duration, ");
            });
            "
          )
        },
        shiny::tags$div(
          id = "app",
          ...
        )
      )
    ),
    # A bits strange but framework7.js codes do not
    # work when placed in the head, as we traditionally do
    # with shinydashboard or bs4Dash. We put them here so.
    addJSDeps(),
    init
  )
}



#' Create a Framework7 single layout
#'
#' Build a Framework7 single layout
#'
#' @param ... Content.
#' @param navbar Slot for \link{f7Navbar}.
#' @param toolbar Slot for \link{f7Toolbar}.
#' @param panels Slot for \link{f7Panel}.
#' Wrap in \link[shiny]{tagList} if multiple panels.
#' @param appbar Slot for \link{f7Appbar}.
#' @param statusbar Slot for \link{f7Statusbar}.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'  shiny::shinyApp(
#'   ui = f7Page(
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
f7SingleLayout <- function(..., navbar, toolbar = NULL,
                           panels = NULL, appbar = NULL,
                           statusbar = f7Statusbar()) {

  shiny::tagList(
    # status bar goes here
    statusbar,
    # appbar goes here
    appbar,
    # panels go here
    panels,
    shiny::tags$div(
      class = "view view-main",
      shiny::tags$div(
        class = "page",
        # top navbar goes here
        navbar,
        # toolbar goes here
        toolbar,
        shiny::tags$div(
          class= "page-content",
          style = "background-color: gainsboro;",
          # page content
          ...
        )
      )
    )
  )
}




#' Create a Framework7 page with tab layout
#'
#' Build a Framework7 page with tab layout
#'
#' @param ... Slot for \link{f7Tabs}.
#' @param navbar Slot for \link{f7Navbar}.
#' @param panels Slot for \link{f7Panel}.
#' Wrap in \link[shiny]{tagList} if multiple panels.
#' @param appbar Slot for \link{f7Appbar}.
#' @param statusbar Slot for \link{f7Statusbar}.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     title = "Tab Layout",
#'     f7TabLayout(
#'       panels = tagList(
#'        f7Panel(title = "Left Panel", side = "left", theme = "light", "Blabla", style = "cover"),
#'        f7Panel(title = "Right Panel", side = "right", theme = "dark", "Blabla", style = "cover")
#'       ),
#'       navbar = f7Navbar(
#'         title = "Tabs",
#'         hairline = FALSE,
#'         shadow = TRUE,
#'         left_panel = TRUE,
#'         right_panel = TRUE
#'       ),
#'       f7Tabs(
#'         animated = TRUE,
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
f7TabLayout <- function(..., navbar, panels = NULL, appbar = NULL, statusbar = f7Statusbar()) {

  shiny::tagList(
    # status bar goes here
    statusbar,
    # appbar goes here
    appbar,
    # panels go here
    panels,
    shiny::tags$div(
      class = "view view-main",
      # the page wrapper is important for tabs
      # to swipe properly. It is not mentionned
      # in the doc. Also necessary to adequately
      # apply the dark mode
      shiny::tags$div(
        class = "page",
        # top navbar goes here
        navbar,
        # f7Tabs go here. The toolbar is
        # automatically generated
        ...
      )
    )
  )
}
