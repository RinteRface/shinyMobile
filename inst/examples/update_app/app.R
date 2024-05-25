library(shiny)
library(shinyMobile)

colors <- c(
  lightblue = "#5ac8fa",
  pink = "#ff2d55",
  teal = "#009688",
  yellow = "#ffcc00"
)

app <- shinyApp(
  ui = f7Page(
    title = "Update App",
    options = (
      list(
        color = "#5ac8fa"
      )
    ),
    f7SingleLayout(
      navbar = f7Navbar(title = "Update App"),
      f7BlockTitle("Update f7Dialog configuration"),
      f7Segment(
        f7Button(
          inputId = "goButton",
          "Show f7Dialog"
        ),
        f7Button(
          inputId = "update",
          "Update config"
        )
      ),
      f7BlockTitle("Update theme"),
      f7Segment(
        f7Button(
          inputId = "theme_ios",
          "iOS theme"
        ),
        f7Button(
          inputId = "theme_md",
          "MD theme"
        )
      ),
      f7BlockTitle("Set dark mode"),
      f7Segment(
        f7Button(
          inputId = "enable_darkmode",
          "Enable darkmode"
        ),
        f7Button(
          inputId = "disable_darkmode",
          "Disable darkmode"
        )
      ),
      f7BlockTitle("Change color theme"),
      f7Segment(
        tagList(
          lapply(names(colors),
                 function(color) {
                   f7Button(
                     inputId = paste0("color_", color),
                     label = color,
                     color = color,
                   )
                 }
          )
        )
      )
    )
  ),
  server = function(input, output, session) {
    observeEvent(input$goButton, {
      f7Dialog(
        id = "test2",
        title = "Dialog title",
        text = "This is an alert dialog",
        type = "confirm"
      )
    })

    observeEvent(input$update, {
      updateF7App(
        options = list(
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

    observeEvent(input$theme_ios, {
      updateF7App(
        options = list(
          theme = "ios"
        )
      )
    })

    observeEvent(input$theme_md, {
      updateF7App(
        options = list(
          theme = "md"
        )
      )
    })

    observeEvent(input$enable_darkmode, {
      updateF7App(
        options = list(
          dark = TRUE
        )
      )
    })

    observeEvent(input$disable_darkmode, {
      updateF7App(
        options = list(
          dark = FALSE
        )
      )
    })

    lapply(names(colors), function(color) {
      observeEvent(input[[paste0("color_", color)]], {
        updateF7App(
          options = list(
            color = colors[color]
          )
        )
      })
    })

  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
