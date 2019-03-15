# shinyF7
[![Build Status](https://travis-ci.org/RinteRface/shinyF7.svg?branch=master)](https://travis-ci.org/RinteRface/shinyF7)
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-ff69b4.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![Project Status](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip)

> shiny API for Framework7 (IOS/android)


## Installation

```r
# for the latest version
devtools::install_github("RinteRface/shinyF7")
```

## Demo

### Tabs Layout

A running demo is on [shinyapps.io](https://divadnojnarg.shinyapps.io/shinyF7).
It is still work in progress and will significantly change!


<a href="https://divadnojnarg.shinyapps.io/shinyF7" target="_blank"><img src="man/figures/f7_tab_layout_md.png" class="img-shadow" width= "423" height=" 453"></a>


```r
library(shiny)
library(shinyF7)
library(shinyWidgets)

shiny::shinyApp(
  ui = f7Page(
    title = "My app",
    f7Init(theme = "md"),
    f7TabLayout(
      f7Panel(title = "Left Panel", side = "left", theme = "light", "Blabla", style = "cover"),
      f7Panel(title = "Right Panel", side = "right", theme = "dark", "Blabla", style = "cover"),
      f7Navbar(
        title = "Tabs",
        hairline = FALSE,
        shadow = TRUE,
        left_panel = TRUE,
        right_panel = TRUE
      ),
      f7Tabs(
        animated = TRUE,
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
                f7Button(color = "blue", label = "My button", src = "https://www.google.com"),
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
              prettyRadioButtons(
                "obs2",
                "Distribution type:",
                c("Normal" = "norm",
                  "Uniform" = "unif",
                  "Log-normal" = "lnorm",
                  "Exponential" = "exp"),
                inline = TRUE,
                status = "warning",
                animation = "pulse"
              ),
              plotOutput("distPlot2"),
              footer = tagList(
                f7Button(color = "blue", label = "My button", src = "https://www.google.com"),
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
              prettyCheckboxGroup(
                "variable",
                "Variables to show:",
                c("Cylinders" = "cyl",
                  "Transmission" = "am",
                  "Gears" = "gear"),
                inline = TRUE,
                status = "danger",
                animation = "pulse"
              ),
              tableOutput("data"),
              footer = tagList(
                f7Button(color = "blue", label = "My button", src = "https://www.google.com"),
                f7Badge("Badge", color = "green")
              )
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
      dist <- switch(
        input$obs2,
        norm = rnorm,
        unif = runif,
        lnorm = rlnorm,
        exp = rexp,
        rnorm
      )

      hist(dist(500))
    })

    output$data <- renderTable({
      mtcars[, c("mpg", input$variable), drop = FALSE]
    }, rownames = TRUE)
  }
)
```


### As a shiny gadget

<img src="man/figures/f7_gadget.png" width="405" height="629" class="img-shadow">

```r
library(shiny)
runGadget(shinyAppDir(system.file("examples/tab_layout", package = "shinyF7")))
```
