library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Sub Navbar",
    options = list(
      dark = FALSE,
      navbar = list(
        hideOnPageScroll = TRUE,
        mdCenterTitle = TRUE
      )
    ),
    f7SingleLayout(
      panels = tagList(
        f7Panel(
          title = "Left Panel",
          side = "left",
          f7Block("Blabla"),
          effect = "cover"
        ),
        f7Panel(
          title = "Right Panel",
          side = "right",
          f7Block("Blabla"),
          effect = "cover"
        )
      ),
      navbar = f7Navbar(
        subNavbar = f7SubNavbar(
          f7Button(label = "My button"),
          f7Button(label = "My button"),
          f7Button(label = "My button")
        ),
        title = "Title",
        leftPanel = TRUE,
        rightPanel = TRUE
      ),
      f7Block(f7Button(inputId = "toggle", "Toggle navbar")),
      f7Block(
        lapply(1:20, f7Card)
      )
    )
  ),
  server = function(input, output, session) {
    observeEvent(input$toggle, {
      updateF7Navbar()
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
