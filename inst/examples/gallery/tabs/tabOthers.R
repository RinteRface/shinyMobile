tabOthers <- f7Tab(
  title = "Others",
  tabName = "Others",
  icon = f7Icon("plus_circle"),

  # standalone tabs
  f7BlockTitle(title = "f7Tabs") %>% f7Align(side = "center"),
  f7Tabs(
    style = "strong",
    animated = TRUE,
    swipeable = FALSE,
    f7Tab(
      title = "Tab 1",
      tabName = "Tab1",
      active = TRUE,
      f7Block(
        strong = TRUE,
        f7BlockHeader(text = "Header"),
        "Here comes Tab 1.",
        f7BlockFooter(text = "Footer")
      )
    ),
    f7Tab(
      title = "Tab 2",
      tabName = "Tab2",
      f7Block(
        strong = TRUE,
        f7BlockHeader(text = "Header"),
        "Here comes Tab 2.",
        f7BlockFooter(text = "Footer")
      )
    ),
    f7Tab(
      title = "Tab 3",
      tabName = "Tab3",
      f7Block(
        strong = TRUE,
        f7BlockHeader(text = "Header"),
        "Here comes Tab 3.",
        f7BlockFooter(text = "Footer")
      )
    )
  ),

  # skeletons
  f7BlockTitle(title = "f7Skeleton") %>% f7Align(side = "center"),
  f7List(
    class = "skeleton-list",
    f7ListItem(title = "Item 1"),
    f7ListItem(title = "Item 2")
  ),
  br(),

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

  # chips
  f7BlockTitle(title = "f7Chip") %>% f7Align(side = "center"),
  f7Block(
    strong = TRUE,
    f7Chip(label = "Example Chip"),
    f7Chip(label = "Example Chip", outline = TRUE),
    f7Chip(label = "Example Chip", icon = f7Icon("add_round"), iconStatus = "pink"),
    f7Chip(label = "Example Chip", image = "https://picsum.photos/200"),
    f7Chip(label = "Example Chip", closable = TRUE),
    f7Chip(label = "Example Chip", status = "green"),
    f7Chip(label = "Example Chip", status = "green", outline = TRUE)
  ),
  br(),

  # accordion
  f7BlockTitle(title = "f7Accordion") %>% f7Align(side = "center"),
  f7Accordion(
    id = "accordion1",
    f7AccordionItem(
      title = "Item 1",
      f7Block("Item 1 content")
    ),
    f7AccordionItem(
      title = "Item 2",
      f7Block("Item 2 content")
    )
  ),
  f7Toggle(
    inputId = "goAccordion",
    label = "Toggle accordion item 1",
    color = "orange"
  ),
  br(),

  # swiper
  f7BlockTitle(title = "f7Swiper") %>% f7Align(side = "center"),
  f7Swiper(
    id = "my-swiper",
    f7Slide(
      plotOutput("sin")
    ),
    f7Slide(
      plotOutput("cos")
    )
  ),
  br(), br(), br(),

  # Pthoto browser trigger
  f7BlockTitle(title = "f7PhotoBrowser") %>% f7Align(side = "center"),
  f7Block(f7Button(inputId = "togglePhoto", "Open photo browser")),
  br(), br(),

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
    f7Slider(
      inputId = "updatepg1",
      label = "Update progress 1",
      max = 100,
      min = 0,
      value = 50,
      scale = TRUE
    ),
    br(),
    f7Progress(id = "pg2", value = 100, color = "green"),
    br(),
    f7Progress(id = "pg3", value = 50, color = "deeppurple")
  ),
  br(),


  # gauges
  f7BlockTitle(title = "f7Gauge") %>% f7Align(side = "center"),
  f7Block(
    strong = TRUE,
    f7Grid(
      cols = 2,
      f7Gauge(
        id = "mygauge1",
        type = "semicircle",
        value = 50,
        borderColor = "#2196f3",
        borderWidth = 10,
        valueFontSize = 41,
        valueTextColor = "#2196f3",
        labelText = "amount of something"
      ),
      f7Gauge(
        id = "mygauge2",
        type = "circle",
        value = 30,
        borderColor = "orange",
        borderWidth = 10,
        valueFontSize = 41,
        valueTextColor = "orange",
        labelText = "Other thing"
      )
    ),
    f7Stepper(
      inputId = "updategauge1",
      label = "Update gauge 1",
      step = 10,
      min = 0,
      max = 100,
      value = 50
    )
  ),

  # update f7Panel
  br(),
  f7BlockTitle(title = "updateF7Panel") %>% f7Align(side = "center"),
  f7Block(
    f7Button(
      inputId = "goPanel",
      label = "Toggle left panel"
    )
  ),
  br(),

  # preloaders
  f7BlockTitle(title = "f7ShowPreloader/f7HidePreloader") %>% f7Align(side = "center"),
  f7Card(plotOutput("preloaderPlot"), f7Button("showLoader", "Show loader"))
)
