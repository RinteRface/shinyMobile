library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "My app",
    f7TabLayout(
      navbar = f7Navbar(title = "Update pickers"),
      f7Tabs(
        f7Tab(
          title = "Standalone",
          tabName = "standalone",
          f7Segment(
            f7Button(inputId = "update", label = "Update picker"),
            f7Button(
              inputId = "removeToolbar",
              label = "Remove picker toolbars",
              color = "red"
            )
          ),
          f7Picker(
            inputId = "picker",
            placeholder = "Some text here!",
            label = "Picker Input",
            choices = c("a", "b", "c"),
            options = list(sheetPush = TRUE),
            style = list(strong = TRUE)
          ),
          f7Block(verbatimTextOutput("pickerval"))
        ),
        f7Tab(
          title = "List",
          tabName = "list",
          f7List(
            strong = TRUE,
            f7Picker(
              inputId = "picker2",
              placeholder = "Some text here!",
              label = "Picker Input",
              choices = c("a", "b", "c"),
              options = list(sheetPush = TRUE)
            )
          ),
          f7Block(verbatimTextOutput("pickerval2"))
        )
      )
    )
  ),
  server = function(input, output, session) {
    output$pickerval <- renderText(input$picker)
    output$pickerval2 <- renderText(input$picker2)

    observeEvent(input$update, {
      updateF7Picker(
        inputId = "picker",
        value = "b",
        choices = letters,
        openIn = "sheet",
        toolbarCloseText = "Close me",
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
