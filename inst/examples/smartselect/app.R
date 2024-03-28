library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Update f7SmartSelect",
    f7SingleLayout(
      navbar = f7Navbar(title = "Update f7SmartSelect"),
      f7Block(f7Button("update", "Update Smart Select")),
      f7SmartSelect(
        inputId = "smartselect",
        label = "Choose a variable:",
        choices = split(colnames(mtcars[-1]), rep(1:5)),
        openIn = "popup"
      ),
      tableOutput("data")
    )
  ),
  server = function(input, output, session) {
    output$data <- renderTable(
      mtcars[, c("mpg", input$smartselect), drop = FALSE],
      rownames = TRUE
    )

    observeEvent(input$update, {
      updateF7SmartSelect(
        inputId = "smartselect",
        openIn = "sheet",
        selected = "hp",
        choices = c("hp", "gear", "carb"),
        multiple = TRUE,
        maxLength = 2
      )
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
