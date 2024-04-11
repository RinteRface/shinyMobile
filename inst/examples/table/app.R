library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "My app",
    f7SingleLayout(
      navbar = f7Navbar(
        title = "f7Table"
      ),
      uiOutput("table")
    )
  ),
  server = function(input, output) {
    output$table <- renderUI({
      f7Table(mtcars)
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
