#' Framework7 page container
#'
#' \code{f7Page} is the main app container.
#'
#' @param ... Slot for shinyMobile skeleton elements: \link{f7SingleLayout},
#' \link{f7TabLayout}, \link{f7SplitLayout}.
#' @param title Page title.
#' @param options shinyMobile configuration. See \url{https://framework7.io/docs/app.html}. Below are the most
#' notable options. General options:
#' \itemize{
#'  \item \code{theme}: App skin: "ios", "md", or "auto".
#'  \item \code{dark}: Dark layout. TRUE or FALSE.
#'  \item \code{skeletonsOnLoad}: Whether to display skeletons on load.
#'  This is a preloading effect. Not compatible with preloader.
#'  \item \code{preloader}: Loading spinner. Not compatible with skeletonsOnLoad.
#'  \item \code{filled}: Whether to fill the \link{f7Navbar} and \link{f7Toolbar} with
#'  the current selected color. FALSE by default.
#'  \item \code{color}: Color theme: See \url{https://framework7.io/docs/color-themes.html}.
#'  Expect a name like blue, red or hex code like `#FF0000`. If NULL, use the default color.
#'  If a name is specified it must be accepted either by \link[gplots]{col2hex} or
#'  \link{getF7Colors} (valid Framework 7 color names).
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
    # default options
    options = list(
      theme = c("auto", "ios", "md"),
      dark = TRUE,
      skeletonsOnLoad = FALSE,
      preloader = FALSE,
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
    allowPWA = FALSE) {
  # Color must be converted to HEX before going to JavaScript
  if (!is.null(options$color)) {
    # If color is a name
    if (!grepl("#", options$color)) {
      # Color belongs to Framework7 valid colors
      if (options$color %in% getF7Colors()) {
        options$color <- colorToHex(options$color)
      } else {
        # If not we use gplots and internal R colors
        options$color <- gplots::col2hex(options$color)
      }
    }
  }

  # fallback to auto
  if (length(options$theme) > 1) options$theme <- "auto"

  if (!is.null(options$skeletonsOnLoad) && !is.null(options$preloader)) {
    if (options$skeletonsOnLoad && options$preloader) {
      stop("Choose either skeletonsOnLoad or preloader.")
    }
  }

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

  # Can also contain app bar
  items <- list(...)
  # Find current layout stored in attribute
  layout <- unlist(lapply(items, function(item) {
    is_layout <- inherits(item, "shiny.tag.list")
    if (is_layout) {
      attributes(item)$layout
    }
  }))

  bodyTag <- shiny::tags$body(
    `data-pwa` = tolower(allowPWA),
    `data-ptr` = dataPTR,
    shiny::tags$div(
      id = "app",
      class = layout,
      items
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
        "shinyMobile",
        pwaDeps,
        "f7icons"
      ),
      bodyTag
    )
  )
}



#' Framework7 single layout
#'
#' \code{f7SingleLayout} provides a simple page layout.
#'
#' @param ... Content.
#' @param navbar Slot for \link{f7Navbar}.
#' @param toolbar Slot for \link{f7Toolbar}.
#' @param panels Slot for \link{f7Panel}.
#' Wrap in \code{tagList} if multiple panels.
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'   shinyApp(
#'     ui = f7Page(
#'       title = "Single layout",
#'       f7SingleLayout(
#'         navbar = f7Navbar(
#'           title = "Single Layout"
#'         ),
#'         toolbar = f7Toolbar(
#'           position = "bottom",
#'           f7Link(label = "Link 1", href = "https://www.google.com"),
#'           f7Link(label = "Link 2", href = "https://www.google.com")
#'         ),
#'         # main content
#'         f7Card(
#'           title = "Card header",
#'           f7Slider("obs", "Number of observations", 0, 1000, 500),
#'           plotOutput("distPlot"),
#'           footer = tagList(
#'             f7Button(
#'               color = "blue",
#'               label = "My button",
#'               href = "https://www.google.com"
#'             ),
#'             f7Badge("Badge", color = "green")
#'           )
#'         )
#'       )
#'     ),
#'     server = function(input, output) {
#'       output$distPlot <- renderPlot({
#'         dist <- rnorm(input$obs)
#'         hist(dist)
#'       })
#'     }
#'   )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7SingleLayout <- function(..., navbar, toolbar = NULL,
                           panels = NULL) {
  single_layout_tag <- shiny::tagList(
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
          class = "page-content",
          # page content
          ...
        )
      )
    )
  )

  attr(single_layout_tag, "layout") <- "single-layout"
  single_layout_tag
}

