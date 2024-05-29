library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Update Progress",
    f7SingleLayout(
      navbar = f7Navbar(title = "f7Progress"),
      f7BlockTitle("Progress with value"),
      f7Block(
        f7Progress(id = "pg1", value = 10, color = "blue")
      ),
      f7Slider(
        inputId = "obs",
        label = "Progress value",
        max = 100,
        min = 0,
        value = 50,
        scale = TRUE
      ),
      f7BlockTitle("Infinite progress"),
      f7Block(
        f7Progress(id = "pg2", value = NULL, color = "red")
      )
    )
  ),
  server = function(input, output, session) {
    observeEvent(input$obs, {
      updateF7Progress(id = "pg1", value = input$obs)
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
