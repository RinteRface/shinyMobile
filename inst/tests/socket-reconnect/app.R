library(shiny)
library(shinyMobile)

shinyApp(
  ui = f7Page(
    color = "pink",
    title = "shinyReconnect",
    icon = "apple-touch-icon.png",
    favicon = "favicon.png",
    manifest = "manifest.json",
    f7SingleLayout(
      navbar = f7Navbar(title = "f7Fabs"),
      tags$head(tags$script(src = "reconnect.js")),
      f7Fabs(
        position = "center-center",
        color = "purple",
        sideOpen = "center",
        lapply(1:4, function(i) f7Fab(paste0("btn", i), i))
      ),
      lapply(1:4, function(i) verbatimTextOutput(paste0("res", i))),
    )
  ),
  server = function(input, output, session) {
    #session$allowReconnect("force")
    lapply(1:4, function(i) {
      output[[paste0("res", i)]] <- renderPrint(input[[paste0("btn", i)]])
    })
  }
)
