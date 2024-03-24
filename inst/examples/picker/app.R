library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "My app",
    f7SingleLayout(
      navbar = f7Navbar(title = "Update picker"),
      f7Segment(
        f7Button(inputId = "update", label = "Update picker"),
        f7Button(
          inputId = "removeToolbar",
          label = "Remove picker toolbar",
          color = "red"
        )
      ),
      f7Picker(
        inputId = "picker",
        placeholder = "Some text here!",
        label = "Picker Input",
        choices = c("a", "b", "c"),
        options = list(sheetPush = TRUE)
      ),
      f7Block(verbatimTextOutput("pickerval"))
    )
  ),
  server = function(input, output, session) {
    output$pickerval <- renderText(input$mypicker)

    observeEvent(input$update, {
      updateF7Picker(
        inputId = "picker",
        value = "b",
        choices = letters,
        openIn = "sheet",
        toolbarCloseText = "Prout",
        sheetSwipeToClose = TRUE
      )
    })

    observeEvent(input$removeToolbar, {
      updateF7Picker(
        inputId = "picker",
        value = "b",
        choices = letters,
        openIn = "sheet",
        toolbar = FALSE
      )
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
