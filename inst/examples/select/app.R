library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "f7Select",
    f7SingleLayout(
      navbar = f7Navbar(title = "updateF7Select"),
      f7Card(
        f7Button(inputId = "update", label = "Update select"),
        br(),
        f7Select(
          inputId = "select",
          label = "Choose a variable:",
          choices = colnames(mtcars)[-1],
          selected = "hp"
        ),
        verbatimTextOutput("test")
      )
    )
  ),
  server = function(input, output, session) {
    output$test <- renderPrint(input$select)

    observeEvent(input$update, {
      updateF7Select(
        inputId = "select",
        selected = "gear"
      )
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
