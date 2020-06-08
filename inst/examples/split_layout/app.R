library(shiny)
library(ggplot2)
library(shinyMobile)
library(apexcharter)

fruits <- data.frame(
  name = c('Apples', 'Oranges', 'Bananas', 'Berries'),
  value = c(44, 55, 67, 83)
)

new_mtcars <- reshape(
  data = head(mtcars),
  idvar = "model",
  varying = list(c("drat", "wt")),
  times = c("drat", "wt"),
  direction = "long",
  v.names = "value",
  drop = c("mpg", "cyl", "hp", "dist", "qsec", "vs", "am", "gear", "carb")
)

shinyApp(
  ui = f7Page(
    title = "My app",
    init = f7Init(
      hideNavOnPageScroll = FALSE,
      hideTabsOnPageScroll = FALSE,
      theme = "light"
    ),
    f7SplitLayout(
      sidebar = f7Panel(
        title = "Sidebar",
        side = "left",
        theme = "light",
        f7PanelMenu(
          id = "menu",
          f7PanelItem(
            tabName = "tab1",
            title = "Tab 1",
            icon = f7Icon("equal_circle"),
            active = TRUE
          ),
          f7PanelItem(
            tabName = "tab2",
            title = "Tab 2",
            icon = f7Icon("equal_circle")
          ),
          f7PanelItem(
            tabName = "tab3",
            title = "Tab 3",
            icon = f7Icon("equal_circle")
          )
        ),
        uiOutput("selected_tab"),
        effect = "reveal"
      ),
      navbar = f7Navbar(
        title = "Split Layout",
        hairline = FALSE,
        shadow = TRUE
      ),
      toolbar = f7Toolbar(
        position = "bottom",
        f7Link(label = "Link 1", src = "https://www.google.com"),
        f7Link(label = "Link 2", src = "https://www.google.com", external = TRUE)
      ),
      # main content
      f7Items(
        f7Item(
          tabName = "tab1",
          f7Sheet(
            id = "sheet1",
            label = "Plot Parameters",
            orientation = "bottom",
            swipeToClose = TRUE,
            backdrop = TRUE,
            f7Slider(
              "obs",
              "Number of observations:",
              min = 0, max = 1000,
              value = 500
            )
          ),
          br(),
          plotOutput("distPlot")
        ),
        f7Item(
          tabName = "tab2",
          apexchartOutput("radar")
        ),
        f7Item(
          tabName = "tab3",
          f7Toggle(
            inputId = "plot_show",
            label = "Show Plot?",
            checked = TRUE
          ),
          apexchartOutput("multi_radial")
        )
      )
    )
  ),
  server = function(input, output, session) {

    observeEvent(input$obs, {
      if (input$obs < 500) {
        f7Notif(
          text = paste0("The slider value is only ", input$obs, ". Please
                        increase it"),
          icon = f7Icon("bolt_fill"),
          title = "Alert",
          titleRightText = Sys.Date(),
          session = session
        )
      }
    })


    output$radar <- renderApexchart({
      apex(
        data = new_mtcars,
        type = "radar",
        mapping = aes(
          x = model,
          y = value,
          group = time)
      )
    })

    output$selected_tab <- renderUI({
      HTML(paste0("Access the currently selected tab: ", strong(input$menu)))
    })

    output$distPlot <- renderPlot({
      dist <- rnorm(input$obs)
      hist(dist)
    })

    output$multi_radial <- renderApexchart({
      if (input$plot_show) {
        apex(data = fruits, type = "radialBar", mapping = aes(x = name, y = value))
      }
    })

  }
)
