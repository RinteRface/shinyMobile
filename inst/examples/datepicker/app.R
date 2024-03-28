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
      f7Segment(
        f7Button(inputId = "removeTime", label = "Remove time"),
        f7Button(inputId = "addTime", label = "Add time")
      ),
      f7DatePicker(
        inputId = "picker",
        label = "Choose a date and time",
        value = as.POSIXct("2024-03-24 09:00:00 UTC"),
        openIn = "auto",
        direction = "horizontal",
        timePicker = TRUE,
        dateFormat = "yyyy-mm-dd, HH::mm"
      ),
      f7Block(verbatimTextOutput("pickerval"))
    )
  ),
  server = function(input, output, session) {
    output$pickerval <- renderPrint(input$picker)

    observeEvent(input$update, {
      updateF7DatePicker(
        inputId = "picker",
        value = as.POSIXct("2024-03-23 10:00:00 UTC"),
        timePicker = TRUE,
        dateFormat = "yyyy-mm-dd, HH::mm" # preserve date format
      )
    })

    observeEvent(input$rmToolbar, {
      updateF7DatePicker(
        inputId = "picker",
        timePicker = TRUE,
        toolbar = FALSE,
        dateFormat = "yyyy-mm-dd, HH::mm" # preserve date format
      )
    })

    observeEvent(input$addToolbar, {
      updateF7DatePicker(
        inputId = "picker",
        timePicker = TRUE,
        toolbar = TRUE,
        dateFormat = "yyyy-mm-dd, HH::mm" # preserve date format
      )
    })

    observeEvent(input$removeTime, {
      updateF7DatePicker(
        inputId = "picker",
        value = as.Date(input$picker),
        timePicker = FALSE,
        dateFormat = "yyyy-mm-dd" # new date format
      )
    })

    observeEvent(input$addTime, {
      updateF7DatePicker(
        inputId = "picker",
        value = as.POSIXct(input$picker),
        timePicker = TRUE,
        dateFormat = "yyyy-mm-dd, HH::mm" # preserve date format
      )
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
