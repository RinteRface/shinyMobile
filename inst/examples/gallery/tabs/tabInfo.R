tabInfo <- f7Tab(
  tabName = "Popups",
  icon = f7Icon("info_round_fill"),

  f7Align(
    side = "center",
    h1("miniUI 2.0 brings interesting popups windows")
  ),

  # popup
  f7BlockTitle(title = "f7Popup") %>% f7Align(side = "center"),
  f7Popup(
    id = "popup1",
    label = "Open",
    title = "My first popup",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
         Quisque ac diam ac quam euismod porta vel a nunc. Quisque sodales
         scelerisque est, at porta justo cursus ac"
  ),
  br(),


  # sheet
  f7BlockTitle(title = "f7Sheet") %>% f7Align(side = "center"),
  f7Block(
    f7Sheet(
      id = "sheet1",
      label = "More",
      orientation = "bottom",
      swipeToClose = TRUE,
      swipeToStep = TRUE,
      backdrop = TRUE,
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      hiddenItems = tagList(
        f7Slider(
          inputId = "sheetObs",
          label = "Number of observations",
          max = 100,
          min = 0,
          value = 10,
          scale = TRUE
        ),
        plotOutput("sheetPlot", height = "200px")
      )
    )
  ),


  br(),
  # action sheet
  f7BlockTitle(title = "Action Sheet") %>% f7Align("center"),
  f7Block(
    f7Button(inputId = "goActionSheet", "Show action sheet", color = "red")
  ),


  br(),
  # dialog
  f7BlockTitle(title = "Modal Dialog") %>% f7Align("center"),

  uiOutput("promptres"),
  f7Segment(
    container = "segment",
    f7Button(inputId = "goDialog1", "Open dialog 1", color = "yellow"),
    f7Button(inputId = "goDialog2", "Open confirm dialog 2", color = "blue"),
    f7Button(inputId = "goDialog3", "Open prompt dialog 3")
  ),


  br(),
  # notifications
  f7BlockTitle(title = "Notifications") %>% f7Align("center"),

  f7Segment(
    container = "segment",
    f7Button(inputId = "goNotif1", "Open notification 1", color = "orange"),
    f7Button(inputId = "goNotif2", "Open notification 2", color = "purple"),
    f7Button(inputId = "goNotif3", "Open notification 3")
  ),

  br(),

  # popovers
  f7BlockTitle(title = "Popovers") %>% f7Align("center"),
  f7Block(
    f7PopoverTarget(
      f7Button(
        inputId = "popoverButton",
        "Click me!"
      ),
      targetId = "popoverTrigger"
    )
  ),

  br(),

  # toasts
  f7BlockTitle(title = "Toasts") %>% f7Align("center"),
  f7Block(f7Button(inputId = "toast", label = "Open Toast", color = "lime")),

  br(),

  # Tooltips
  f7BlockTitle(title = "Tooltips") %>% f7Align("center"),
  f7Tooltip(
    f7Badge("Hover on me", color = "pink"),
    text = "A tooltip!"
  )
)
