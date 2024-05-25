library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "f7Toggle",
    f7SingleLayout(
      navbar = f7Navbar(title = "updateF7Toggle"),
      f7Card(
        f7Button(inputId = "update", label = "Update toggle"),
        br(),
        f7Toggle(
          inputId = "toggle",
          label = "My toggle",
          color = "pink",
          checked = FALSE
        ),
        verbatimTextOutput("test")
      )
    )
  ),
  server = function(input, output, session) {
    output$test <- renderPrint({
      input$toggle
    })

    observeEvent(input$update, {
      updateF7Toggle(
        inputId = "toggle",
        checked = !input$toggle,
        color = "green"
      )
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
