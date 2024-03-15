#' Framework7 Navbar
#'
#' Build a navbar layout element to insert in \link{f7SingleLayout},
#' \link{f7TabLayout} or \link{f7SplitLayout}.
#'
#' @param ... Slot for \link{f7SearchbarTrigger}. Not compatible with \link{f7Panel}.
#' @param subNavbar \link{f7SubNavbar} slot, if any.
#' @param title Navbar title.
#' @param subtitle `r lifecycle::badge("deprecated")`:
#' removed from Framework7.
#' @param hairline Whether to display a thin border on the top of the navbar. TRUE by default,
#' for ios.
#' @param shadow `r lifecycle::badge("deprecated")`:
#' removed from Framework7.
#' @param bigger Whether to display bigger title. FALSE by default. Title
#' becomes smaller when scrolling down the page.
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
#' @example inst/examples/navbar/app.R
#'
#' @export
f7Navbar <- function(..., subNavbar = NULL, title = NULL, subtitle = NULL, hairline = TRUE,
                     shadow = TRUE, bigger = FALSE, transparent = FALSE, leftPanel = FALSE,
                     rightPanel = FALSE) {
  lifecycle::deprecate_warn(
    when = "1.1.0",
    what = "f7Navbar(subtitle)",
    details = "subtitle has been
    removed from Framework7 and will be removed from shinyMobile
    in the next release."
  )

  navbarClass <- "navbar"
  if (transparent) navbarClass <- sprintf("%s navbar-transparent", navbarClass)
  # bigger and transparent work together
  if (bigger) navbarClass <- paste(navbarClass, "navbar-large")
  if (!hairline) navbarClass <- paste(navbarClass, "no-outline")

  leftNav <- if (leftPanel) {
    shiny::tags$div(
      class = "left",
      shiny::tags$a(
        class = "link icon-only panel-open",
        `data-panel` = "left",
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
        f7Icon("bars")
      )
    )
  }

  innerCl <- "navbar-inner sliding"

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
            title
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
          ),
          rightNav
        )
      },
      ...,
      subNavbar
    )
  )
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
updateF7Navbar <- function(animate = TRUE, hideStatusbar = FALSE, session = shiny::getDefaultReactiveDomain()) {
  message <- jsonlite::toJSON(
    list(
      animate = animate,
      hideStatusbar = hideStatusbar
    )
  )
  session$sendCustomMessage(type = "toggle-navbar", message = message)
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
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   shinyApp(
#'     ui = f7Page(
#'       title = "Sub Navbar",
#'       f7TabLayout(
#'         panels = tagList(
#'           f7Panel(
#'             title = "Left Panel",
#'             side = "left",
#'             theme = "light",
#'             "Blabla",
#'             style = "cover"
#'           ),
#'           f7Panel(
#'             title = "Right Panel",
#'             side = "right",
#'             theme = "dark",
#'             "Blabla",
#'             style = "cover"
#'           )
#'         ),
#'         navbar = f7Navbar(
#'           subNavbar = f7SubNavbar(
#'             f7Button(label = "My button", tonal = TRUE),
#'             f7Button(label = "My button", tonal = TRUE),
#'             f7Button(label = "My button", tonal = TRUE)
#'           ),
#'           title = "SubNavbar",
#'           hairline = FALSE,
#'           transparent = TRUE,
#'           bigger = TRUE,
#'           leftPanel = TRUE,
#'           rightPanel = TRUE
#'         ),
#'         f7Tabs(
#'           animated = TRUE,
#'           # swipeable = TRUE,
#'           f7Tab(
#'             title = "Tab 1",
#'             tabName = "Tab1",
#'             icon = f7Icon("envelope"),
#'             active = TRUE,
#'             "Tab 1"
#'           ),
#'           f7Tab(
#'             title = "Tab 2",
#'             tabName = "Tab2",
#'             icon = f7Icon("today"),
#'             active = FALSE,
#'             "Tab 2"
#'           ),
#'           f7Tab(
#'             title = "Tab 3",
#'             tabName = "Tab3",
#'             icon = f7Icon("cloud_upload"),
#'             active = FALSE,
#'             "Tab 3"
#'           )
#'         )
#'       )
#'     ),
#'     server = function(input, output) {}
#'   )
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
