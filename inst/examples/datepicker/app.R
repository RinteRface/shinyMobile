library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "My app",
    f7SingleLayout(
      navbar = f7Navbar(title = "Update date picker"),
      f7Segment(
        f7Button(inputId = "update", label = "Update"),
        f7Button(inputId = "rmToolbar", label = "Remove toolbar"),
        f7Button(inputId = "addToolbar", label = "Add toolbar")
      ),
      f7DatePicker(
        inputId = "picker",
        label = "Choose a date and time",
        value = as.POSIXct("2024-03-24 09:00:00 CET"),
        openIn = "auto",
        direction = "horizontal",
        timePicker = TRUE
      ),
      f7Block(verbatimTextOutput("pickerval"))
    )
  ),
  server = function(input, output, session) {
    output$pickerval <- renderPrint(input$picker)

    observeEvent(input$update, {
      updateF7DatePicker(
        inputId = "picker",
        value = as.POSIXct("2024-03-23 09:00:00 CET"),
        timePicker = TRUE,
        dateFormat = "yyyy-mm-dd" # preserve date format
      )
    })

    observeEvent(input$rmToolbar, {
      updateF7DatePicker(
        inputId = "picker",
        timePicker = TRUE,
        toolbar = FALSE,
        dateFormat = "yyyy-mm-dd" # preserve date format
      )
    })

    observeEvent(input$addToolbar, {
      updateF7DatePicker(
        inputId = "picker",
        timePicker = TRUE,
        toolbar = TRUE,
        dateFormat = "yyyy-mm-dd" # preserve date format
      )
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
