#' Framework7 link
#'
#' Link to point toward external content.
#'
#' @param label Optional link text.
#' @param href Link source, url.
#' @param icon Link icon, if any. Must pass \link{f7Icon}.
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
#'      f7Link(href = "https://www.twitter.com", icon = f7Icon("bolt_fill"))
#'     )
#'    ),
#'    server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Link <- function(label = NULL, href, icon = NULL) {

  linkCl <- "link external"

 shiny::a(
   href = href,
   target = "_blank",
   class = linkCl,
   if (!is.null(icon)) {
     shiny::tagList(
       icon,
       label
     )
   } else {
     label
   }
 )
}
