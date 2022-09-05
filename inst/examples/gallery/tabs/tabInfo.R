tabInfo <- f7Tab(
  tabName = "Popups",
  icon = f7Icon("info_round_fill"),

  # # pull to refresh
  # f7BlockTitle(title = "Pull to refresh") %>% f7Align(side = "center"),
  # f7Block(
  #   strong = TRUE,
  #   inset = TRUE,
  #   "Pull the screen from top to bottom to activate
  #   the pull to refresh feature. This will raise a modal dialog but
  #   may be combined to generate any other interactions, adding new UI
  #   elements dynamically, ... Access the pull to refresh state with
  #   input$ptr. input$ptr will only take the TRUE value when activated and NULL
  #   when released, so that it is ignored by observeEvent
  #   (unless ignoreNULL is FALSE)."
  # ),

  # popup
  f7BlockTitle(title = "f7Popup") %>% f7Align(side = "center"),
  f7Block(f7Button("togglePopup", "Toggle Popup")),
  br(),


  # sheet
  f7BlockTitle(title = "f7Sheet") %>% f7Align(side = "center"),
  f7Block(
    f7Button("toggleSheet", "Toggle Sheet"),
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
    f7Button(
      inputId = "popoverButton",
      "Click me!"
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
