library(shiny)
library(shinyF7)
library(echarts4r)

plot <- USArrests %>%
  dplyr::mutate(
    State = row.names(.),
    Rape = -Rape
  ) %>%
  e_charts(State) %>%
  e_line(Murder) %>%
  e_area(Rape, name = "Sick basterd", x_index = 1) %>%  # second y axis
  e_title("Your plot", "Subtext", sublink = "https://john-coene.com") %>%
  e_x_axis(1, show = FALSE) # hide scond X Axis

shiny::shinyApp(
  ui = f7Page(
    title = "My app",
    dark_mode = TRUE,
    f7Init(theme = "md"),
    f7SingleLayout(
      navbar = f7Navbar(
        title = "Single Layout",
        hairline = FALSE,
        shadow = TRUE
      ),
      toolbar = f7Toolbar(
        position = "bottom",
        f7Link(label = "Link 1", src = "https://www.google.com"),
        f7Link(label = "Link 2", src = "https://www.google.com", external = TRUE)
      ),
      # main content
      f7Shadow(
        intensity = 16,
        hover = TRUE,
        f7Card(
          title = "Card header",
          e_theme(plot, "dark"),
          footer = tagList(
            f7Button(color = "blue", label = "My button", src = "https://www.google.com"),
            f7Badge("Badge", color = "green")
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
