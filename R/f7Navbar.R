#' Framework7 Navbar
#'
#' Build a navbar layout element to insert in \link{f7SingleLayout},
#' \link{f7TabLayout} or \link{f7SplitLayout}.
#'
#' @param ... Slot for \link{f7SearchbarTrigger}. Not compatible with \link{f7Panel}.
#' @param subNavbar \link{f7SubNavbar} slot, if any.
#' @param title Navbar title.
#' @param subtitle Navbar subtitle. Not compatible with bigger.
#' @param hairline Whether to display a thin border on the top of the navbar. TRUE by default.
#' @param shadow Whether to display a shadow. TRUE by default.
#' @param bigger Whether to display bigger title. FALSE by default. Not
#' compatible with subtitle.
#' @param transparent Whether the navbar should be transparent. FALSE by default.
#' Only works if bigger is TRUE.
#' @param leftPanel Whether to enable the left panel. FALSE by default.
#' @param rightPanel Whether to enable the right panel. FALSE by default.
#'
#' @note Currently, bigger parameters does mess with the CSS.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @rdname navbar
#'
#' @export
f7Navbar <- function(..., subNavbar = NULL, title = NULL, subtitle = NULL, hairline = TRUE,
                     shadow = TRUE, bigger = FALSE, transparent = FALSE, leftPanel = FALSE,
                     rightPanel = FALSE) {

   navbarClass <- "navbar"
   # bigger and transparent work together
   if (bigger) {
      if (transparent) {
         navbarClass <- paste0(navbarClass, " navbar-large navbar-large-transparent")
      } else {
         navbarClass <- paste0(navbarClass, " navbar-large")
      }
   }
   if (!hairline) navbarClass <- paste0(navbarClass, " no-hairline")
   if (!shadow) navbarClass <- paste0(navbarClass, " no-shadow")

   leftNav <- if (leftPanel) {
      shiny::tags$div(
         class = "left",
         shiny::tags$a(
            class = "link icon-only panel-open",
            `data-panel` = "left",
            # shiny::tags$i(class = "f7-icons ios-only", "bars"),
            # shiny::tags$i(class = "icon material-icons md-only", "menu")
            f7Icon("bars")
         )
      )
   }

   rightNav <- if (rightPanel) {
      shiny::tags$div(
         class = "right",
         shiny::tags$a(
            class = "link icon-only panel-open",
            `data-panel` = "right",
            # shiny::tags$i(class = "f7-icons ios-only", "bars"),
            # shiny::tags$i(class = "icon material-icons md-only", "menu")
            f7Icon("bars")
         )
      )
   }

   innerCl <- "navbar-inner sliding"
   if (bigger) innerCl <- paste0(innerCl, " navbar-inner-large")

   shiny::tags$div(
      class = navbarClass,
      shiny::tags$div(class = "navbar-bg"),
      shiny::tags$div(
         class = innerCl,
         leftNav,
         if (bigger) {
            shiny::tagList(
               shiny::tags$div(
                  class = "title",
                  title,
                  # add style to prevent title from
                  # being black. Bug in Framework7?
                  style = "color: white;"
               ),
               rightNav,
               shiny::tags$div(
                  class = "title-large",
                  shiny::tags$div(class = "title-large-text", title)
               )
            )
         } else {
            shiny::tagList(
               shiny::tags$div(
                  class = "title",
                  title,
                  if (!is.null(subtitle)) shiny::tags$span(class = "subtitle", subtitle)
               ),
               rightNav
            )
         },
         ...,
         subNavbar
      )
   )
}


#' Framework7 sub navbar
#'
#' \code{f7SubNavbar} creates a nested navbar component for
#' \link{f7Navbar}.
#'
#' @param ... Any elements.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'   ui = f7Page(
#'      title = "Sub Navbar",
#'      f7TabLayout(
#'         panels = tagList(
#'          f7Panel(title = "Left Panel", side = "left", theme = "light", "Blabla", style = "cover"),
#'          f7Panel(title = "Right Panel", side = "right", theme = "dark", "Blabla", style = "cover")
#'         ),
#'         navbar = f7Navbar(
#'            title = "SubNavbar",
#'            hairline = FALSE,
#'            shadow = TRUE,
#'            leftPanel = TRUE,
#'            rightPanel = TRUE,
#'            subNavbar = f7SubNavbar(
#'               f7Button(label = "My button"),
#'               f7Button(label = "My button"),
#'               f7Button(label = "My button")
#'            )
#'         ),
#'         f7Tabs(
#'            animated = TRUE,
#'            #swipeable = TRUE,
#'            f7Tab(
#'               tabName = "Tab 1",
#'               icon = f7Icon("envelope"),
#'               active = TRUE,
#'               "Tab 1"
#'            ),
#'            f7Tab(
#'               tabName = "Tab 2",
#'               icon = f7Icon("today"),
#'               active = FALSE,
#'               "Tab 2"
#'            ),
#'            f7Tab(
#'               tabName = "Tab 3",
#'               icon = f7Icon("cloud_upload"),
#'               active = FALSE,
#'               "Tab 3"
#'            )
#'         )
#'      )
#'   ),
#'   server = function(input, output) {}
#'  )
#' }
f7SubNavbar <- function(...) {
   shiny::tags$div(
      class = "subnavbar",
      shiny::tags$div(
         class = "subnavbar-inner",
         shiny::tags$div(
            class = "segmented",
            ...
         )
      )
   )
}





