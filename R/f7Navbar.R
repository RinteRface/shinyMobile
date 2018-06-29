#' Create a Framework7 Navbar
#'
#' Build a Framework7 Navbar
#'
#' @param hairline Whether to display a thin border on the top of the navbar. TRUE by default.
#' @param shadow Whether to display a shadow. TRUE by default.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Navbar <- function(hairline = TRUE, shadow = TRUE) {

 navbarClass <- "navbar"
 if (!hairline) navbarClass <- paste0(navbarClass, " no-hairline")
 if (!shadow) navbarClass <- paste0(navbarClass, " no-shadow")

 shiny::tags$div(
   class = navbarClass,
   shiny::tags$div(
     class = "navbar-inner",

   )
 )
}