#' Framework7 tab layout
#'
#' \code{f7TabLayout} create a single page app with multiple tabs,
#' giving the illusion of a multi pages experience.
#'
#' @param ... Slot for \link{f7Tabs}.
#' @param navbar Slot for \link{f7Navbar}.
#' @param messagebar Slot for \link{f7MessageBar}.
#' @param panels Slot for \link{f7Panel}.
#' Wrap in \code{tagList} if multiple panels.
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'   library(shinyWidgets)
#'
#'   shinyApp(
#'     ui = f7Page(
#'       title = "Tab layout",
#'       f7TabLayout(
#'         tags$head(
#'           tags$script(
#'             "$(function(){
#'                $('#tapHold').on('taphold', function () {
#'                  app.dialog.alert('Tap hold fired!');
#'                });
#'              });
#'              "
#'           )
#'         ),
#'         panels = tagList(
#'           f7Panel(
#'             title = "Left Panel",
#'             side = "left",
#'             "Blabla",
#'             effect = "cover"
#'           ),
#'           f7Panel(
#'             title = "Right Panel",
#'             side = "right",
#'             "Blabla",
#'             effect = "cover"
#'           )
#'         ),
#'         navbar = f7Navbar(
#'           title = "Tabs",
#'           leftPanel = TRUE,
#'           rightPanel = TRUE
#'         ),
#'         f7Tabs(
#'           animated = FALSE,
#'           swipeable = TRUE,
#'           f7Tab(
#'             tabName = "Tab1",
#'             icon = f7Icon("envelope"),
#'             active = TRUE,
#'             f7Card(
#'               title = "Card header",
#'               f7Stepper(
#'                 "obs1",
#'                 "Number of observations",
#'                 min = 0,
#'                 max = 1000,
#'                 value = 500,
#'                 step = 100
#'               ),
#'               plotOutput("distPlot1"),
#'               footer = tagList(
#'                 f7Button(inputId = "tapHold", label = "My button"),
#'                 f7Badge("Badge", color = "green")
#'               )
#'             )
#'           ),
#'           f7Tab(
#'             tabName = "Tab2",
#'             icon = f7Icon("today"),
#'             active = FALSE,
#'             f7Card(
#'               title = "Card header",
#'               f7Select(
#'                 inputId = "obs2",
#'                 label = "Distribution type:",
#'                 choices = c(
#'                   "Normal" = "norm",
#'                   "Uniform" = "unif",
#'                   "Log-normal" = "lnorm",
#'                   "Exponential" = "exp"
#'                 )
#'               ),
#'               plotOutput("distPlot2"),
#'               footer = tagList(
#'                 f7Button(
#'                   label = "My button",
#'                   href = "https://www.google.com"
#'                 ),
#'                 f7Badge("Badge", color = "orange")
#'               )
#'             )
#'           ),
#'           f7Tab(
#'             tabName = "Tab3",
#'             icon = f7Icon("cloud_upload"),
#'             active = FALSE,
#'             f7Card(
#'               title = "Card header",
#'               f7SmartSelect(
#'                 inputId = "variable",
#'                 label = "Variables to show:",
#'                 c(
#'                   "Cylinders" = "cyl",
#'                   "Transmission" = "am",
#'                   "Gears" = "gear"
#'                 ),
#'                 multiple = TRUE,
#'                 selected = "cyl"
#'               ),
#'               tableOutput("data"),
#'               footer = tagList(
#'                 f7Button(
#'                   label = "My button",
#'                   href = "https://www.google.com"
#'                 ),
#'                 f7Badge("Badge", color = "green")
#'               )
#'             )
#'           )
#'         )
#'       )
#'     ),
#'     server = function(input, output) {
#'       output$distPlot1 <- renderPlot({
#'         dist <- rnorm(input$obs1)
#'         hist(dist)
#'       })
#'
#'       output$distPlot2 <- renderPlot({
#'         dist <- switch(input$obs2,
#'           norm = rnorm,
#'           unif = runif,
#'           lnorm = rlnorm,
#'           exp = rexp,
#'           rnorm
#'         )
#'
#'         hist(dist(500))
#'       })
#'
#'       output$data <- renderTable(
#'         {
#'           mtcars[, c("mpg", input$variable), drop = FALSE]
#'         },
#'         rownames = TRUE
#'       )
#'     }
#'   )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7TabLayout <- function(..., navbar, messagebar = NULL, panels = NULL) {
  tab_layout_tag <- shiny::tagList(
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

  attr(tab_layout_tag, "layout") <- "tab-layout"
  tab_layout_tag
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
#' @param panel Slot for \link{f7Panel}. Expect only a right panel, for instance:
#' \code{f7Panel(title = "Left Panel", side = "right", theme = "light", "Blabla", style = "cover")}
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'   shinyApp(
#'     ui = f7Page(
#'       title = "Split layout",
#'       f7SplitLayout(
#'         sidebar = f7Panel(
#'           id = "sidebar",
#'           title = "Sidebar",
#'           side = "left",
#'           f7PanelMenu(
#'             id = "menu",
#'             f7PanelItem(
#'               tabName = "tab1",
#'               title = "Tab 1",
#'               icon = f7Icon("envelope"),
#'               active = TRUE
#'             ),
#'             f7PanelItem(
#'               tabName = "tab2",
#'               title = "Tab 2",
#'               icon = f7Icon("house")
#'             )
#'           ),
#'           uiOutput("selected_tab")
#'         ),
#'         navbar = f7Navbar(
#'           title = "Split Layout"
#'         ),
#'         toolbar = f7Toolbar(
#'           position = "bottom",
#'           f7Link(label = "Link 1", href = "https://www.google.com"),
#'           f7Link(label = "Link 2", href = "https://www.google.com")
#'         ),
#'         # main content
#'         f7Items(
#'           f7Item(
#'             tabName = "tab1",
#'             f7Slider("obs", "Number of observations:",
#'               min = 0, max = 1000, value = 500
#'             ),
#'             plotOutput("distPlot")
#'           ),
#'           f7Item(tabName = "tab2", "Tab 2 content")
#'         )
#'       )
#'     ),
#'     server = function(input, output) {
#'       output$selected_tab <- renderUI({
#'         HTML(paste0("Selected tab: ", strong(input$menu)))
#'       })
#'
#'       output$distPlot <- renderPlot({
#'         dist <- rnorm(input$obs)
#'         hist(dist)
#'       })
#'     }
#'   )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' @export
f7SplitLayout <- function(..., navbar, sidebar, toolbar = NULL,
                          panel = NULL) {
  # add margins
  items <- shiny::div(...) %>%
    f7Margin(side = "left") %>%
    f7Margin(side = "right")

  sidebar <- shiny::tagAppendAttributes(sidebar, class = "panel-in")
  # this trick to prevent to select the panel view in the following
  # javascript code
  sidebar$children[[1]]$attribs$class <- "panel-visible-by-breakpoint"

  splitSkeleton <- f7SingleLayout(
    items,
    navbar = navbar,
    toolbar = toolbar,
    panels = shiny::tagList(
      sidebar,
      panel
    )
  )

  # Customize class
  splitSkeleton[[2]] <- tagAppendAttributes(
    splitSkeleton[[2]],
    class = "safe-areas"
  )

  attr(splitSkeleton, "layout") <- "split-layout"
  splitSkeleton
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
f7Items <- function(...) {
  # shiny::tags$div(
  # class = "tabs-animated-wrap",
  shiny::tags$div(
    # ios-edges necessary to have
    # the good ios rendering
    class = "tabs ios-edges",
    ...
  )
  # )
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
    ...
  )
}
