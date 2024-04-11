library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Update message bar",
    f7SingleLayout(
      navbar = f7Navbar(
        title = "Message bar",
        hairline = FALSE,
        shadow = TRUE
      ),
      toolbar = f7Toolbar(
        position = "bottom",
        f7Link(label = "Link 1", href = "https://www.google.com"),
        f7Link(label = "Link 2", href = "https://www.google.com")
      ),
      # main content
      f7Segment(
        f7Button("updateMessageBar", "Update value"),
        f7Button("updateMessageBarPlaceholder", "Update placeholder")
      ),
      f7MessageBar(inputId = "mymessagebar", placeholder = "Message"),
      uiOutput("messageContent")
    )
  ),
  server = function(input, output, session) {
    output$messageContent <- renderUI({
      req(input$mymessagebar)
      tagList(
        f7BlockTitle("Message Content", size = "large"),
        f7Block(strong = TRUE, inset = TRUE, input$mymessagebar)
      )
    })
    observeEvent(input$updateMessageBar, {
      updateF7MessageBar(
        inputId = "mymessagebar",
        value = "sjsjsj"
      )
    })
    observeEvent(input$updateMessageBarPlaceholder, {
      updateF7MessageBar(
        inputId = "mymessagebar",
        placeholder = "Enter your message"
      )
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
