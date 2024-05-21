library(shiny)
library(shinyMobile)

searchModuleUI <- function(id) {
  ns <- NS(id)
  f7Tab(
    title = "test",
    tabName = "test",
    f7Searchbar(id = ns("search1")),
    f7VirtualList(
      id = ns("vlist"),
      strong = TRUE,
      dividers = TRUE,
      items = lapply(1:1000, function(i) {
        f7VirtualListItem(
          id = paste0("vlist-item-", i),
          title = paste("Title", i),
          subtitle = paste("Subtitle", i),
          header = paste("Header", i),
          footer = paste("Footer", i),
          right = paste("Right", i),
          paste0("Content", i),
          media = img(style = "border-radius: 8px",
                      src = "https://cdn.framework7.io/placeholder/fashion-88x88-1.jpg")
        )
      })
    )
  )
}

shinyApp(
  ui = f7Page(
    title = "Virtual List",
    f7TabLayout(
      navbar = f7Navbar(
        title = "SlamStats",
        leftPanel = TRUE,
        rightPanel = tagList(
          tags$a(
            class = "link icon-only panel-open",
            `data-panel` = "right",
            f7Icon("gear_alt")
          )
        )
      ),
      panels = tagList(
        f7Panel(title = "Left Panel",
                side = "left",
                "Blabla",
                effect = "reveal"),
        f7Panel(title = "Right Panel",
                side = "right",
                "Blabla",
                effect = "push")
      ),
      f7Tabs(
        animated = TRUE,
        searchModuleUI("test")
      )
    )
  ),
  server = function(input, output) {

  }
)
