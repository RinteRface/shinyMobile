library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    f7SingleLayout(
      navbar = f7Navbar(title = "Inputs form"),
      f7Block(f7Button("update", "Click me")),
      f7BlockTitle("A list of inputs in a form"),
      f7List(
        inset = TRUE,
        dividers = FALSE,
        strong = TRUE,
        f7Form(
          id = "myform",
          f7Text(
            inputId = "text",
            label = "Text input",
            value = "Some text",
            placeholder = "Your text here",
            style = list(
              description = "A cool text input",
              outline = TRUE,
              media = f7Icon("house"),
              clearable = TRUE,
              floating = TRUE
            )
          ),
          f7TextArea(
            inputId = "textarea",
            label = "Text Area",
            value = "Lorem ipsum dolor sit amet, consectetur
              adipiscing elit, sed do eiusmod tempor incididunt ut
              labore et dolore magna aliqua",
            placeholder = "Your text here",
            resize = TRUE,
            style = list(
              description = "A cool text input",
              outline = TRUE,
              media = f7Icon("house"),
              clearable = TRUE,
              floating = TRUE
            )
          ),
          f7Password(
            inputId = "password",
            label = "Password:",
            placeholder = "Your password here",
            style = list(
              description = "A cool text input",
              outline = TRUE,
              media = f7Icon("house"),
              clearable = TRUE,
              floating = TRUE
            )
          )
        )
      ),
      verbatimTextOutput("form")
    )
  ),
  server = function(input, output, session) {
    output$form <- renderPrint(input$myform)

    observeEvent(input$update, {
      updateF7Form(
        "myform",
        data = list(
          "text" = "New text",
          "textarea" = "New text area",
          "password" = "New password"
        )
      )
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
