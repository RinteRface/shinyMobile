tabTags <- f7Tab(
  tabName = "Tags",
  icon = "flag",

  f7Align(
    side = "center",
    h1("miniUI 2.0 brings new badges")
  ),

  f7Block(
    strong = TRUE,
    f7Badge(32, color = "blue"),
    f7Badge("Badge", color = "green")
  )

)
