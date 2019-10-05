#' Create a Framework7 page
#'
#' Build a Framework7 page
#'
#' @param ... Slot for shinyF7 skeleton elements: \link{f7Appbar}, \link{f7SingleLayout},
#' \link{f7TabLayout}, \link{f7SplitLayout}.
#' @param init App configuration. See \link{f7Init}.
#' @param title Page title.
#' @param preloader Whether to display a preloader before the app starts.
#' FALSE by default.
#' @param loading_duration Preloader duration.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Page <- function(..., init = f7Init(skin = "auto", theme = "light"), title = NULL, preloader = FALSE,
                   loading_duration = 3){

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
      shiny::tags$meta(name = "apple-mobile-web-app-title", content = title),
      shiny::tags$meta(name = "apple-mobile-web-app-status-bar-style", content = "black-translucent"),
      shiny::tags$link(rel = "apple-touch-icon", href = "icons/apple-touch-icon.png"),
      shiny::tags$link(rel = "icon", href = "icons/favicon.png"),
      shiny::tags$link(rel = "manifest", href = "manifest.json"),

      # Splatshscreen for IOS must be in a www folder
      shiny::tags$link(href = "splashscreens/iphone5_splash.png", media = "(device-width: 320px) and (device-height: 568px) and (-webkit-device-pixel-ratio: 2)", rel = "apple-touch-startup-image"),
      shiny::tags$link(href = "splashscreens/iphone6_splash.png", media = "(device-width: 375px) and (device-height: 667px) and (-webkit-device-pixel-ratio: 2)", rel = "apple-touch-startup-image"),
      shiny::tags$link(href = "splashscreens/iphoneplus_splash.png", media = "(device-width: 621px) and (device-height: 1104px) and (-webkit-device-pixel-ratio: 3)", rel = "apple-touch-startup-image"),
      shiny::tags$link(href = "splashscreens/iphonex_splash.png", media = "(device-width: 375px) and (device-height: 812px) and (-webkit-device-pixel-ratio: 3)", rel = "apple-touch-startup-image"),
      shiny::tags$link(href = "splashscreens/iphonexr_splash.png", media = "(device-width: 414px) and (device-height: 896px) and (-webkit-device-pixel-ratio: 2)", rel = "apple-touch-startup-image"),
      shiny::tags$link(href = "splashscreens/iphonexsmax_splash.png", media = "(device-width: 414px) and (device-height: 896px) and (-webkit-device-pixel-ratio: 3)", rel = "apple-touch-startup-image"),
      shiny::tags$link(href = "splashscreens/ipad_splash.png", media = "(device-width: 768px) and (device-height: 1024px) and (-webkit-device-pixel-ratio: 2)", rel = "apple-touch-startup-image"),
      shiny::tags$link(href = "splashscreens/ipadpro1_splash.png", media = "(device-width: 834px) and (device-height: 1112px) and (-webkit-device-pixel-ratio: 2)", rel = "apple-touch-startup-image"),
      shiny::tags$link(href = "splashscreens/ipadpro3_splash.png", media = "(device-width: 834px) and (device-height: 1194px) and (-webkit-device-pixel-ratio: 2)", rel = "apple-touch-startup-image"),
      shiny::tags$link(href = "splashscreens/ipadpro2_splash.png", media = "(device-width: 1024px) and (device-height: 1366px) and (-webkit-device-pixel-ratio: 2)", rel = "apple-touch-startup-image"),

      shiny::tags$title(title)
    ),
    # Body
    addCSSDeps(
      shiny::tags$body(
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






#' Create a Framework7 split layout
#'
#' This is a modified version of the \link{f7SingleLayout}.
#' It is intended to be used with tablets.
#'
#' @param ... Content.
#' @param navbar Slot for \link{f7Navbar}.
#' @param sidebar Slot for \link{f7Panel}. Particularly we expect the following code:
#' \code{f7Panel(title = "Sidebar", side = "left", theme = "light", "Blabla", style = "reveal")}
#' @param toolbar Slot for \link{f7Toolbar}.
#' @param panels Slot for \link{f7Panel}. Expect only a right panel, for instance:
#' \code{f7Panel(title = "Left Panel", side = "right", theme = "light", "Blabla", style = "cover")}
#' @param appbar Slot for \link{f7Appbar}.
#' @param statusbar Slot for \link{f7Statusbar}.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'  shiny::shinyApp(
#'    ui = f7Page(
#'      title = "My app",
#'      f7SplitLayout(
#'        sidebar = f7Panel(
#'          title = "Sidebar",
#'          side = "left",
#'          theme = "light",
#'          f7PanelMenu(
#'            id = "menu",
#'            f7PanelItem(tabName = "tab1", title = "Tab 1", icon = f7Icon("email"), active = TRUE),
#'            f7PanelItem(tabName = "tab2", title = "Tab 2", icon = f7Icon("home"))
#'          ),
#'          style = "reveal"
#'        ),
#'        navbar = f7Navbar(
#'          title = "Split Layout",
#'          hairline = FALSE,
#'          shadow = TRUE
#'        ),
#'        toolbar = f7Toolbar(
#'          position = "bottom",
#'          f7Link(label = "Link 1", src = "https://www.google.com"),
#'          f7Link(label = "Link 2", src = "https://www.google.com", external = TRUE)
#'        ),
#'        # main content
#'        f7Items(
#'          f7Item(
#'            tabName = "tab1",
#'            sliderInput("obs", "Number of observations:",
#'                        min = 0, max = 1000, value = 500
#'            ),
#'            plotOutput("distPlot")
#'          ),
#'          f7Item(tabName = "tab2", "Tab 2 content")
#'        )
#'      )
#'    ),
#'    server = function(input, output) {
#'
#'      observe({
#'        print(input$menu)
#'      })
#'
#'      output$distPlot <- renderPlot({
#'        dist <- rnorm(input$obs)
#'        hist(dist)
#'      })
#'    }
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' @export
f7SplitLayout <- function(..., navbar, sidebar, toolbar = NULL,
                          panels = NULL, appbar = NULL,
                          statusbar = f7Statusbar()) {

  sidebar <- shiny::tagAppendAttributes(sidebar[[2]], id = "f7-sidebar")
  # this trick to prevent to select the panel view in the following
  # javascript code
  sidebar$children[[1]]$attribs$id <- "f7-sidebar-view"

  splitSkeleton <- f7SingleLayout(
    ...,
    navbar = navbar,
    toolbar = toolbar,
    panels = shiny::tagList(
      sidebar,
      panels
    ),
    appbar = appbar,
    statusbar = statusbar
  )

  splitTemplateCSS <- shiny::singleton(
    shiny::tags$style(
      '/* Left Panel right border when it is visible by breakpoint */
      .panel-left.panel-visible-by-breakpoint:before {
        position: absolute;
        right: 0;
        top: 0;
        height: 100%;
        width: 1px;
        background: rgba(0,0,0,0.1);
        content: "";
        z-index: 6000;
      }

      /* Hide navbar link which opens left panel when it is visible by breakpoint */
      .panel-left.panel-visible-by-breakpoint ~ .view .navbar .panel-open[data-panel="left"] {
        display: none;
      }

      /*
        Extra borders for main view and left panel for iOS theme when it behaves as panel (before breakpoint size)
      */
      .ios .panel-left:not(.panel-visible-by-breakpoint).panel-active ~ .view-main:before,
      .ios .panel-left:not(.panel-visible-by-breakpoint).panel-closing ~ .view-main:before {
        position: absolute;
        left: 0;
        top: 0;
        height: 100%;
        width: 1px;
        background: rgba(0,0,0,0.1);
        content: "";
        z-index: 6000;
      }
      '
    )
  )

  splitTemplateJS <- shiny::singleton(
    shiny::tags$script(
      "$(function() {
        $('#f7-sidebar').addClass('panel-visible-by-breakpoint');
        $('.view:not(\"#f7-sidebar-view\")').addClass('safe-areas');
        $('.view:not(\"#f7-sidebar-view\")').css('margin-left', '260px');
      });
      "
    )
  )

  shiny::tagList(splitTemplateCSS, splitTemplateJS, splitSkeleton)

}




#' Create a Framework7 wrapper for \link{f7Item}
#'
#' Build a Framework7 wrapper for \link{f7Item}
#'
#' @param ... Slot for wrapper for \link{f7Item}.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Items <- function(...){
  shiny::tags$div(
    class = "tabs-animated-wrap",
    shiny::tags$div(
      # ios-edges necessary to have
      # the good ios rendering
      class = "tabs ios-edges",
      ...
    )
  )
}




#' Create a Framework7 \link{f7Item}.
#'
#' Similar to  \link{f7Tab} but for the \link{f7SplitLayout}.
#'
#' @inheritParams f7Tab
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Item <- function(..., tabName) {
  shiny::tags$div(
    class = "page-content tab",
    id = tabName,
    `data-value` = tabName,
    style = "background-color: gainsboro;",
    ...
  )
}
