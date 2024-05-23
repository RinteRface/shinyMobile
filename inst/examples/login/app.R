library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Login module",
    f7SingleLayout(
      navbar = f7Navbar(
        title = "Login Example"
      ),
      toolbar = f7Toolbar(
        position = "bottom",
        f7Link(label = "Link 1", href = "https://www.google.com"),
        f7Link(label = "Link 2", href = "https://www.google.com")
      ),
      f7Login(id = "login", title = "Welcome"),
      # main content
      f7BlockTitle(
        title = HTML(paste("Welcome", textOutput("user"))),
        size = "large"
      )
    )
  ),
  server = function(input, output, session) {
    loginData <- f7LoginServer(id = "login")

    exportTestValues(
      status = loginData$status(),
      user = loginData$user(),
      password = loginData$password()
    )

    output$user <- renderText({
      req(loginData$user)
      loginData$user()
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
