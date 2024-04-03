library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "My app",
    f7SingleLayout(
      navbar = f7Navbar(title = "Update autocomplete"),
      f7Block(f7Button(inputId = "update", label = "Update autocomplete")),
      f7List(
        f7AutoComplete(
          inputId = "myautocomplete",
          placeholder = "Some text here!",
          openIn = "dropdown",
          label = "Type a fruit name",
          choices = c(
            "Apple", "Apricot", "Avocado", "Banana", "Melon",
            "Orange", "Peach", "Pear", "Pineapple"
          )
        )
      ),
      f7Block(verbatimTextOutput("autocompleteval"))
    )
  ),
  server = function(input, output, session) {
    output$autocompleteval <- renderText(input$myautocomplete)

    observeEvent(input$update, {
      updateF7AutoComplete(
        inputId = "myautocomplete",
        value = "plip",
        choices = c("plip", "plap", "ploup")
      )
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
