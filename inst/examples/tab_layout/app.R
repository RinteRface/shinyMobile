library(shiny)
library(shinyMobile)
library(apexcharter)
library(shinyWidgets)

poll <- data.frame(
  answer = c("Yes", "No"),
  n = c(254, 238)
)

shinyApp(
  ui = f7Page(
    title = "Tabs layout",
    f7TabLayout(
      panels = tagList(
        f7Panel(title = "Left Panel", side = "left", "Blabla", effect = "cover"),
        f7Panel(title = "Right Panel", side = "right", "Blabla", effect = "cover")
      ),
      navbar = f7Navbar(
        title = "Tabs",
        leftPanel = TRUE,
        rightPanel = TRUE
      ),
      f7Tabs(
        animated = TRUE,
        # swipeable = TRUE,
        f7Tab(
          title = "Tab 1",
          tabName = "Tab1",
          icon = f7Icon("folder"),
          active = TRUE,
          f7List(
            strong = TRUE,
            prettyRadioButtons(
              inputId = "theme",
              label = "Select a theme:",
              thick = TRUE,
              inline = TRUE,
              selected = "md",
              choices = c("ios", "md"),
              animation = "pulse",
              status = "info"
            ),
            prettyRadioButtons(
              inputId = "color",
              label = "Select a color:",
              thick = TRUE,
              inline = TRUE,
              selected = "dark",
              choices = c("light", "dark"),
              animation = "pulse",
              status = "info"
            )
          ),
          tags$head(
            tags$script(
              'Shiny.addCustomMessageHandler("ui-tweak", function(message) {
                var os = message.os;
                var skin = message.skin;
                if (os === "md") {
                  $("html").addClass("md");
                  $("html").removeClass("ios");
                  $(".tab-link-highlight").show();
                } else if (os === "ios") {
                  $("html").addClass("ios");
                  $("html").removeClass("md");
                  $(".tab-link-highlight").hide();
                }

                if (skin === "dark") {
                 $("html").addClass("dark");
                 $("html").removeClass("light");
                 $("body").addClass("dark");
                 $("body").removeClass("light");
                } else {
                 $("html").addClass("light");
                 $("html").removeClass("dark");
                 $("body").addClass("light");
                 $("body").removeClass("dark");
                }

               });
              '
            )
          ),
          f7Card(
            title = "Card header",
            apexchartOutput("pie")
          )
        ),
        f7Tab(
          title = "Tab 2",
          tabName = "Tab2",
          icon = f7Icon("keyboard"),
          f7Card(
            title = "Card header",
            apexchartOutput("scatter")
          )
        ),
        f7Tab(
          title = "Tab 3",
          tabName = "Tab3",
          icon = f7Icon("layers_alt"),
          f7Card(
            title = "Card header",
            f7SmartSelect(
              "variable",
              "Variables to show:",
              c(
                "Cylinders" = "cyl",
                "Transmission" = "am",
                "Gears" = "gear"
              ),
              openIn = "sheet",
              multiple = TRUE
            ),
            tableOutput("data")
          )
        )
      )
    )
  ),
  server = function(input, output, session) {
    # river plot
    dates <- reactive(seq.Date(Sys.Date() - 30, Sys.Date(), by = input$by))

    output$pie <- renderApexchart({
      apex(
        data = poll,
        type = "pie",
        mapping = aes(x = answer, y = n)
      )
    })

    output$scatter <- renderApexchart({
      apex(
        data = mtcars,
        type = "scatter",
        mapping = aes(
          x = wt,
          y = mpg,
          fill = cyl
        )
      )
    })


    # datatable
    output$data <- renderTable(
      {
        mtcars[, c("mpg", input$variable), drop = FALSE]
      },
      rownames = TRUE
    )


    # send the theme to javascript
    observe({
      session$sendCustomMessage(
        type = "ui-tweak",
        message = list(os = input$theme, skin = input$color)
      )
    })
  }
)
