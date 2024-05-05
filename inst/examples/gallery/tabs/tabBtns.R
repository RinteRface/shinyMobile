tabBtns <- f7Tab(
  title = "Buttons",
  tabName = "FABs",
  icon = f7Icon("circle_grid_hex"),
  active = FALSE,

  # FABS
  f7BlockTitle(title = "Floating Action Button (FAB) inputs"),
  f7Block(
    lapply(1:12, function(i) textOutput(paste0("res", i)))
  ),
  f7Fabs(
    global = TRUE,
    position = "right-top",
    color = "yellow",
    sideOpen = "bottom",
    lapply(1:4, function(i) f7Fab(paste0("btn", i), label = i, flag = paste0("btn", i)))
  ),
  f7Fabs(
    extended = TRUE,
    label = "Menu",
    position = "center-center",
    color = "purple",
    sideOpen = "center",
    lapply(5:8, function(i) f7Fab(inputId = paste0("btn", i), label = i))
  ),
  f7Fabs(
    position = "left-bottom",
    color = "pink",
    sideOpen = "top",
    lapply(9:12, function(i) f7Fab(paste0("btn", i), label = i, flag = paste0("btn", i)))
  ),
  # segments
  f7BlockTitle(title = "Buttons in a segment container"),
  f7Segment(
    f7Button(color = "purple", label = "My button", fill = FALSE),
    f7Button(color = "blue", label = "My button", href = "https://www.google.com", fill = FALSE),
    f7Button(color = "orange", label = "My button", fill = FALSE)
  ),
  f7BlockTitle(title = "Tonal Buttons in a segment container"),
  f7Segment(
    f7Button(color = "black", label = "My button", tonal = TRUE),
    f7Button(color = "yellow", label = "My button", tonal = TRUE),
    f7Button(color = "green", label = "My button", tonal = TRUE)
  ),
  f7BlockTitle(title = "Filled Buttons in a segment container"),
  f7Segment(
    f7Button(color = "purple", label = "Action Button", inputId = "button2"),
    f7Button(color = "blue", label = "My button", href = "https://www.google.com"),
    f7Button(color = "orange", label = "My button")
  ),
  f7BlockTitle(title = "Outline Buttons in a segment/shadow container"),
  f7Segment(
    shadow = TRUE,
    f7Button(label = "My button", outline = TRUE, fill = FALSE, shadow = TRUE),
    f7Button(label = "My button", outline = TRUE, fill = FALSE, shadow = TRUE),
    f7Button(label = "My button", outline = TRUE, fill = FALSE, shadow = TRUE)
  ),
  f7BlockTitle(title = "Rounded Buttons in a segment/rounded container"),
  f7Segment(
    rounded = TRUE,
    f7Button(color = "black", label = "My button", rounded = TRUE),
    f7Button(color = "green", label = "My button", rounded = TRUE),
    f7Button(color = "yellow", label = "My button", rounded = TRUE)
  ),
  f7BlockTitle(title = "Buttons of different size in a segment container"),
  f7Segment(
    f7Button(color = "red", label = "My button"),
    f7Button(color = "black", label = "My button", size = "large"),
    f7Button(color = "deeporange", label = "My button", size = "small")
  ),
  f7BlockTitle(title = "Buttons with icons in a segment container"),
  f7Segment(
    f7Button(color = "pink", label = "My button", icon = f7Icon("star")),
    f7Button(color = "teal", label = "My button", icon = f7Icon("house")),
    f7Button(color = "lightblue", label = "My button", icon = f7Icon("heart"))
  )
)
