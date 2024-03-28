library(shiny)
library(shinyMobile)

items <- tagList(
  lapply(1:5,
         function(i) {
           f7TimelineItem(
             paste0("Another text ", i),
             date = paste0(i, " Dec"),
             card = i %% 2 == 0,
             time = paste0(10 + i, ":30"),
             title = paste0("Title", i),
             subtitle = paste0("Subtitle", i),
             side = ifelse(i %% 2 == 0, "left", "right")
           )
         }
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
