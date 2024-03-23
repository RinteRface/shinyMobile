library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "My app",
    f7SingleLayout(
      navbar = f7Navbar(title = "f7CheckboxGroup"),
      f7BlockTitle("Simple choices", size = "large"),
      f7CheckboxGroup(
        inputId = "checkboxgroup",
        label = "Choose a variable:",
        choices = colnames(mtcars)[-1],
        selected = "disp",
        position = "right"
      ),
      tableOutput("data"),
      f7BlockTitle("Custom choices: f7CheckboxChoice", size = "large"),
      f7CheckboxGroup(
        inputId = "checkboxgroup2",
        label = "Custom choices",
        choices = list(
          f7CheckboxChoice(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
            Nulla sagittis tellus ut turpis condimentum,
            ut dignissim lacus tincidunt",
            title = "Choice 1",
            subtitle = "David",
            after = "March 16, 2024"
          ),
          f7CheckboxChoice(
            "Cras dolor metus, ultrices condimentum sodales sit
            amet, pharetra sodales eros. Phasellus vel felis tellus.
            Mauris rutrum ligula nec dapibus feugiat",
            title = "Choice 2",
            subtitle = "Veerle",
            after = "March 17, 2024"
          )
        ),
        selected = 2
      ),
      textOutput("selected")
    )
  ),
  server = function(input, output) {
    output$data <- renderTable(
      {
        mtcars[, c("mpg", input$checkboxgroup), drop = FALSE]
      },
      rownames = TRUE
    )
    output$selected <- renderText(input$checkboxgroup2)
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
