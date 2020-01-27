library(shiny)
library(shinyMobile)

shiny::shinyApp(
  ui = f7Page(
    title = "My app",
    init = f7Init(pullToRefresh = TRUE, theme = "light"),
    f7SingleLayout(
      navbar = f7Navbar(
        title = "Single Layout",
        hairline = FALSE,
        shadow = TRUE
      ),
      toolbar = f7Toolbar(
        position = "bottom",
        f7Link(label = "Link 1", src = "https://www.google.com"),
        f7Link(label = "Link 2", src = "https://www.google.com", external = TRUE)
      ),
      # main content
      f7List(
        lapply(1:3, function(j) {
          f7ListItem(
            letters[j],
            media = f7Icon("alarm_fill"),
            right = "Right Text",
            header = "Header",
            footer = "Footer"
          )
        })
      )
    )
  ),
  server = function(input, output, session) {
    observe(print(input$ptr))

    observeEvent(input$ptr, {

      ptrStatus <- if (input$ptr) "on"

      f7Dialog(
        session = session,
        text = paste('ptr is', ptrStatus),
        type = "alert"
      )
    })
  }
)
