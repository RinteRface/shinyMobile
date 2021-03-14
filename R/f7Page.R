#' Framework7 page container
#'
#' \link{f7Page} is the main app container.
#'
#' @param ... Slot for shinyMobile skeleton elements: \link{f7Appbar}, \link{f7SingleLayout},
#' \link{f7TabLayout}, \link{f7SplitLayout}.
#' @param title Page title.
#' @param preloader Whether to display a preloader before the app starts.
#' FALSE by default.
#' @param loading_duration Preloader duration.
#' @param options shinyMobile configuration. See \url{https://framework7.io/docs/app.html}. Below are the most
#' notable options. General options:
#' \itemize{
#'  \item \code{theme}: App skin: "ios", "md", "auto" or "aurora".
#'  \item \code{dark}: Dark layout. TRUE or FALSE.
#'  \item \code{filled}: Whether to fill the \link{f7Navbar} and \link{f7Toolbar} with
#'  the current selected color. FALSE by default.
#'  \item \code{color}: Color theme: See \url{https://framework7.io/docs/color-themes.html}.
#'  Expect a name like blue or red. If NULL, use the default color.
#'  \item \code{pullToRefresh}: Whether to active the pull to refresh feature. Default to FALSE.
#'  See \url{https://v5.framework7.io/docs/pull-to-refresh.html#examples}.
#'  \item \code{iosTranslucentBars}: Enable translucent effect (blur background) on navigation bars for iOS theme (on iOS devices).
#'  FALSE by default.
#' }
#' Touch module options \url{https://v5.framework7.io/docs/app.html#app-parameters}:
#' \itemize{
#'  \item \code{tapHold}:  It triggers (if enabled) after a sustained, complete touch event.
#'  By default it is disabled. Note, that Tap Hold is a part of built-in Fast Clicks library,
#'  so Fast Clicks should be also enabled.
#'  \item \code{tapHoldDelay}: Determines how long (in ms) the user must hold their tap before the taphold event is fired on the target element.
#'  Default to 750 ms.
#'  \item \code{iosTouchRipple}: Default to FALSE. Enables touch ripple effect for iOS theme.
#' }
#' Navbar options \url{https://v5.framework7.io/docs/navbar.html#navbar-app-parameters}:
#' \itemize{
#'  \item \code{iosCenterTitle}: Default to TRUE. When enabled then it will try to position
#'  title at the center in iOS theme. Sometime (with some custom design) it may not needed.
#'  \item \code{hideOnPageScroll}: Default to FALSE. Will hide Navbars on page scroll.
#' }
#' Toolbar options \url{https://v5.framework7.io/docs/toolbar-tabbar.html#toolbar-app-parameters}:
#' \itemize{
#'  \item \code{hideOnPageScroll}: Default to FALSE. Will hide tabs on page scroll.
#' }
#'
#' In any case, you must follow the same structure as provided in the function arguments.
#'
#' @param allowPWA Whether to include PWA dependencies. Default to FALSE.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Page <- function(
  ...,
  title = NULL,
  preloader = FALSE,
  loading_duration = 3,
  # default options
  options = list(
    theme = c("ios", "md", "auto", "aurora"),
    dark = TRUE,
    filled = FALSE,
    color = "#007aff",
    touch = list(
      tapHold = TRUE,
      tapHoldDelay = 750,
      iosTouchRipple = FALSE
    ),
    iosTranslucentBars = FALSE,
    navbar = list(
      iosCenterTitle = TRUE,
      hideOnPageScroll = TRUE
    ),
    toolbar = list(
      hideOnPageScroll = FALSE
    ),
    pullToRefresh = FALSE
  ),
  allowPWA = FALSE
) {

  # fallback to auto
  if (length(options$theme) > 1) options$theme <- "auto"

  if (!is.null(options$theme) && !is.null(options$filled) && !is.null(options$color)) {
    if (options$theme == "dark" && options$filled == TRUE &&
        (options$color == "white" || options$color == "#fff")) {
      stop("Wrong theme combination: navbar color cannot be white in a dark theme!")
    }
  }

  if (!is.null(options$pullToRefresh)) {
    dataPTR <- tolower(options$pullToRefresh)
    options$pullToRefresh <- NULL
  } else {
    dataPTR <- NULL
  }

  # configuration tag to be passed to JS
  configTag <- shiny::tags$script(
    type = "application/json",
    `data-for` = "app",
    jsonlite::toJSON(
      x = options,
      auto_unbox = TRUE,
      json_verbatim = TRUE
    )
  )

  bodyTag <- shiny::tags$body(
    `data-pwa` = tolower(allowPWA),
    `data-ptr`= dataPTR,
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
    ),
    configTag
  )

  pwaDeps <- if (allowPWA) {
    c("pwa", "pwacompat")
  } else {
    NULL
  }

  shiny::tagList(
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
      shiny::tags$title(title)
    ),
    # Body
    add_dependencies(
      deps = c(
        "framework7",
        "shinyMobile",
        pwaDeps
      ),
      bodyTag
    )
  )
}



