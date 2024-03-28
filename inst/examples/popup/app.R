library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Popup",
    f7SingleLayout(
      navbar = f7Navbar(
        title = "f7Popup"
      ),
      f7Block(f7Button("toggle", "Toggle Popup"))
    )
  ),
  server = function(input, output, session) {
    output$res <- renderPrint(input$text)

    observeEvent(input$toggle, {
      f7Popup(
        id = "popup",
        title = "My first popup",
        f7Text(
          "text", "Popup content",
          "This is my first popup ever, I swear!"
        ),
        verbatimTextOutput("res")
      )
    })

    observeEvent(input$popup1, {
      popupStatus <- if (input$popup1) "opened" else "closed"

      f7Toast(
        position = "top",
        text = paste("Popup is", popupStatus)
      )
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
