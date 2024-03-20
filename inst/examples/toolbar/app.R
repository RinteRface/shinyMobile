library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Toolbar",
    toolbar = f7Toolbar(
      icons = TRUE,
      f7Link(label = "Link 1", href = "https://www.google.com", icon = f7Icon("link_circle_fill")),
      f7Link(label = "Link 2", href = "https://maps.google.com", icon = f7Icon("location_circle_fill"))
    )
  ),
  server = function(input, output, session) {
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
