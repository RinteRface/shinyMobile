#' Framework7 accordion container
#'
#' \link{f7Accordion} creates an interactive accordion container.
#'
#' @param ... Slot for \link{f7AccordionItem}.
#' @param id Optional id to recover the state of the accordion.
#' @param multiCollapse Whether to open multiple items at the same time. FALSE
#' by default.
#'
#' @rdname accordion
#'
#' @examples
#' # Accordion
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'   ui = f7Page(
#'     title = "Accordions",
#'     f7SingleLayout(
#'      navbar = f7Navbar("Accordions"),
#'      f7Accordion(
#'       id = "myaccordion1",
#'       f7AccordionItem(
#'        title = "Item 1",
#'        f7Block("Item 1 content"),
#'        open = TRUE
#'       ),
#'       f7AccordionItem(
#'        title = "Item 2",
#'        f7Block("Item 2 content")
#'       )
#'      ),
#'      f7Accordion(
#'       multiCollapse = TRUE,
#'       inputId = "myaccordion2",
#'       f7AccordionItem(
#'        title = "Item 1",
#'        f7Block("Item 1 content")
#'       ),
#'       f7AccordionItem(
#'        title = "Item 2",
#'        f7Block("Item 2 content")
#'       )
#'      )
#'     )
#'   ),
#'   server = function(input, output, session) {
#'    observe({
#'     print(
#'      list(
#'       accordion1 = input$myaccordion1,
#'       accordion2 = input$myaccordion2
#'      )
#'     )
#'    })
#'   }
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Accordion <- function(..., id = NULL, multiCollapse = FALSE) {

  accordionTag <- if (multiCollapse) {
    shiny::tags$div(
      class = "list",
      shiny::tags$ul(...)
    )
  } else {
    shiny::tags$div(
      class = "list accordion-list",
      shiny::tags$ul(...)
    )
  }

 tagAppendAttributes(
   accordionTag,
   id = id,
   class = "collapsible"
 )
}



#' Framework7 accordion item
#'
#' \link{f7AccordionItem} is to be inserted in \link{f7Accordion}.
#'
#' @param ... Item content such as \link{f7Block} or any f7 element.
#' @param title Item title.
#' @param open Whether the item is open at start. FALSE by default.
#'
#' @export
#' @rdname accordion
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
      ...
    )
  )
}





#' Update Framework 7 accordion
#'
#' \link{updateF7Accordion} toggles a \link{f7Accordion} on the client.
#'
#' @param id Accordion instance.
#' @param selected Index of item to select.
#' @param session Shiny session object
#'
#' @export
#' @rdname accordion
#'
#' @examples
#' # Update accordion
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'    ui = f7Page(
#'      title = "Accordions",
#'      f7SingleLayout(
#'        navbar = f7Navbar("Accordions"),
#'        f7Button(inputId = "go", "Go"),
#'        f7Accordion(
#'          id = "myaccordion1",
#'          f7AccordionItem(
#'            title = "Item 1",
#'            f7Block("Item 1 content"),
#'            open = TRUE
#'          ),
#'          f7AccordionItem(
#'            title = "Item 2",
#'            f7Block("Item 2 content")
#'          )
#'        )
#'      )
#'    ),
#'    server = function(input, output, session) {
#'
#'      observeEvent(input$go, {
#'        updateF7Accordion(id = "myaccordion1", selected = 2)
#'      })
#'
#'      observe({
#'        print(
#'          list(
#'            accordion1_state = input$myaccordion1$state,
#'            accordion1_values = unlist(input$myaccordion1$value)
#'          )
#'        )
#'      })
#'    }
#'  )
#' }
updateF7Accordion <- function(id, selected = NULL, session = shiny::getDefaultReactiveDomain()) {
  message <-list(selected = selected)
  session$sendInputMessage(id, message)
}
