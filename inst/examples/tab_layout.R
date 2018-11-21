library(shiny)
library(shinyF7)

shiny::shinyApp(
  ui = f7TabLayout(
    setTheme("ios"),
    title = "My app",
    f7Panel(title = "Left Panel", side = "left", theme = "light", "Blabla", style = "cover"),
    f7Panel(title = "Right Panel", side = "right", theme = "dark", "Blabla", style = "cover"),
    f7Navbar(
      title = "Tabs",
      hairline = FALSE,
      shadow = TRUE
    ),
    #f7Toolbar(
    #  f7Link(label = "Google", src = "https://www.google.com"),
    #  f7Link(label = "Google", src = "https://www.google.com", external = TRUE)
    #),
    f7Tabs(
      icons = TRUE,
      animated = TRUE,
      position = "bottom",
      #swipeable = TRUE,
      f7Tab(
        tabName = "Tab 1",
        icon = "email",
        active = TRUE,
        f7Shadow(
          intensity = 10,
          hover = TRUE,
          f7Card(
            title = "Card header",
            sliderInput("obs1", "Number of observations", 0, 1000, 500),
            plotOutput("distPlot1"),
            footer = tagList(
              f7Button(color = "blue", "My button", src = "https://www.google.com"),
              f7Badge("Badge", color = "green")
            )
          )
        )
      ),
      f7Tab(
        tabName = "Tab 2",
        icon = "today",
        active = FALSE,
        f7Shadow(
          intensity = 10,
          hover = TRUE,
          f7Card(
            title = "Card header",
            sliderInput("obs2", "Number of observations", 0, 10000, 5000),
            plotOutput("distPlot2"),
            footer = tagList(
              f7Button(color = "blue", "My button", src = "https://www.google.com"),
              f7Badge("Badge", color = "green")
            )
          )
        )
      ),
      f7Tab(
        tabName = "Tab 3",
        icon = "file_upload",
        active = FALSE,
        f7Shadow(
          intensity = 10,
          hover = TRUE,
          f7Card(
            title = "Card header",
            sliderInput("obs3", "Number of observations", 0, 10, 5),
            plotOutput("distPlot3"),
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
    output$distPlot1 <- renderPlot({
      dist <- rnorm(input$obs1)
      hist(dist)
    })
    output$distPlot2 <- renderPlot({
      dist <- rnorm(input$obs2)
      hist(dist)
    })
    output$distPlot3 <- renderPlot({
      dist <- rnorm(input$obs3)
      hist(dist)
    })
  }
)
