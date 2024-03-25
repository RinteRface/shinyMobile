library(shiny)
library(shinyMobile)

app <- shiny::shinyApp(
  ui = f7Page(
    title = "Swiper",
    f7SingleLayout(
      navbar = f7Navbar(title = "f7Swiper"),
      f7Swiper(
        id = "swiper",
        f7Slide(
          f7Toggle(
            inputId = "toggle",
            label = "My toggle",
            color = "pink",
            checked = TRUE
          ),
          verbatimTextOutput("test")
        ),
        f7Slide(
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
            )
          ),
          textOutput("test2")
        )
      )
    )
  ),
  server = function(input, output) {
    output$test <- renderPrint(input$toggle)
    output$test2 <- renderText(input$slider)
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
