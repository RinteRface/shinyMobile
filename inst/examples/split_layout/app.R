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
    title = "Split layout",
    f7SplitLayout(
      sidebar = f7Panel(
        id = "sidebar",
        title = "Sidebar",
        side = "left",
        effect = "push",
        options = list(
          visibleBreakpoint = 1024
        ),
        f7PanelMenu(
          id = "menu",
          strong = TRUE,
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
        uiOutput("selected_tab")
      ),
      navbar = f7Navbar(
        title = "Split Layout",
        hairline = FALSE,
        leftPanel = TRUE
      ),
      toolbar = f7Toolbar(
        position = "bottom",
        f7Link(label = "Link 1", href = "https://www.google.com"),
        f7Link(label = "Link 2", href = "https://www.google.com")
      ),
      # main content
      f7Items(
        f7Item(
          tabName = "tab1",
          f7Button("toggleSheet", "Plot parameters"),
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

    observeEvent(input$toggleSheet, {
      updateF7Sheet(id = "sheet1")
    })

    observeEvent(input$obs, {
      if (input$obs < 500) {
        f7Notif(
          text = paste0(
            "The slider value is only ", input$obs, ". Please
            increase it"
          ),
          icon = f7Icon("bolt_fill"),
          title = "Alert",
          titleRightText = Sys.Date()
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
      HTML(paste0("Currently selected tab: ", strong(input$menu)))
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
