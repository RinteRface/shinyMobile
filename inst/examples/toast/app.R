library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Toast",
    f7SingleLayout(
      navbar = f7Navbar(title = "f7Toast"),
      f7Button(inputId = "toast", label = "Open Toast")
    )
  ),
  server = function(input, output, session) {
    observeEvent(input$toast, {
      f7Toast(
        position = "top",
        text = "I am a toast. Eat me!"
      )
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app

