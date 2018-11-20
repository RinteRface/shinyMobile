#' Create a Framework7 accordion
#'
#' Build a Framework7 accordion
#'
#' @param ... Slot for \link{f7AccordionItem}.
#' @param mode Accordion style. NULL by default. Use "list" to access the list
#' style.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     title = "My app",
#'     f7Accordion(
#'      f7AccordionItem(
#'       title = "Item 1",
#'       "Item 1 content",
#'       open = TRUE
#'      ),
#'      f7AccordionItem(
#'       title = "Item 2",
#'       "Item 2 content"
#'      )
#'     ),
#'     f7Accordion(
#'      mode = "list",
#'      f7AccordionItem(
#'       title = "Item 1",
#'       "Item 1 content"
#'      ),
#'      f7AccordionItem(
#'       title = "Item 2",
#'       "Item 2 content"
#'      )
#'     )
#'   ),
#'   server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Accordion <- function(..., mode = NULL) {

 if (is.null(mode)) {
   shiny::tags$div(
     class = "list",
     shiny::tags$ul(...)
   )
 } else {
   if (mode == "list") {
     shiny::tags$div(
       class = "list accordion-list",
       shiny::tags$ul(...)
     )
   }
 }
}



#' Create a Framework7 accordion item
#'
#' Build a Framework7 accordion item
#'
#' @param ... Item content.
#' @param title Item title.
#' @param open Whether the item is open at start. FALSE by default.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7AccordionItem <- function(..., title = NULL, open = FALSE) {

  accordionCl <- "accordion-item"
  if (open) accordionCl <- paste0(accordionCl, " accordion-item-opened")

  # item tag
  shiny::tags$li(
    class = accordionCl,
    shiny::tags$a(
      href = "#",
      class = "item-content item-link",
      shiny::tags$div(
        class = "item-inner",
        shiny::tags$div(class = "item-title", title)
      )
    ),
    shiny::tags$div(
      class = "accordion-item-content",
      shiny::tags$div(
        class = "block",
        shiny::tags$p(...)
      )
    )
  )
}
