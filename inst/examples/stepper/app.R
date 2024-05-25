library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Stepper app",
    f7SingleLayout(
      navbar = f7Navbar(title = "updateF7Stepper"),
      f7Block(f7Button(inputId = "update", label = "Update stepper")),
      f7List(
        strong = TRUE,
        inset = TRUE,
        outline = TRUE,
        f7Stepper(
          inputId = "stepper",
          label = "My stepper",
          min = 0,
          max = 10,
          size = "small",
          value = 4,
          wraps = TRUE,
          autorepeat = TRUE,
          rounded = FALSE,
          raised = FALSE,
          manual = FALSE
        )
      ),
      verbatimTextOutput("test")
    )
  ),
  server = function(input, output, session) {
    output$test <- renderPrint(input$stepper)

    observeEvent(input$update, {
      updateF7Stepper(
        inputId = "stepper",
        value = 0.1,
        step = 0.01,
        size = "large",
        min = 0,
        max = 1,
        wraps = FALSE,
        autorepeat = FALSE,
        rounded = TRUE,
        raised = TRUE,
        color = "pink",
        manual = TRUE,
        decimalPoint = 2
      )
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
