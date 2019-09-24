library(shiny)
library(shinyF7)
library(echarts4r)

# polar diagram
df <- data.frame(
  x = seq(50),
  y = rnorm(50, 10, 3),
  z = rnorm(50, 11, 2),
  w = rnorm(50, 9, 2)
)

# sankey plot
sankey <- data.frame(
  source = c("a", "b", "c", "d", "c"),
  target = c("b", "c", "d", "e", "e"),
  value = ceiling(rnorm(5, 10, 1)),
  stringsAsFactors = FALSE
)

# webgl plot
vectors <- expand.grid(x = -3:3, y = -3:3)
mu <- 1
vectors$sx <- vectors$y
vectors$sy <- mu * (1 - vectors$x^2) * vectors$y - vectors$x
vectors$color <- log10(runif(nrow(vectors), 1, 10))

shiny::shinyApp(
  ui = f7Page(
    title = "My app",
    init = f7Init(hideNavOnPageScroll = FALSE, hideTabsOnPageScroll = FALSE, theme = "light"),
    f7SplitLayout(
      sidebar = f7Panel(
        title = "Sidebar",
        side = "left",
        theme = "light",
        f7PanelMenu(
          id = "menu",
          f7PanelItem(tabName = "tab1", title = "Tab 1", icon = f7Icon("email"), active = TRUE),
          f7PanelItem(tabName = "tab2", title = "Tab 2", icon = f7Icon("home")),
          f7PanelItem(tabName = "tab3", title = "Tab 3", icon = f7Icon("home"))
        ),
        uiOutput("selected_tab"),
        style = "reveal"
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
          f7Swiper(
            id = "swiper",
            spaceBetween = 100,
            f7Slide(
              f7Text(
                inputId = "sankey_name",
                label = "Sankey Name",
                placeholder = "Plot Name"
              ),
              echarts4rOutput("sankey_plot")

            ),
            f7Slide(
              df %>%
                e_charts(x) %>%
                e_polar() %>%
                e_angle_axis(x) %>% # angle = x
                e_radius_axis() %>%
                e_bar(y, coord_system = "polar") %>%
                e_scatter(z, coord_system = "polar")
            )
          )
        ),
        f7Item(
          tabName = "tab3",
          f7Toggle(
            inputId = "plot_show",
            label = "Show Plot?",
            checked = TRUE
          ),
          echarts4rOutput("flow_plot")
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

    output$sankey_plot <- renderEcharts4r({
      sankey %>%
        e_charts() %>%
        e_sankey(source, target, value) %>%
        e_title(input$sankey_name)
    })

    output$selected_tab <- renderUI({
      HTML(paste0("Access the currently selected tab: ", strong(input$menu)))
    })

    output$distPlot <- renderPlot({
      dist <- rnorm(input$obs)
      hist(dist)
    })

    output$flow_plot <- renderEcharts4r({
      if (input$plot_show) {
        vectors %>%
          e_charts(x) %>%
          e_flow_gl(y, sx, sy, color) %>%
          e_visual_map(
            min = 0, max = 1, # log 10
            dimension = 4, # x = 0, y = 1, sx = 3, sy = 4
            show = FALSE, # hide
            inRange = list(
              color = c('#313695', '#4575b4', '#74add1', '#abd9e9', '#e0f3f8',
                        '#ffffbf', '#fee090', '#fdae61', '#f46d43', '#d73027', '#a50026')
            )
          ) %>%
          e_x_axis(
            splitLine = list(show = FALSE)
          ) %>%
          e_y_axis(
            splitLine = list(show = FALSE)
          )
      }
    })

  }
)
