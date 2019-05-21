tabSegments <- f7Tab(
  tabName = "Segments",
  icon = "keyboard_fill",

  f7Align(
    side = "center",
    h1("miniUI 2.0 brings new buttons containers")
  ),

  f7Segment(
    container = "row",
    f7Button(color = "blue", label = "My button", fill = FALSE),
    f7Button(color = "green", label = "My button", src = "http://www.google.com", fill = FALSE),
    f7Button(color = "yellow", label = "My button", fill = FALSE)
  ),
  f7BlockTitle(title = "Filled Buttons in a segment/rounded container"),
  f7Segment(
    rounded = TRUE,
    container = "segment",
    f7Button(color = "black", label = "Action Button", inputId = "button2"),
    f7Button(color = "green", label = "My button", src = "http://www.google.com"),
    f7Button(color = "yellow", label = "My button")
  ),
  f7BlockTitle(title = "Outline Buttons in a segment/shadow container"),
  f7Segment(
    shadow = TRUE,
    container = "segment",
    f7Button(label = "My button", outline = TRUE),
    f7Button(label = "My button", outline = TRUE),
    f7Button(label = "My button", outline = TRUE)
  ),
  f7BlockTitle(title = "Rounded Buttons in a segment container"),
  f7Segment(
    container = "segment",
    f7Button(color = "blue", label = "My button", rounded = TRUE),
    f7Button(color = "green", label = "My button", rounded = TRUE),
    f7Button(color = "yellow", label = "My button", rounded = TRUE)
  ),
  f7BlockTitle(title = "Buttons of different size in a row container"),
  f7Segment(
    container = "row",
    f7Button(color = "pink", label = "My button", shadow = TRUE),
    f7Button(color = "purple", label = "My button", size = "large", shadow = TRUE),
    f7Button(color = "orange", label = "My button", size = "small", shadow = TRUE)
  ),

  br(), br(),
  f7BlockTitle(title = "Click on the black action button to update the value"),
  verbatimTextOutput("val")
)
