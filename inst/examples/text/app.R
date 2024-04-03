library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    f7SingleLayout(
      navbar = f7Navbar(title = "Text inputs"),
      f7Block(f7Button("update", "Click me")),
      f7BlockTitle("A list of inputs"),
      f7List(
        outline = TRUE,
        dividers = FALSE,
        strong = TRUE,
        br(),
        f7Text(
          inputId = "text",
          label = "Text input",
          value = "Some text",
          placeholder = "Your text here",
          description = "A cool text input",
          outline = TRUE,
          media = f7Icon("house"),
          clearable = TRUE,
          floating = TRUE
        ),
        f7TextArea(
          inputId = "textarea",
          label = "Text Area",
          value = "Lorem ipsum dolor sit amet, consectetur
              adipiscing elit, sed do eiusmod tempor incididunt ut
              labore et dolore magna aliqua",
          placeholder = "Your text here",
          resize = TRUE,
          description = "A cool text area input",
          outline = TRUE,
          media = f7Icon("pencil"),
          clearable = TRUE,
          floating = TRUE
        ),
        f7Password(
          inputId = "password",
          label = "Password:",
          placeholder = "Your password here",
          description = "A cool passord input",
          outline = TRUE,
          media = f7Icon("lock"),
          clearable = TRUE,
          floating = TRUE
        )
      ),
      f7Grid(
        cols = 3,
        f7Block(
          f7BlockTitle("Text value"),
          textOutput("text_value")
        ),
        f7Block(
          f7BlockTitle("Text area value"),
          textOutput("textarea_value")
        ),
        f7Block(
          f7BlockTitle("Password value"),
          textOutput("password_value")
        )
      )
    )
  ),
  server = function(input, output, session) {
    output$text_value <- renderText(input$text)
    output$textarea_value <- renderText(input$textarea)
    output$password_value <- renderText(input$password)

    observeEvent(input$update, {
      updateF7Text(
        inputId = "text",
        value = "Updated Text"
      )
      updateTextAreaInput(
        inputId = "textarea",
        value = "",
        placeholder = "New placeholder"
      )
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
