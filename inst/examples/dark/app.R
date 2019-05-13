shiny::shinyApp(
  ui = f7Page(
    title = "My app",
    dark_mode = TRUE,
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

          prettyRadioButtons(
            inputId = "theme",
            label = "Select a theme:",
            thick = TRUE,
            inline = TRUE,
            selected = "md",
            choices = c("ios", "auto", "md"),
            animation = "pulse",
            status = "info"
          ),

          shiny::tags$head(
            shiny::tags$script(
              'Shiny.addCustomMessageHandler("theme-select", function(message) {
                alert(message);
                var ios = $("html").hasClass("ios");
                var md = $("html").hasClass("md");
                if (ios === true && theme == "md") {
                  $( "html" ).addClass("md");
                  $( "html" ).removeClass("ios");
                } else if (md === true && theme == "ios"){
                  $( "html" ).addClass("ios");
                  $( "html" ).removeClass("md");
                }
               };
              '
            )
          ),

          f7Shadow(
            intensity = 10,
            hover = TRUE,
            f7Card(
              title = "Card header",
              sliderTextInput(
                inputId = "by",
                label = "Date Selector:",
                choices = c("day", "week", "month"),
                selected = "day"
              ),
              br(),
              echarts4rOutput("river"),
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
              prettySwitch(
                inputId = "show",
                label = "Show Plot",
                status = "danger"
              ),
              echarts4rOutput("network"),
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
  server = function(input, output, session) {

    # river plot
    dates <- reactive(seq.Date(Sys.Date() - 30, Sys.Date(), by = input$by))

    output$river <- renderEcharts4r({
      df <- data.frame(
        dates = dates(),
        apples = runif(length(dates())),
        bananas = runif(length(dates())),
        pears = runif(length(dates()))
      )

      df %>%
        e_charts(dates) %>%
        e_river(apples) %>%
        e_river(bananas) %>%
        e_river(pears) %>%
        e_tooltip(trigger = "axis") %>%
        e_title("River charts", "(Streamgraphs)") %>%
        e_theme("dark")
    })

    # network
    nodes <- reactive({
      data.frame(
        name = paste0(LETTERS, 1:300),
        value = rnorm(300, 10, 2),
        size = rnorm(300, 10, 2),
        grp = rep(c("grp1", "grp2", "grp3"), 100),
        stringsAsFactors = FALSE
      )
    })

    edges <- reactive({
      data.frame(
        source = sample(nodes()$name, 400, replace = TRUE),
        target = sample(nodes()$name, 400, replace = TRUE),
        stringsAsFactors = FALSE
      )
    })

    output$network <- renderEcharts4r({
      req(input$show)
      e_charts() %>%
        e_graph_gl() %>%
        e_graph_nodes(nodes(), name, value, size, grp) %>%
        e_graph_edges(edges(), source, target) %>%
        e_theme("dark")
    })


    # datatable
    output$data <- renderTable({
      mtcars[, c("mpg", input$variable), drop = FALSE]
    }, rownames = TRUE)


    # send the theme to javascript
    observe({
      session$sendCustomMessage(type = "theme-select", message = input$theme)
    })

  }
)
