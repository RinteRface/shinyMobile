tabOthers <- f7Tab(
  tabName = "Others",
  icon = f7Icon("more_round"),

  f7Align(
    side = "center",
    h1("miniUI 2.0 brings other elements")
  ),

  # skeletons
  f7BlockTitle(title = "f7Skeleton") %>% f7Align(side = "center"),
  f7List(
    f7ListItem(title = "Item 1"),
    f7ListItem(title = "Item 2")
  ) %>% f7Skeleton(duration = 5000),

  br(),

  # Messages
  f7BlockTitle(title = "f7Messages") %>% f7Align(side = "center"),
  f7Messages(
    id = "messagelist",
    f7Message(
      "Lorem ipsum dolor sit amet,
           consectetur adipiscing elit.
           Duo Reges: constructio interrete",
      src = "https://cdn.framework7.io/placeholder/people-100x100-7.jpg",
      author = "David",
      date = "2019-09-12",
      state = "received",
      type = "text"
    ),
    f7Message(
      "https://cdn.framework7.io/placeholder/cats-200x260-4.jpg",
      src = "https://cdn.framework7.io/placeholder/people-100x100-9.jpg",
      author = "Lia",
      date = NULL,
      state = "sent",
      type = "img"
    ),
    f7Message(
      "Hi Bro",
      src = "https://cdn.framework7.io/placeholder/people-100x100-9.jpg",
      author = NULL,
      date = "2019-08-15",
      state = "sent",
      type = "text"
    )
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
    f7Chip(label = "Example Chip", icon = f7Icon("add_round"), icon_status = "pink"),
    f7Chip(label = "Example Chip", img = "https://picsum.photos/200"),
    f7Chip(label = "Example Chip", closable = TRUE),
    f7Chip(label = "Example Chip", status = "green"),
    f7Chip(label = "Example Chip", status = "green", outline = TRUE)
  ),
  br(),

  # accordion
  f7BlockTitle(title = "f7Accordion") %>% f7Align(side = "center"),
  f7Accordion(
    inputId = "accordion1",
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
      plot_ly(z = ~volcano, type = "contour")
    ),
    f7Slide(
      plot_ly(data = iris, x = ~Sepal.Length, y = ~Petal.Length)
    )
  ),

  br(), br(), br(),

  # timelines
  f7BlockTitle(title = "f7PhotoBrowser") %>% f7Align(side = "center"),
  f7Block(
    f7PhotoBrowser(
      id = "photobrowser1",
      label = "Open",
      theme = "light",
      type = "standalone",
      photos = c(
        "https://cdn.framework7.io/placeholder/sports-1024x1024-1.jpg",
        "https://cdn.framework7.io/placeholder/sports-1024x1024-2.jpg",
        "https://cdn.framework7.io/placeholder/sports-1024x1024-3.jpg"
      )
    )
  ),
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
    f7Progress(id = "pg3", value = 50, color = "deeppurple"),
    br(),
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
          value = 50,
          borderColor = "#2196f3",
          borderWidth = 10,
          valueFontSize = 41,
          valueTextColor = "#2196f3",
          labelText = "amount of something"
        )
      ),
      f7Col(
        f7Gauge(
          id = "mygauge2",
          type  = "circle",
          value = 30,
          borderColor = "orange",
          borderWidth = 10,
          valueFontSize = 41,
          valueTextColor = "orange",
          labelText = "Other thing"
        )
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
  )

)

