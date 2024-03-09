library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Accordions",
    f7SingleLayout(
      navbar = f7Navbar("Accordions"),
      f7Segment(f7Button(inputId = "go", "Go")),
      f7Accordion(
        id = "myaccordion1",
        f7AccordionItem(
          title = "Item 1",
          f7Block("Item 1 content"),
          open = TRUE
        ),
        f7AccordionItem(
          title = "Item 2",
          f7Block("Item 2 content")
        )
      )
    )
  ),
  server = function(input, output, session) {
    observeEvent(input$go, {
      updateF7Accordion(id = "myaccordion1", selected = 2)
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
