library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Dialogs",
    f7SingleLayout(
      navbar = f7Navbar(title = "f7Dialog"),
      f7Block(
        f7Grid(
          cols = 4,
          f7Button(inputId = "alert", "Alert"),
          f7Button(inputId = "confirm", "Confirm"),
          f7Button(inputId = "prompt", "Prompt"),
          f7Button(inputId = "login", "Login")
        ),
        f7Grid(
          cols = 2,
          uiOutput("prompt_res"),
          uiOutput("login_res")
        )
      )
    )
  ),
  server = function(input, output, session) {
    observeEvent(input$alert, {
      f7Dialog(
        title = "Dialog title",
        text = "This is an alert dialog"
      )
    })

    observeEvent(input$confirm, {
      f7Dialog(
        id = "comfirm_dialog",
        title = "Dialog title",
        type = "confirm",
        text = "This is an alert dialog"
      )
    })

    observeEvent(input$comfirm_dialog, {
      f7Toast(text = paste("Alert input is:", input$comfirm_dialog))
    })

    observeEvent(input$prompt, {
      f7Dialog(
        id = "prompt_dialog",
        title = "Dialog title",
        type = "prompt",
        text = "This is a prompt dialog"
      )
    })
    output$prompt_res <- renderText({
      req(input$prompt_dialog)
      input$prompt_dialog
    })

    observeEvent(input$login, {
      f7Dialog(
        id = "login_dialog",
        title = "Dialog title",
        type = "login",
        text = "This is an login dialog"
      )
    })

    output$login_res <- renderUI({
      req(input$login_dialog$user, input$login_dialog$password)
      img(src = "https://media2.giphy.com/media/12gfL8Xxrhv7C1fXiV/giphy.gif")
    })
  }
)

app
# if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
