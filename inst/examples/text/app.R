library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    f7SingleLayout(
      navbar = f7Navbar(title = "Text inputs"),
      f7Block(f7Button("update", "Click me")),
      f7Block(
        strong = TRUE,
        inline = TRUE,
        f7BlockTitle("Text Input"),
        f7Text(
          inputId = "text",
          label = "Caption",
          value = "Some text",
          placeholder = "Your text here"
        ),
        textOutput("text_value")
      ),
      f7Block(
        strong = TRUE,
        inline = TRUE,
        f7BlockTitle("Text Area Input"),
        f7TextArea(
          inputId = "textarea",
          label = "Text Area",
          value = "Lorem ipsum dolor sit amet, consectetur
              adipiscing elit, sed do eiusmod tempor incididunt ut
              labore et dolore magna aliqua",
          placeholder = "Your text here",
          resize = TRUE
        ),
        textOutput("textarea_value")
      ),
      f7Block(
        strong = TRUE,
        inline = TRUE,
        f7BlockTitle("Password Input"),
        f7Password(
          inputId = "password",
          label = "Password:",
          placeholder = "Your password here"
        ),
        textOutput("password_value")
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
