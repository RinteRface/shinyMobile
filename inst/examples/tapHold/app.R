library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Taphold",
    f7SingleLayout(
      navbar = f7Navbar(title = "f7TapHold"),
      f7Button(inputId = "pressme", label = "Press me")
    )
  ),
  server = function(input, output, session) {
    observe({
      f7TapHold(
        target = "#pressme",
        callback = "app.dialog.alert('Tap hold fired!')"
      )
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
