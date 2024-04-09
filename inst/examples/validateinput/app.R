library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Validate inputs",
    f7SingleLayout(
      navbar = f7Navbar(title = "validateF7Input"),
      f7Text(
        inputId = "caption",
        label = "Caption",
        value = "Data Summary"
      ),
      verbatimTextOutput("value"),
      hr(),
      f7Text(
        inputId = "caption2",
        label = "Enter a number",
        value = 1
      ),
      hr(),
      f7Password(
        inputId = "password",
        label = "Password"
      )
    )
  ),
  server = function(input, output, session) {
    observe({
      validateF7Input(inputId = "caption", info = "Whatever")
      validateF7Input(
        inputId = "caption2",
        pattern = "[0-9]*",
        error = "Only numbers please!"
      )
      validateF7Input(
        inputId = "password",
        pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$",
        error = "Password must contain at least one
        number and one uppercase and lowercase letter,
        and at least 8 or more characters"
      )
    })

    output$value <- renderPrint({
      input$caption
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
