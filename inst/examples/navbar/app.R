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
          theme = "light",
          "Blabla",
          style = "cover"
        ),
        f7Panel(
          title = "Right Panel",
          side = "right",
          theme = "dark",
          "Blabla",
          style = "cover"
        )
      ),
      navbar = f7Navbar(
        # subNavbar = f7SubNavbar(
        #  f7Button(label = "My button", tonal = TRUE),
        #  f7Button(label = "My button", tonal = TRUE),
        #  f7Button(label = "My button", tonal = TRUE)
        # ),
        title = "Title",
        hairline = TRUE,
        # bigger = TRUE,
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
