library(shiny)
library(shinyF7)

shiny::shinyApp(
  ui = f7Page(
    title = "My app",
    f7Init(theme = "auto"),
    f7SidebarLayout(
      # sidebar content
      sidebarPanel = f7Sidebar(
        title = "Sidebar",
        side = "left",
        theme = "light",
        sliderInput("obs", "Number of observations", 0, 1000, 500)
      ),
      # main content
      mainPanel = f7mainPanel(
        navbar = f7Navbar(
          title = "Sidebar Layout",
          hairline = FALSE,
          shadow = TRUE
        ),
        toolbar = f7Toolbar(
          f7Link(label = "Link 1", src = "https://www.google.com"),
          f7Link(label = "Link 2", src = "https://www.google.com", external = TRUE)
        ),
        f7Shadow(
          intensity = 10,
          hover = TRUE,
          f7Card(
            title = "Card header",
            plotOutput("distPlot"),
            footer = NULL
          )
        ),
        br(), br(), br(), br(), br(), br(),
        f7Fabs(
          position = "center-bottom",
          color = "yellow",
          sideOpen = "right",
          f7Fab("show", "Show")
        )
      )
    )
  ),
  server = function(input, output) {
    output$distPlot <- renderPlot({
      req(input$show > 0)
      dist <- rnorm(input$obs)
      hist(dist)
    })
  }
)
