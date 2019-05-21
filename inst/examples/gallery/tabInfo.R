tabInfo <- f7Tab(
  tabName = "Popups",
  icon = "info_round_fill",

  f7Align(
    side = "center",
    h1("miniUI 2.0 brings interesting popups windows")
  ),

  # popup
  f7Popup(
    id = "popup1",
    label = "Open",
    title = "My first popup",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
         Quisque ac diam ac quam euismod porta vel a nunc. Quisque sodales
         scelerisque est, at porta justo cursus ac"
  ),


  # sheet
  f7Sheet(
    id = "sheet1",
    label = "More",
    orientation = "bottom",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        Quisque ac diam ac quam euismod porta vel a nunc. Quisque sodales
        scelerisque est, at porta justo cursus ac"
  )

)
