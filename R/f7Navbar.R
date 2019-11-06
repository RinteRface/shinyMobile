#' Create a Framework7 Navbar
#'
#' Build a Framework7 Navbar
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
#' @param left_panel Whether to enable the left panel. FALSE by default.
#' @param right_panel Whether to enable the right panel. FALSE by default.
#'
#' @note Currently, bigger parameters does mess with the CSS.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Navbar <- function(..., subNavbar = NULL, title = NULL, subtitle = NULL, hairline = TRUE,
                     shadow = TRUE, bigger = FALSE, transparent = FALSE, left_panel = FALSE,
                     right_panel = FALSE) {

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

   leftNav <- if (left_panel) {
      shiny::tags$div(
         class = "left",
         shiny::tags$a(
            class = "link icon-only panel-open",
            `data-panel` = "left",
            shiny::tags$i(class = "f7-icons ios-only", "bars"),
            shiny::tags$i(class = "icon material-icons md-only", "menu")
         )
      )
   }

   rightNav <- if (right_panel) {
      shiny::tags$div(
         class = "right",
         shiny::tags$a(
            class = "link icon-only panel-open",
            `data-panel` = "right",
            shiny::tags$i(class = "f7-icons ios-only", "bars"),
            shiny::tags$i(class = "icon material-icons md-only", "menu")
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


#' Create a Framework7 sub navbar
#'
#' @param ... Any elements.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
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
#'            left_panel = TRUE,
#'            right_panel = TRUE,
#'            subNavbar = f7SubNavbar(
#'               f7Button(label = "My button", outline = TRUE),
#'               f7Button(label = "My button", outline = TRUE),
#'               f7Button(label = "My button", outline = TRUE)
#'            )
#'         ),
#'         f7Tabs(
#'            animated = TRUE,
#'            #swipeable = TRUE,
#'            f7Tab(
#'               tabName = "Tab 1",
#'               icon = f7Icon("email"),
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





#' Hide a framework7 navbar
#'
#' @param session Shiny session object.
#' @param animate Whether it should be hidden with animation or not. By default is TRUE.
#' @param hideStatusbar  When FALSE (default) it hides navbar partially keeping space
#' required to cover statusbar area. Otherwise, navbar will be fully hidden.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'     ui = f7Page(
#'        title = "Accordions",
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
#'           f7NavbarHide()
#'        })
#'
#'        observeEvent(input$show, {
#'           f7NavbarShow()
#'        })
#'     }
#'  )
#' }
f7NavbarHide <- function(session = shiny::getDefaultReactiveDomain(), animate = TRUE,
                         hideStatusbar = FALSE) {
   message <- dropNulls(
      list(
         animate = tolower(animate),
         hideStatusbar = tolower(hideStatusbar)
      )
   )
   session$sendCustomMessage(type = "hide_navbar", message)
}



#' Show a framework7 navbar
#'
#' @param session Shiny session object.
#' @param animate Whether it should be hidden with animation or not. By default is TRUE.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'     ui = f7Page(
#'        title = "Accordions",
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
#'           f7NavbarHide()
#'        })
#'
#'        observeEvent(input$show, {
#'           f7NavbarShow()
#'        })
#'     }
#'  )
#' }
f7NavbarShow <- function(session = shiny::getDefaultReactiveDomain(), animate = TRUE) {
   session$sendCustomMessage(type = "show_navbar", message = tolower(animate))
}
