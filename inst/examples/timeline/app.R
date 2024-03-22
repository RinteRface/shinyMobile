library(shiny)
library(shinyMobile)

items <- tagList(
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
)

app <- shinyApp(
  ui = f7Page(
    title = "Timelines",
    f7SingleLayout(
      navbar = f7Navbar(title = "Timelines"),
      f7BlockTitle(title = "Horizontal timeline", size = "large") %>%
        f7Align(side = "center"),
      f7Timeline(
        sides = FALSE,
        horizontal = TRUE,
        items
      ),
      f7BlockTitle(title = "Vertical side by side timeline", size = "large") %>%
        f7Align(side = "center"),
      f7Timeline(
        sides = TRUE,
        items
      ),
      f7BlockTitle(title = "Vertical timeline", size = "large") %>%
        f7Align(side = "center"),
      f7Timeline(items),
      f7BlockTitle(title = "Calendar timeline", size = "large") %>%
        f7Align(side = "center"),
      f7Timeline(items, calendar = TRUE, year = "2019", month = "December")
    )
  ),
  server = function(input, output) {}
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
