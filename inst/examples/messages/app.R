library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Messages",
    f7SingleLayout(
      navbar = f7Navbar(
        title = "Messages",
        hairline = FALSE,
        shadow = TRUE
      ),
      toolbar = f7MessageBar(inputId = "mymessagebar", placeholder = "Message"),
      # main content
      f7Messages(id = "mymessages", title = "My message")
    )
  ),
  server = function(input, output, session) {
    observe({
      print(input$mymessages)
    })
    # Send a message
    observeEvent(input[["mymessagebar-send"]], {
      updateF7Messages(
        id = "mymessages",
        list(
          f7Message(
            text = input$mymessagebar,
            name = "David",
            type = "sent",
            header = "Message Header",
            footer = "Message Footer",
            textHeader = "Text Header",
            textFooter = "text Footer",
            avatar = "https://cdn.framework7.io/placeholder/people-100x100-7.jpg"
          )
        )
      )
    })

    # Receive a message
    observeEvent(TRUE, {
      updateF7Messages(
        id = "mymessages",
        showTyping = FALSE, # DOES NOT WORK YET WHEN TRUE ...
        list(
          f7Message(
            text = "Some message",
            name = "Victor",
            type = "received",
            avatar = "https://cdn.framework7.io/placeholder/people-100x100-9.jpg"
          )
        )
      )
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
