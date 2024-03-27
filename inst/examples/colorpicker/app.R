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
      "The picker hex value is:",
      textOutput("colorPickerVal"),
      "The picker rgb value is:",
      textOutput("colorPickerValRgb")
    )
  ),
  server = function(input, output) {
    output$colorPickerVal <- renderText(input$mycolorpicker$hex)
    output$colorPickerValRgb <- renderText(unlist(paste(input$mycolorpicker$rgb, collapse = ",")))
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
