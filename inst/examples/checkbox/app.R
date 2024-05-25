library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    f7SingleLayout(
      navbar = f7Navbar(title = "updateF7Checkbox"),
      f7Block(f7Button("update", "Toggle checkbox")),
      f7Checkbox(
        inputId = "checkbox",
        label = "Checkbox",
        value = FALSE
      )
    )
  ), server = function(input, output, session) {
    observeEvent(input$update, {
      updateF7Checkbox("checkbox", value = !input$checkbox)
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
