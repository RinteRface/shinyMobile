#' Create a Framework7 page
#'
#' Build a Framework7 page
#'
#' @param ... Any element.
#' @param title Page title.
#' @param dark_mode Whether to enable the dark mode. FALSE by default.
#' @param color Color theme: See \url{http://framework7.io/docs/color-themes.html}.
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
        class = bodyCl,
        style = "background-color: gainsboro;",
        shiny::tags$div(
          id = "app",
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
#' @param navbarHideScroll Whether to hide the navbar on scroll. FALSE by default.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     setTheme("ios"),
#'     title = "My app",
#'     f7SingleLayout(
#'       navbar = f7Navbar(
#'         title = "Single Layout",
#'         hairline = FALSE,
#'         shadow = TRUE
#'       ),
#'       toolbar = f7Toolbar(
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
#'             f7Button(color = "blue", "My button", src = "https://www.google.com"),
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
f7SingleLayout <- function(..., navbar, toolbar, navbarHideScroll = FALSE) {
  shiny::tags$div(
    class = "view view-main ios-edges",
    navbar,
    toolbar,
    # main content
    shiny::tags$div(
      class = if (navbarHideScroll) {
        "page-content hide-navbar-on-scroll"
      } else {
        "page-content"
      },
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
#'     title = "My app",
#'     f7TabLayout(
#'       setTheme("ios"),
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
#'         icons = TRUE,
#'         animated = TRUE,
#'         position = "bottom",
#'         #swipeable = TRUE,
#'         f7Tab(
#'           tabName = "Tab 1",
#'           icon = "email",
#'           active = TRUE,
#'           f7Shadow(
#'             intensity = 10,
#'             hover = TRUE,
#'             f7Card(
#'               title = "Card header",
#'               sliderInput("obs1", "Number of observations", 0, 1000, 500),
#'               plotOutput("distPlot1"),
#'               footer = tagList(
#'                 f7Button(color = "blue", "My button", src = "https://www.google.com"),
#'                 f7Badge("Badge", color = "green")
#'               )
#'             )
#'           )
#'         ),
#'         f7Tab(
#'           tabName = "Tab 2",
#'           icon = "today",
#'           active = FALSE,
#'           f7Shadow(
#'             intensity = 10,
#'             hover = TRUE,
#'             f7Card(
#'               title = "Card header",
#'               sliderInput("obs2", "Number of observations", 0, 10000, 5000),
#'               plotOutput("distPlot2"),
#'               footer = tagList(
#'                 f7Button(color = "blue", "My button", src = "https://www.google.com"),
#'                 f7Badge("Badge", color = "green")
#'               )
#'             )
#'           )
#'         ),
#'         f7Tab(
#'           tabName = "Tab 3",
#'           icon = "file_upload",
#'           active = FALSE,
#'           f7Shadow(
#'             intensity = 10,
#'             hover = TRUE,
#'             f7Card(
#'               title = "Card header",
#'               sliderInput("obs3", "Number of observations", 0, 10, 5),
#'               plotOutput("distPlot3"),
#'               footer = tagList(
#'                 f7Button(color = "blue", "My button", src = "https://www.google.com"),
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
    style="background-color: gainsboro;",
    #shiny::tags$div(class = "panel-backdrop", style = NA),
    ...
  )
}



#' Create a Framework7 page with split layout
#'
#' Build a Framework7 page with split layout
#'
#' @param sidebarPanel Slot for \link{f7Sidebar}.
#' @param mainPanel Slot for \link{f7mainPanel}.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     setTheme("ios"),
#'     title = "My app",
#'     f7SidebarLayout(
#'       # sidebar content
#'       sidebarPanel = f7Sidebar(
#'         title = "Sidebar",
#'         side = "left",
#'         theme = "light",
#'         sliderInput("obs", "Number of observations", 0, 1000, 500)
#'       ),
#'       # main content
#'       mainPanel = f7mainPanel(
#'         navbar = f7Navbar(
#'           title = "Sidebar Layout",
#'           hairline = FALSE,
#'           shadow = TRUE
#'         ),
#'         toolbar = f7Toolbar(
#'           f7Link(label = "Link 1", src = "https://www.google.com"),
#'           f7Link(label = "Link 2", src = "https://www.google.com", external = TRUE)
#'         ),
#'         f7Shadow(
#'           intensity = 10,
#'           hover = TRUE,
#'           f7Card(
#'             title = "Card header",
#'             plotOutput("distPlot"),
#'             footer = tagList(
#'               f7Button(color = "blue", "My button", src = "https://www.google.com"),
#'               f7Badge("Badge", color = "green")
#'             )
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
f7SidebarLayout <- function(sidebarPanel, mainPanel) {

  # need to set a left margin between the sidebar and the main content
  mainPanel <- htmltools::tagAppendAttributes(
    mainPanel,
    style = "margin-left: 260px;"
  )

  # set margin inside
  mainPanel$children[[3]] <- f7Margin(mainPanel$children[[3]])

  # set elevation on sidebar and put margin for the content
  sidebarPanel <- f7Shadow(sidebarPanel, intensity = 24)

  shiny::tagList(sidebarPanel, mainPanel)
}



#' Create a Framework7 main panel container
#'
#' Build a Framework7 main panel container
#'
#' @inheritParams f7SingleLayout
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7mainPanel <- f7SingleLayout




#' Create a Framework7 sidebar
#'
#' Build a Framework7 sidebar
#'
#' @param ... Panel content.
#' @param title Panel title.
#' @param side Panel side: "left" or "right".
#' @param theme Panel background color: "dark" or "light".
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Sidebar <- function(..., title = NULL, side = c("left", "right"),
                      theme = c("dark", "light")) {

  sidebarCl <- "panel panel-left panel-reveal panel-visible-by-breakpoint"
  side <- match.arg(side)
  theme <- match.arg(theme)
  sidebarCl <- sprintf(sidebarCl, " panel-%s", side, " theme-%s", theme)


  sidebarTag <- shiny::tags$div(
    class = sidebarCl,
    shiny::tags$div(
      class = "view view-left",
      shiny::tags$div(
        class = "page",
        # Panel Header
        f7Shadow(
          shiny::tags$div(
            class = "navbar",
            shiny::tags$div(
              class = "navbar-inner sliding",
              shiny::tags$div(class = "title", title)
            )
          ),
          intensity = 24
        ),
        # Panel content
        shiny::tags$div(
          class = "page-content",
          f7Block(...)
        )
      )
    )
  )

  f7Shadow(sidebarTag, intensity = 24)

}
