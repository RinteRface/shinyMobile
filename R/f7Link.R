#' Framework7 link
#'
#' Link to point toward external content.
#'
#' @param label Link text.
#' @param icon Link icon, if any.
#' @param href Link source, url.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'    ui = f7Page(
#'     title = "Links",
#'     f7SingleLayout(
#'      navbar = f7Navbar(title = "f7Link"),
#'      f7Link(label = "Google", href = "https://www.google.com"),
#'      f7Link(label = "Twitter", href = "https://www.twitter.com")
#'     )
#'    ),
#'    server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Link <- function(label, href, icon = NULL) {

  linkCl <- "link external"

 shiny::a(
   href = href,
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
