tabOthers <- f7Tab(
  tabName = "Others",
  icon = f7Icon("more_round"),

  f7Align(
    side = "center",
    h1("miniUI 2.0 brings other elements")
  ),

  # Badges
  f7BlockTitle(title = "f7Badge") %>% f7Align(side = "center"),
  f7Block(
    strong = TRUE,
    f7Badge(32, color = "purple"),
    f7Badge("Badge", color = "green"),
    f7Badge(10, color = "teal"),
    f7Badge("Ok", color = "orange")
  ),
  br(),

  # accordion
  f7BlockTitle(title = "f7Accordion") %>% f7Align(side = "center"),
  f7Accordion(
    mode = "list",
    f7AccordionItem(
      title = "Item 1",
      "Item 1 content"
    ),
    f7AccordionItem(
      title = "Item 2",
      "Item 2 content"
    )
  ),
  br(),

  # swiper
  f7BlockTitle(title = "f7Swiper") %>% f7Align(side = "center"),
  f7Swiper(
    id = "my-swiper",
    f7Slide(
      plot_ly(z = ~volcano, type = "contour")
    ),
    f7Slide(
      plot_ly(data = iris, x = ~Sepal.Length, y = ~Petal.Length)
    )
  ),

  br(), br(), br(),

  # timelines
  f7BlockTitle(title = "f7Timeline") %>% f7Align(side = "center"),
  f7Timeline(
    sides = TRUE,
    f7TimelineItem(
      "Another text",
      date = "01 Dec",
      card = FALSE,
      time = "12:30",
      title = "Title",
      subtitle = "Subtitle",
      side = "left"
    ),
    f7TimelineItem(
      "Another text",
      date = "02 Dec",
      card = TRUE,
      time = "13:00",
      title = "Title",
      subtitle = "Subtitle"
    ),
    f7TimelineItem(
      "Another text",
      date = "03 Dec",
      card = FALSE,
      time = "14:45",
      title = "Title",
      subtitle = "Subtitle"
    )
  ),
  br(),

  # progress bars
  f7BlockTitle(title = "f7Progress") %>% f7Align(side = "center"),
  f7Block(
    strong = TRUE,
    f7Progress(id = "pg1", value = 10, color = "yellow"),
    f7Progress(id = "pg2", value = 100, color = "green"),
    f7Progress(id = "pg3", value = 50, color = "deeppurple"),
    f7ProgressInf()
  ),
  br(),


  # gauges
  f7BlockTitle(title = "f7Gauge") %>% f7Align(side = "center"),
  f7Block(
    strong = TRUE,
    f7Row(
      f7Col(
        f7Gauge(
          id = "mygauge1",
          type  = "semicircle",
          value = 0.5,
          borderColor = "#2196f3",
          borderWidth = 10,
          valueText = "50%",
          valueFontSize = 41,
          valueTextColor = "#2196f3",
          labelText = "amount of something"
        )
      ),
      f7Col(
        f7Gauge(
          id = "mygauge2",
          type  = "circle",
          value = 0.3,
          borderColor = "orange",
          borderWidth = 10,
          valueText = "30%",
          valueFontSize = 41,
          valueTextColor = "orange",
          labelText = "Other thing"
        )
      )
    )
  )
)

