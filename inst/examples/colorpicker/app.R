library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "My app",
    f7SingleLayout(
      navbar = f7Navbar(title = "f7ColorPicker"),
      f7ColorPicker(
        inputId = "mycolorpicker",
        placeholder = "Some text here!",
        label = "Select a color"
      ),
      "The picker value is:",
      textOutput("colorPickerVal")
    )
  ),
  server = function(input, output) {
    output$colorPickerVal <- renderText(input$mycolorpicker)
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
