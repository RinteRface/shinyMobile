library(shiny)
library(shinyMobile)

sheetModuleUI <- function(id) {
  ns <- NS(id)
  f7Segment(
    f7Button(inputId = ns("go"), label = "Show action sheet", color = "green"),
    f7Button(inputId = ns("update"), label = "Update action sheet", color = "red")
  )
}

sheetModule <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns

      observeEvent(input$action1_button, {
        if (input$action1_button == 1) {
          f7Notif(
            text = "You clicked on the first button",
            icon = f7Icon("bolt_fill"),
            title = "Notification",
            titleRightText = "now"
          )
        } else if (input$action1_button == 2) {
          f7Dialog(
            id = ns("test"),
            title = "Click me to launch a Toast!",
            type = "confirm",
            text = "You clicked on the second button",
          )
        }
      })

      observeEvent(input$test, {
        f7Toast(text = paste("Alert input is:", input$test))
      })

      observeEvent(input$go, {
        f7ActionSheet(
          grid = TRUE,
          id = ns("action1"),
          buttons = list(
            list(
              text = "Notification",
              icon = f7Icon("info"),
              color = NULL
            ),
            list(
              text = "Dialog",
              icon = f7Icon("lightbulb_fill"),
              color = NULL
            )
          )
        )
      })

      observeEvent(input$update, {
        updateF7ActionSheet(
          id = "action1",
          options = list(
            grid = TRUE,
            buttons = list(
              list(
                text = "Plop",
                icon = f7Icon("info"),
                color = "orange"
              )
            )
          )
        )
      })
    }
  )
}

app <- shinyApp(
  ui = f7Page(
    title = "Action sheet",
    f7SingleLayout(
      navbar = f7Navbar("Action sheet"),
      br(),
      sheetModuleUI(id = "sheet1")
    )
  ),
  server = function(input, output, session) {
    sheetModule("sheet1")
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
