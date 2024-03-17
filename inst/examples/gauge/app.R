library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Gauges",
    f7SingleLayout(
      navbar = f7Navbar(title = "f7Gauge"),
      f7Block(
        f7Gauge(
          id = "mygauge",
          type = "semicircle",
          value = 50,
          borderColor = "#2196f3",
          borderWidth = 10,
          valueFontSize = 41,
          valueTextColor = "#2196f3",
          labelText = "amount of something"
        )
      ),
      f7Block(f7Button("update", "Update Gauge"))
    )
  ),
  server = function(input, output, session) {
    observeEvent(input$update, {
      updateF7Gauge(id = "mygauge", value = 75, labelText = "New label!")
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
