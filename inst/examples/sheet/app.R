library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Update f7Sheet",
    f7SingleLayout(
      navbar = f7Navbar(title = "f7Sheet"),
      f7Block(f7Button(inputId = "toggle", label = "Open sheet")),
      f7Sheet(
        id = "sheet",
        orientation = "bottom",
        swipeToClose = TRUE,
        swipeToStep = TRUE,
        backdrop = TRUE,
        options = list(push = TRUE, breakpoints = c(0.33, 0.66)),
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        Quisque ac diam ac quam euismod porta vel a nunc. Quisque sodales
        scelerisque est, at porta justo cursus ac",
        hiddenItems = tagList(
          f7Segment(
            container = "segment",
            rounded = TRUE,
            f7Button(color = "blue", label = "My button 1", rounded = TRUE),
            f7Button(color = "green", label = "My button 2", rounded = TRUE),
            f7Button(color = "yellow", label = "My button 3", rounded = TRUE)
          ),
          f7Grid(
            cols = 1,
            f7Gauge(
              id = "mygauge",
              type = "semicircle",
              value = 10,
              borderColor = "#2196f3",
              borderWidth = 10,
              valueFontSize = 41,
              valueTextColor = "#2196f3",
              labelText = "amount of something"
            )
          ),
          f7Slider(
            inputId = "obs",
            label = "Number of observations",
            max = 100,
            min = 0,
            value = 10,
            scale = TRUE
          ),
          plotOutput("distPlot")
        )
      )
    )
  ),
  server = function(input, output, session) {
    output$distPlot <- renderPlot({
      hist(rnorm(input$obs))
    })
    observeEvent(input$obs, {
      updateF7Gauge(id = "mygauge", value = input$obs)
    })
    observeEvent(input$toggle, {
      updateF7Sheet(id = "sheet")
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
