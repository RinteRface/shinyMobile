library(shiny)
library(shinyF7)

shiny::shinyApp(
  ui = f7Page(
    title = "My app",
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
            footer = tagList(
              f7Button(color = "blue", "My button", src = "https://www.google.com"),
              f7Badge("Badge", color = "green")
            )
          )
        )
      )
    )
  ),
  server = function(input, output) {
    output$distPlot <- renderPlot({
      dist <- rnorm(input$obs)
      hist(dist)
    })
  }
)
