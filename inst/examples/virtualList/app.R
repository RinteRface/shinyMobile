library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Virtual List",
    f7SingleLayout(
      navbar = f7Navbar(
        title = "Virtual Lists",
        hairline = FALSE,
        shadow = TRUE
      ),
      # searchbar
      f7Searchbar(id = "search1"),
      # main content
      f7VirtualList(
        id = "vlist",
        rowsBefore = 2,
        rowsAfter = 2,
        items = lapply(1:2000, function(i) {
          f7VirtualListItem(
            title = paste("Title", i),
            subtitle = paste("Subtitle", i),
            header = paste("Header", i),
            footer = paste("Footer", i),
            right = paste("Right", i),
            content = i,
            media = img(src = "https://cdn.framework7.io/placeholder/fashion-88x88-1.jpg")
          )
        })
      )
    )
  ),
  server = function(input, output) {

  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