#' Hide a Framework7 navbar
#'
#' \code{f7HideNavbar} hides an \link{f7Navbar} component from the
#' server. Use \link{updateF7Navbar} instead.
#'
#' @param animate Whether it should be hidden with animation or not. By default is TRUE.
#' @param hideStatusbar  When FALSE (default) it hides navbar partially keeping space
#' required to cover statusbar area. Otherwise, navbar will be fully hidden.
#' @param session Shiny session object.
#'
#' @keywords internal
#' @rdname f7-deprecated
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'     ui = f7Page(
#'        title = "Hide navbar",
#'        f7SingleLayout(
#'           navbar = f7Navbar("Hide/Show navbar"),
#'           f7Segment(
#'              f7Button(inputId = "hide", "Hide navbar", color = "red"),
#'              f7Button(inputId = "show", "Show navbar", color = "green"),
#'           )
#'        )
#'     ),
#'     server = function(input, output, session) {
#'
#'        observeEvent(input$hide, {
#'           f7HideNavbar()
#'        })
#'
#'        observeEvent(input$show, {
#'           f7ShowNavbar()
#'        })
#'     }
#'  )
#' }
f7HideNavbar <- function(animate = TRUE, hideStatusbar = FALSE,
                         session = shiny::getDefaultReactiveDomain()) {

   .Deprecated(
      "updateF7Navbar",
      package = "shinyMobile",
      "f7HideNavbar will be removed in future release. Please use
    updateF7Navbar instead.",
      old = as.character(sys.call(sys.parent()))[1L]
   )

   message <- dropNulls(
      list(
         animate = tolower(animate),
         hideStatusbar = tolower(hideStatusbar)
      )
   )
   session$sendCustomMessage(type = "hide_navbar", message)
}



#' Show a Framework7 navbar
#'
#' \code{f7ShowNavbar} shows an \link{f7Navbar} component from the server.
#' Use \link{updateF7Navbar} instead.
#'
#' @inheritParams updateF7Navbar
#' @keywords internal
#' @rdname f7-deprecated
#' @export
f7ShowNavbar <- function(animate = TRUE, session = shiny::getDefaultReactiveDomain()) {
   .Deprecated(
      "updateF7Navbar",
      package = "shinyMobile",
      "f7ShowNavbar will be removed in future release. Please use
    updateF7Navbar instead.",
      old = as.character(sys.call(sys.parent()))[1L]
   )
   session$sendCustomMessage(type = "show_navbar", message = tolower(animate))
}




#' Toggle a Framework7 navbar
#'
#' \code{updateF7Navbar} toggles an \link{f7Navbar} component from the server.
#'
#' @param animate Whether it should be hidden with animation or not. By default is TRUE.
#' @param hideStatusbar  When FALSE (default) it hides navbar partially keeping space
#' required to cover statusbar area. Otherwise, navbar will be fully hidden.
#' @param session Shiny session object.
#' @rdname navbar
#'
#' @export
#'
#' @examples
#' # Toggle f7Navbar
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'     ui = f7Page(
#'        title = "Show navbar",
#'        f7SingleLayout(
#'           navbar = f7Navbar("Hide/Show navbar"),
#'           f7Button(inputId = "toggle", "Toggle navbar", color = "red")
#'        )
#'     ),
#'     server = function(input, output, session) {
#'
#'        observeEvent(input$toggle, {
#'           updateF7Navbar()
#'        })
#'     }
#'  )
#' }
updateF7Navbar <- function(animate = TRUE, hideStatusbar = FALSE, session = shiny::getDefaultReactiveDomain()) {
   message <- jsonlite::toJSON(
      list(
         animate = animate,
         hideStatusbar = hideStatusbar
      )
   )
   session$sendCustomMessage(type = "toggle_navbar", message = message)
}
