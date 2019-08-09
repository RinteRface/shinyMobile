library(shiny)
library(shinyF7)
library(plotly)

source("tabInputs.R")
source("tabBtns.R")
source("tabCards.R")
source("tabText.R")
source("tabInfo.R")
source("tabOthers.R")

shinyApp(
  ui = f7Page(
    title = "miniUI 2.0",
    dark_mode = FALSE,
    color = "teal",
    f7Init(theme = "md"),
    f7TabLayout(
      f7Panel(title = "Left Panel", side = "left", theme = "light", "Blabla", style = "cover"),
      f7Panel(title = "Right Panel", side = "right", theme = "dark", "Blabla", style = "cover"),
      f7Navbar(
        title = "miniUI 2.0",
        subtitle = "for Shiny",
        hairline = TRUE,
        shadow = TRUE,
        left_panel = TRUE,
        right_panel = TRUE
      ),
      f7Tabs(
        animated = TRUE,
        tabInputs,
        tabBtns,
        tabCards,
        tabText,
        tabInfo,
        tabOthers
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
    output$val <- renderPrint(input$button2)

    lapply(1:12, function(i) {
      output[[paste0("res", i)]] <- renderPrint(input[[paste0("btn", i)]])
    })
  }
)
