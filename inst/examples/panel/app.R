library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Panels",
    options = list(dark = FALSE),
    f7SingleLayout(
      navbar = f7Navbar(
        title = "f7Panel",
        leftPanel = TRUE,
        rightPanel = TRUE
      ),
      panels = tagList(
        f7Panel(
          id = "mypanel1",
          side = "left",
          effect = "push",
          title = "Left panel",
          resizable = TRUE,
          f7Block("A panel with push effect"),
          f7PanelMenu(
            id = "panelmenu",
            f7PanelItem(
              tabName = "tab1",
              title = "Tab 1",
              icon = f7Icon("envelope"),
              active = TRUE
            ),
            f7PanelItem(
              tabName = "tab2",
              title = "Tab 2",
              icon = f7Icon("house")
            )
          )
        ),
        f7Panel(
          id = "mypanel2",
          side = "right",
          effect = "floating",
          title = "Right panel",
          f7Block(
            "A panel with cover effect"
          ),
          options = list(swipe = TRUE)
        )
      ),
      toolbar = f7Toolbar(
        position = "bottom",
        icons = TRUE,
        f7Link(label = "Link 1", href = "https://www.google.com"),
        f7Link(label = "Link 2", href = "https://www.google.com")
      ),
      # main content
      f7Block(
        f7Button(inputId = "toggle", "Toggle panel 1")
      )
    )
  ),
  server = function(input, output, session) {
    observeEvent(input$mypanel2, {
      state <- if (input$mypanel2) "open" else "closed"

      f7Toast(
        text = paste0("Right panel is ", state),
        position = "center",
        closeTimeout = 1000,
        closeButton = FALSE
      )
    })

    observeEvent(input$toggle, {
      updateF7Panel(id = "mypanel1")
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
