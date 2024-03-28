library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Update radio",
    f7SingleLayout(
      navbar = f7Navbar(title = "Update f7Radio"),
      f7Block(f7Button("update", "Update radio")),
      f7Block(
        f7Radio(
          inputId = "radio",
          label = "Choose a fruit:",
          choices = c("banana", "apple", "peach"),
          selected = "apple",
          position = "right"
        ),
        textOutput("res")
      ),
      f7Block(
        f7Radio(
          inputId = "radio2",
          label = "Custom choices",
          choices = list(
            f7RadioChoice(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
            Nulla sagittis tellus ut turpis condimentum,
            ut dignissim lacus tincidunt",
              title = "Choice 1",
              subtitle = "David",
              after = "March 16, 2024"
            ),
            f7RadioChoice(
              "Cras dolor metus, ultrices condimentum sodales sit
            amet, pharetra sodales eros. Phasellus vel felis tellus.
            Mauris rutrum ligula nec dapibus feugiat",
              title = "Choice 2",
              subtitle = "Veerle",
              after = "March 17, 2024"
            )
          ),
          selected = 2,
          outline = TRUE,
          strong = TRUE,
          inset = TRUE,
          dividers = TRUE
        ),
        textOutput("res2")
      )
    )
  ),
  server = function(input, output, session) {
    output$res <- renderText(input$radio)
    output$res2 <- renderText(input$radio2)

    observeEvent(input$update, {
      updateF7Radio(
        session,
        inputId = "radio",
        label = "New label",
        choices = colnames(mtcars),
        selected = colnames(mtcars)[1]
      )
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
