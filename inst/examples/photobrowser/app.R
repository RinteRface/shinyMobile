library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "f7PhotoBrowser",
    f7SingleLayout(
      navbar = f7Navbar(title = "f7PhotoBrowser"),
      f7Block(
        f7Button(inputId = "togglePhoto", "Open photo")
      )
    )
  ),
  server = function(input, output, session) {
    observeEvent(input$togglePhoto, {
      f7PhotoBrowser(
        id = "photobrowser1",
        theme = "dark",
        type = "page",
        photos = list(
          list(url = "https://cdn.framework7.io/placeholder/sports-1024x1024-1.jpg"),
          list(url = "https://cdn.framework7.io/placeholder/sports-1024x1024-2.jpg"),
          list(url = "https://cdn.framework7.io/placeholder/sports-1024x1024-3.jpg",
               caption = "Me cycling")
        ),
        thumbs = c(
          "https://cdn.framework7.io/placeholder/sports-1024x1024-1.jpg",
          "https://cdn.framework7.io/placeholder/sports-1024x1024-2.jpg",
          "https://cdn.framework7.io/placeholder/sports-1024x1024-3.jpg"
        )
      )
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