#' Framework7 single layout
#'
#' \link{f7SingleLayout} provides a simple page layout.
#'
#' @param ... Content.
#' @param navbar Slot for \link{f7Navbar}.
#' @param toolbar Slot for \link{f7Toolbar}.
#' @param panels Slot for \link{f7Panel}.
#' Wrap in \code{tagList} if multiple panels.
#' @param appbar Slot for \link{f7Appbar}.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'  shinyApp(
#'   ui = f7Page(
#'     title = "Single layout",
#'     f7SingleLayout(
#'       navbar = f7Navbar(
#'         title = "Single Layout",
#'         hairline = FALSE,
#'         shadow = TRUE
#'       ),
#'       toolbar = f7Toolbar(
#'         position = "bottom",
#'         f7Link(label = "Link 1", href = "https://www.google.com"),
#'         f7Link(label = "Link 2", href = "https://www.google.com")
#'       ),
#'       # main content
#'       f7Shadow(
#'         intensity = 10,
#'         hover = TRUE,
#'         f7Card(
#'           title = "Card header",
#'           f7Slider("obs", "Number of observations", 0, 1000, 500),
#'           plotOutput("distPlot"),
#'           footer = tagList(
#'             f7Button(color = "blue", label = "My button", href = "https://www.google.com"),
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
                           panels = NULL, appbar = NULL) {

  shiny::tagList(
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




#' Framework7 tab layout
#'
#' \link{f7TabLayout} create a single page app with multiple tabs,
#' giving the illusion of a multi pages experience.
#'
#' @param ... Slot for \link{f7Tabs}.
#' @param navbar Slot for \link{f7Navbar}.
#' @param messagebar Slot for \link{f7MessageBar}.
#' @param panels Slot for \link{f7Panel}.
#' Wrap in \code{tagList} if multiple panels.
#' @param appbar Slot for \link{f7Appbar}.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'  library(shinyWidgets)
#'
#'  shinyApp(
#'    ui = f7Page(
#'      title = "Tab layout",
#'      f7TabLayout(
#'        tags$head(
#'          tags$script(
#'            "$(function(){
#'                $('#tapHold').on('taphold', function () {
#'                  app.dialog.alert('Tap hold fired!');
#'                });
#'              });
#'              "
#'          )
#'        ),
#'        panels = tagList(
#'          f7Panel(title = "Left Panel", side = "left", theme = "light", "Blabla", effect = "cover"),
#'          f7Panel(title = "Right Panel", side = "right", theme = "dark", "Blabla", effect = "cover")
#'        ),
#'        navbar = f7Navbar(
#'          title = "Tabs",
#'          hairline = FALSE,
#'          shadow = TRUE,
#'          leftPanel = TRUE,
#'          rightPanel = TRUE
#'        ),
#'        f7Tabs(
#'          animated = FALSE,
#'          swipeable = TRUE,
#'          f7Tab(
#'            tabName = "Tab 1",
#'            icon = f7Icon("envelope"),
#'            active = TRUE,
#'            f7Shadow(
#'              intensity = 10,
#'              hover = TRUE,
#'              f7Card(
#'                title = "Card header",
#'                f7Stepper(
#'                  "obs1",
#'                  "Number of observations",
#'                  min = 0,
#'                  max = 1000,
#'                  value = 500,
#'                  step = 100
#'                ),
#'                plotOutput("distPlot1"),
#'                footer = tagList(
#'                  f7Button(inputId = "tapHold", label = "My button"),
#'                  f7Badge("Badge", color = "green")
#'                )
#'              )
#'            )
#'          ),
#'          f7Tab(
#'            tabName = "Tab 2",
#'            icon = f7Icon("today"),
#'            active = FALSE,
#'            f7Shadow(
#'              intensity = 10,
#'              hover = TRUE,
#'              f7Card(
#'                title = "Card header",
#'                f7Select(
#'                  inputId = "obs2",
#'                  label = "Distribution type:",
#'                  choices = c(
#'                    "Normal" = "norm",
#'                    "Uniform" = "unif",
#'                    "Log-normal" = "lnorm",
#'                    "Exponential" = "exp"
#'                  )
#'                ),
#'                plotOutput("distPlot2"),
#'                footer = tagList(
#'                  f7Button(label = "My button", href = "https://www.google.com"),
#'                  f7Badge("Badge", color = "orange")
#'                )
#'              )
#'            )
#'          ),
#'          f7Tab(
#'            tabName = "Tab 3",
#'            icon = f7Icon("cloud_upload"),
#'            active = FALSE,
#'            f7Shadow(
#'              intensity = 10,
#'              hover = TRUE,
#'              f7Card(
#'                title = "Card header",
#'                f7SmartSelect(
#'                  inputId = "variable",
#'                  label = "Variables to show:",
#'                  c("Cylinders" = "cyl",
#'                    "Transmission" = "am",
#'                    "Gears" = "gear"),
#'                  multiple = TRUE,
#'                  selected = "cyl"
#'                ),
#'                tableOutput("data"),
#'                footer = tagList(
#'                  f7Button(label = "My button", href = "https://www.google.com"),
#'                  f7Badge("Badge", color = "green")
#'                )
#'              )
#'            )
#'          )
#'        )
#'      )
#'    ),
#'    server = function(input, output) {
#'      output$distPlot1 <- renderPlot({
#'        dist <- rnorm(input$obs1)
#'        hist(dist)
#'      })
#'
#'      output$distPlot2 <- renderPlot({
#'        dist <- switch(
#'          input$obs2,
#'          norm = rnorm,
#'          unif = runif,
#'          lnorm = rlnorm,
#'          exp = rexp,
#'          rnorm
#'        )
#'
#'        hist(dist(500))
#'      })
#'
#'      output$data <- renderTable({
#'        mtcars[, c("mpg", input$variable), drop = FALSE]
#'      }, rownames = TRUE)
#'    }
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7TabLayout <- function(..., navbar, messagebar = NULL, panels = NULL, appbar = NULL) {

  shiny::tagList(
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
      messagebar,
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






#' Framework7 split layout
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
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'  shinyApp(
#'    ui = f7Page(
#'      title = "Split layout",
#'      f7SplitLayout(
#'        sidebar = f7Panel(
#'          inputId = "sidebar",
#'          title = "Sidebar",
#'          side = "left",
#'          theme = "light",
#'          f7PanelMenu(
#'            id = "menu",
#'            f7PanelItem(tabName = "tab1", title = "Tab 1", icon = f7Icon("envelope"), active = TRUE),
#'            f7PanelItem(tabName = "tab2", title = "Tab 2", icon = f7Icon("house"))
#'          ),
#'          effect = "reveal"
#'        ),
#'        navbar = f7Navbar(
#'          title = "Split Layout",
#'          hairline = FALSE,
#'          shadow = TRUE
#'        ),
#'        toolbar = f7Toolbar(
#'          position = "bottom",
#'          f7Link(label = "Link 1", href = "https://www.google.com"),
#'          f7Link(label = "Link 2", href = "https://www.google.com")
#'        ),
#'        # main content
#'        f7Items(
#'          f7Item(
#'            tabName = "tab1",
#'            f7Slider("obs", "Number of observations:",
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
                          panels = NULL, appbar = NULL) {

  # add margins
  items <- shiny::div(...) %>% f7Margin(side = "left") %>% f7Margin(side = "right")

  sidebar <- shiny::tagAppendAttributes(sidebar, class = "panel-in")
  # this trick to prevent to select the panel view in the following
  # javascript code
  sidebar$children[[1]]$attribs$id <- "f7-sidebar-view"

  splitSkeleton <- f7SingleLayout(
    items,
    navbar = navbar,
    toolbar = toolbar,
    panels = shiny::tagList(
      sidebar,
      panels
    ),
    appbar = appbar
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




#' Framework7 item container
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




#' Framework7 body item
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
