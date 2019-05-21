tabOthers <- f7Tab(
  tabName = "Others",
  icon = "more_vertical_round_fill",

  f7Align(
    side = "center",
    h1("miniUI 2.0 brings other elements")
  ),

  # accordion
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

  # swiper
  f7Swiper(
    id = "my-swiper",
    f7Slide(
      g2(gaus, asp(x, y, color = "count")) %>%
        fig_bin(size_count = FALSE, type = "hexagon") %>%
        gauge_color(c("#BAE7FF", "#1890FF", "#0050B3"))
    ),
    f7Slide(
      g2(iris, asp(Petal.Length, group = Species, color = Species)) %>%
        fig_density()
    )
  ),

  br(), br(), br(),

  # timelines
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

  # progress bars
  f7Block(
    f7Progress(id = "pg1", value = 10, color = "pink"),
    f7Progress(id = "pg2", value = 100, color = "green"),
    f7Progress(id = "pg3", value = 50, color = "orange"),
    f7ProgressInf()
  ),


  # gauges
  f7Row(
    f7Col(
      f7Block(
        strong = TRUE,
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
      )
    ),
    f7Col(
      f7Block(
        strong = TRUE,
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

