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
        label = "Choose a date",
        value = Sys.Date() - 7,
        openIn = "auto",
        direction = "horizontal"
      ),
      f7Block(verbatimTextOutput("pickerval"))
    )
  ),
  server = function(input, output, session) {
    output$pickerval <- renderPrint(input$picker)

    observeEvent(input$update, {
      updateF7DatePicker(
        inputId = "picker",
        value = Sys.Date(),
        multiple = TRUE
      )
    })

    observeEvent(input$rmToolbar, {
      updateF7DatePicker(
        inputId = "picker",
        toolbar = FALSE,
        dateFormat = "yyyy-mm-dd" # preserve date format
      )
    })

    observeEvent(input$addToolbar, {
      updateF7DatePicker(
        inputId = "picker",
        toolbar = TRUE,
        dateFormat = "yyyy-mm-dd" # preserve date format
      )
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
