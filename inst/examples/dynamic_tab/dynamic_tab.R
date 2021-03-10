library(shiny)
library(shinyMobile)
shinyApp(
  ui = f7Page(
    title = "Insert a tab Before the target",
    f7TabLayout(
      panels = tagList(
#        f7Panel(title = "Left Panel", side = "left", theme = "light", "Blabla", effect = "cover"),
#        f7Panel(title = "Right Panel", side = "right", theme = "dark", "Blabla", effect = "cover")
      ),
      navbar = f7Navbar(
        title = "Tabs",
        hairline = FALSE,
        shadow = TRUE,
        leftPanel = TRUE,
        rightPanel = TRUE
      ),
      f7Tabs(
        animated = TRUE,
        id = "tabs",
        f7Tab(
          tabName = "Tab 1",
          icon = f7Icon("airplane"),
          active = TRUE,
          "Tab 1",
          f7Button(inputId = "go", label = "Go")
        ),
        f7Tab(
          tabName = "Tab 2",
          icon = f7Icon("today"),
          active = FALSE,
          "Tab 2"
        )
      )
    )
  ),
  server = function(input, output, session) {
    observeEvent(input$go, {
      insertF7Tab(
        id = "tabs",
        position = "before",
        target = "#Tab 2",
        tab = f7Tab (tabName = paste0("tab_", input$go), "Test",
                     icon = f7Icon("today")),
        select = TRUE
      )
    })
  }
)
