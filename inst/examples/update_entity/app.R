library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Update Entity",
    f7SingleLayout(
      navbar = f7Navbar(title = "Update action sheet instance"),
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
        ),
        f7Button(
          inputId = "reset",
          "Reset",
          fill = FALSE,
          outline = TRUE
        )
      )
    )
  ),
  server = function(input, output, session) {
    observeEvent(input$goButton, {
      f7ActionSheet(
        grid = TRUE,
        id = "action1",
        buttons = list(
          list(
            text = "Notification",
            icon = f7Icon("info"),
            color = NULL
          ),
          list(
            text = "Dialog",
            icon = f7Icon("lightbulb_fill"),
            color = NULL
          )
        )
      )
    })

    observeEvent(input$update, {
      updateF7Entity(
        id = "action1",
        options = list(
          buttons = list(
            list(
              text = "Notification",
              icon = f7Icon("info"),
              color = NULL
            )
          )
        )
      )
    })

    observeEvent(input$reset, {
      updateF7Entity(
        id = "action1",
        options = list(
          buttons = list(
            list(
              text = "Notification",
              icon = f7Icon("info"),
              color = NULL
            ),
            list(
              text = "Dialog",
              icon = f7Icon("lightbulb_fill"),
              color = NULL
            )
          )
        )
      )
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
