library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Update f7Fabs",
    f7SingleLayout(
      navbar = f7Navbar(title = "Update f7Fabs"),
      toolbar = f7Toolbar(
        position = "bottom",
        lapply(1:3, function(i) f7Link(label = i, href = "#") |> f7FabClose())
      ) |> f7FabMorphTarget(),
      # put an empty f7Fabs container
      f7Fabs(
        id = "fabsMorph",
        extended = TRUE,
        label = "Open",
        position = "center-bottom",
        color = "yellow",
        sideOpen = "right",
        morphTarget = ".toolbar"
      ),
      f7Block(f7Button(inputId = "toggle", label = "Toggle Fabs")),
      f7Fabs(
        position = "center-center",
        id = "fabs",
        lapply(1:3, function(i) f7Fab(inputId = i, label = i))
      ),
      textOutput("res")
    )
  ),
  server = function(input, output, session) {
    output$res <- renderText(input[["1"]])

    observeEvent(input$toggle, {
      updateF7Fabs(id = "fabs")
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
