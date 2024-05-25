library(shiny)
library(shinyMobile)

shinyApp(
  ui = f7Page(
    title = "Multiple restricted areas",
    f7TabLayout(
      navbar = f7Navbar(
        title = "Login Example for 2 Specific Section"
      ),
      f7Tabs(
        id = "tabs",
        f7Tab(
          title = "Tab 1",
          tabName = "Tab1",
          "Without authentication",
          icon = f7Icon("lock_open_fill"),
        ),
        f7Tab(
          title = "Restricted",
          tabName = "Restricted",
          icon = f7Icon("lock_fill"),
          # main content
          f7BlockTitle(
            title = "1st restricted area",
            size = "large"
          ) %>% f7Align("center")
        ),
        f7Tab(
          title = "Restricted 2",
          tabName = "Restricted2",
          icon = f7Icon("lock_fill"),
          # main content
          f7BlockTitle(
            title = "2nd restricted area",
            size = "large"
          ) %>% f7Align("center")
        )
      ),
      f7Login(id = "loginPage", title = "Welcome", startOpen = FALSE),
      f7Login(id = "loginPage2", title = "Welcome", startOpen = FALSE)
    )
  ),
  server = function(input, output, session) {
    trigger1 <- reactive({
      req(input$tabs == "Restricted")
    })

    trigger2 <- reactive({
      req(input$tabs == "Restricted2")
    })

    # do not run first since the login page is not yet visible
    f7LoginServer(
      id = "loginPage",
      ignoreInit = TRUE,
      trigger = trigger1
    )

    f7LoginServer(
      id = "loginPage2",
      ignoreInit = TRUE,
      trigger = trigger2
    )
  }
)
