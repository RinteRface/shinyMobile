library(shiny)
library(shinyF7)

shinyApp(
  ui = f7Page(
    title = "My app",
    f7SingleLayout(
      navbar = f7Navbar(title = "f7TapHold"),
      f7Button(inputId = "pressme", label = "Press me")
    )
  ),
  server = function(input, output, session) {
    observeEvent(input$pressme,{
      f7TapHold(
        target = "#pressme",
        callback = I("app.dialog.alert('Tap hold fired!');"),
        session = session
      )
    })
  }
)
