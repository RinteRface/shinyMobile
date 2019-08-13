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
    init = f7Init(theme = "ios"),
    f7TabLayout(
      panels = tagList(
        f7Panel(title = "Left Panel", side = "left", theme = "light", "Blabla", style = "reveal"),
        f7Panel(title = "Right Panel", side = "right", theme = "dark", "Blabla", style = "cover")
      ),
      navbar = f7Navbar(
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
  server = function(input, output, session) {
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
    output$smartdata <- renderTable({
      head(mtcars[, c("mpg", input$smartsel), drop = FALSE])
    }, rownames = TRUE)
    output$selectDate <- renderText(input$date)

    lapply(1:12, function(i) {
      output[[paste0("res", i)]] <- renderPrint(input[[paste0("btn", i)]])
    })
    output$pickerval <- renderText(input$mypicker)
    output$colorPickerVal <- renderText(input$mycolorpicker)

    # notifications
    lapply(1:3, function(i) {
      observeEvent(input[[paste0("goNotif", i)]],{
        f7Notif(
          text = "test",
          title = paste("Notification", i),
          subtitle = "A subtitle",
          titleRightText = i,
          session = session
        )
      })
    })

    # popovers
    observe({
      f7Popover(
        targetId = "popoverTrigger",
        content = "This is a f7Button",
        session
      )
    })

    # toasts
    observeEvent(input$toast, {
      f7Toast(
        session,
        position = "bottom",
        text = "I am a toast. Eat me!"
      )
    })

  }
)
