library(shiny)
library(shinyF7)

source("tabInputs.R")

app <- shinyApp(
  ui = f7Page(
    title = "miniUI 2.0",
    dark_mode = FALSE,
    color = "teal",
    f7Init(theme = "ios"),
    f7TabLayout(
      f7Panel(title = "Left Panel", side = "left", theme = "light", "Blabla", style = "cover"),
      f7Panel(title = "Right Panel", side = "right", theme = "dark", "Blabla", style = "cover"),
      f7Navbar(
        title = "Tabs",
        hairline = TRUE,
        shadow = TRUE,
        left_panel = TRUE,
        right_panel = TRUE
      ),
      f7Tabs(
        animated = TRUE,
        tabInputs
      )
    )
  ),
  server = function(input, output) {
    output$text <- renderPrint(input$text)
    output$password <- renderPrint(input$password)
    output$slider <- renderPrint(input$slider)
    output$stepper <- renderPrint(input$stepper)
    output$check <- renderPrint(input$check)
    output$checkgroup <- renderPrint(input$checkgroup)
    output$radio <- renderPrint(input$radio)
    output$toggle <- renderPrint(input$toggle)
    output$select <- renderPrint(input$select)
  }
)

runGadget(app)
