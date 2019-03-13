#' Create a Framework7 Navbar
#'
#' Build a Framework7 Navbar
#'
#' @param title Navbar title.
#' @param hairline Whether to display a thin border on the top of the navbar. TRUE by default.
#' @param shadow Whether to display a shadow. TRUE by default.
#' @param left_panel Whether to enable the left panel. FALSE by default.
#' @param right_panel Whether to enable the right panel. FALSE by default.
#' @param hideOnScroll Whether to hide the navbar on scroll. FALSE by default.
#'
#' @note hideOnScroll does not work yet.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Navbar <- function(title = NULL, hairline = TRUE, shadow = TRUE,
                     left_panel = FALSE, right_panel = FALSE, hideOnScroll = FALSE) {

   navbarClass <- "navbar"
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

   navTag <- shiny::tags$div(
      class = navbarClass,
      shiny::tags$div(
         class = if (hideOnScroll) "navbar-inner sliding" else "navbar-inner",
         leftNav,
         shiny::tags$div(class = "title", title),
         rightNav
      )
   )

   if (hideOnScroll) {
      shiny::tagList(
         shiny::singleton(
            shiny::tags$head(
               shiny::tags$script(
                  "$(function () {
                     $('.page-content').addClass('hide-navbar-on-scroll');
                  });
                  "
               )
            )
         ),
         navTag
      )
   } else {
      navTag
   }
}
