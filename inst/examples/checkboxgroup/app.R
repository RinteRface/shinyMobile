library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "My app",
    f7SingleLayout(
      navbar = f7Navbar(title = "f7CheckboxGroup"),
      f7CheckboxGroup(
        inputId = "checkboxgroup",
        label = "Choose a variable:",
        choices = colnames(mtcars)[-1],
        selected = "disp",
        position = "right"
      ),
      tableOutput("data")
    )
  ),
  server = function(input, output) {
    output$data <- renderTable(
      {
        mtcars[, c("mpg", input$checkboxgroup), drop = FALSE]
      },
      rownames = TRUE
    )
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
