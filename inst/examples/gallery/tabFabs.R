tabFabs <- f7Tab(
  tabName = "FABs",
  icon = "add_round_fill",

  f7Align(
    side = "center",
    h1("miniUI 2.0 brings brand new containers for actionButtons")
  ),

  f7Fabs(
    position = "center-top",
    color = "yellow",
    sideOpen = "right",
    lapply(1:4, function(i) f7Fab(paste0("btn", i), i))
  ),
  lapply(1:4, function(i) verbatimTextOutput(paste0("res", i))),

  f7Fabs(
    position = "center-center",
    color = "purple",
    sideOpen = "center",
    lapply(5:8, function(i) f7Fab(paste0("btn", i), i))
  ),
  lapply(5:8, function(i) verbatimTextOutput(paste0("res", i))),

  f7Fabs(
    position = "left-bottom",
    color = "pink",
    sideOpen = "top",
    lapply(9:12, function(i) f7Fab(paste0("btn", i), i))
  )
)
