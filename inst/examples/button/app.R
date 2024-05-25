library(shiny)
library(shinyMobile)

app <- shiny::shinyApp(
  ui = f7Page(
    title = "Update f7Button",
    f7SingleLayout(
      navbar = f7Navbar(title = "Update f7Button"),
      f7Block(f7Button("update", "Update Button")),
      f7Block(
        f7Button(
          "button",
          "My button",
          color = "orange",
          outline = FALSE,
          fill = TRUE,
          shadow = FALSE,
          rounded = FALSE,
          icon = f7Icon("speedometer")
        )
      )
    )
  ),
  server = function(input, output, session) {
    observeEvent(input$update, {
      updateF7Button(
        inputId = "button",
        label = "Updated label",
        color = "purple",
        shadow = TRUE,
        rounded = TRUE,
        outline = TRUE,
        fill = FALSE,
        tonal = TRUE,
        size = "large",
        icon = f7Icon("speaker_zzz")
      )
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
