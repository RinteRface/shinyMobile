library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Simple Dialog",
    f7SingleLayout(
      navbar = f7Navbar(title = "f7Dialog"),
      f7Segment(
        f7Button(
          inputId = "goButton",
          "Go!",
          fill = FALSE,
          outline = TRUE
        ),
        f7Button(
          inputId = "update",
          "Update config",
          fill = FALSE,
          outline = TRUE
        )
      )
    )
  ),
  server = function(input, output, session) {
    observeEvent(input$goButton, {
      f7Dialog(
        title = "Dialog title",
        text = "This is an alert dialog"
      )
    })

    observeEvent(input$update, {
      updateF7App(
        options = list(
          theme = "ios",
          dialog = list(
            buttonOk = "Yeaaaah!",
            buttonCancel = "Ouuups!"
          )
        )
      )

      f7Dialog(
        id = "test",
        title = "Warning",
        type = "confirm",
        text = "Look at me, I have a new buttons!"
      )
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
