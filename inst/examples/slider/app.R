library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "My app",
    f7SingleLayout(
      navbar = f7Navbar(title = "updateF7Slider"),
      f7Block(
        f7BlockTitle("Simple slider with custom style", size = "large"),
        f7Button(inputId = "update_slider", label = "Update slider"),
        f7Slider(
          inputId = "slider",
          label = "Number of observations",
          max = 1000,
          min = 0,
          value = 100,
          scaleSteps = 5,
          scaleSubSteps = 3,
          scale = TRUE,
          color = "orange",
          labels = tagList(
            f7Icon("circle"),
            f7Icon("circle_fill")
          ),
          style = list(inset = TRUE, strong = TRUE, outline = TRUE)
        ),
        textOutput("slider_res")
      ),
      f7Block(
        f7BlockTitle("Range slider", size = "large"),
        f7Button(inputId = "update_range", label = "Update slider"),
        f7Slider(
          inputId = "range",
          label = "Range values",
          max = 500,
          min = 0,
          step = 0.01,
          color = "deeppurple",
          value = c(50, 100)
        ),
        textOutput("range_res")
      )
    )
  ),
  server = function(input, output, session) {
    output$slider_res <- renderText({
      input$slider
    })

    observeEvent(input$update_slider, {
      updateF7Slider(
        inputId = "slider",
        value = 0.05,
        min = 0,
        max = 0.01,
        scale = FALSE,
        step = 0.001,
        color = "pink"
      )
    })

    output$range_res <- renderText({
      input$range
    })

    observeEvent(input$update_range, {
      updateF7Slider(
        inputId = "range",
        value = c(1, 5),
        min = 0,
        scale = TRUE,
        step = 0.01,
        max = 10,
        color = "teal"
      )
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
