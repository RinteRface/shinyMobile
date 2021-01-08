library(shiny)
library(shinyMobile)

shinyApp(
  ui = f7Page(
    title = "My app",
    options = list(pullToRefresh = TRUE),
    f7SingleLayout(
      navbar = f7Navbar(
        title = "Single Layout",
        hairline = FALSE,
        shadow = TRUE
      ),
      toolbar = f7Toolbar(
        position = "bottom",
        f7Link(label = "Link 1", href = "https://www.google.com"),
        f7Link(label = "Link 2", href = "https://www.google.com")
      ),
      # main content
      uiOutput("growingList")
    )
  ),
  server = function(input, output, session) {
    observe({
      print(input$ptr)
      print(counter())
    })

    counter <- reactiveVal(value = 1)

    observeEvent(input$ptr, {

      ptrStatus <- if (input$ptr) "on"

      f7Dialog(
        text = paste('ptr is', ptrStatus),
        type = "alert"
      )

      newValue <- counter() + 1
      counter(newValue)
    })

    output$growingList <- renderUI({
      f7List(
        lapply(seq_len(counter()), function(j) {
          f7ListItem(
            letters[j],
            media = f7Icon("alarm_fill"),
            right = "Right Text",
            header = "Header",
            footer = "Footer"
          )
        })
      )
    })

  }
)
