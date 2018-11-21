#' Create a Framework7 Navbar
#'
#' Build a Framework7 Navbar
#'
#' @param title Navbar title.
#' @param hairline Whether to display a thin border on the top of the navbar. TRUE by default.
#' @param shadow Whether to display a shadow. TRUE by default.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Navbar <- function(title = NULL, hairline = TRUE, shadow = TRUE) {

 navbarClass <- "navbar"
 if (!hairline) navbarClass <- paste0(navbarClass, " no-hairline")
 if (!shadow) navbarClass <- paste0(navbarClass, " no-shadow")

 leftNav <- shiny::tags$div(
    class = "left",
    shiny::tags$a(
       class = "link back",
       shiny::tags$i(class = "icon icon-back"),
       shiny::span(class = "ios-only", "Back")
    )
 )

 rightNav <- shiny::tags$div(class = "right")

 shiny::tags$div(
   class = navbarClass,
   shiny::tags$div(
     class = "navbar-inner sliding",
     leftNav,
     shiny::tags$div(class = "title", title),
     rightNav
   )
 )
}
