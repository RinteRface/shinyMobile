#' Create a Framework7 link
#'
#' Build a Framework7 link
#'
#' @param label Link text.
#' @param icon Link icon, if any.
#' @param src Link source, url.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'     title = "Links",
#'     f7SingleLayout(
#'      navbar = f7Navbar(title = "f7Link"),
#'      f7Link(label = "Google", src = "https://www.google.com"),
#'      f7Link(label = "Twitter", src = "https://www.twitter.com")
#'     )
#'    ),
#'    server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Link <- function(label = NULL, icon = NULL, src = NULL) {

  linkCl <- "link external"

 shiny::a(
   href = src,
   target = "_blank",
   class = linkCl,
   if (!is.null(icon)) {
     shiny::tagList(
       shiny::tags$i(class = "icon", icon),
       shiny::span(label)
     )
   } else {
     label
   }
 )
}
