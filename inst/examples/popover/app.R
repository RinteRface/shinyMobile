library(shiny)
library(shinyMobile)

lorem_ipsum <- "Lorem ipsum dolor sit amet,
           consectetur adipiscing elit. Quisque ac diam ac quam euismod
           porta vel a nunc. Quisque sodales scelerisque est, at porta
           justo cursus ac."

popovers <- data.frame(
  id = paste0("target_", 1:3),
  content = paste("Popover content", 1:3, lorem_ipsum),
  stringsAsFactors = FALSE
)

app <- shinyApp(
  ui = f7Page(
    title = "f7Popover",
    f7SingleLayout(
      navbar = f7Navbar(
        title = "f7Popover"
      ),
      f7Block(
        f7Toggle(
          inputId = "toggle",
          "Enable popover",
          color = "green",
          checked = TRUE
        )
      ),
      f7Segment(
        lapply(seq_len(nrow(popovers)), function(i) {
          f7Button(
            inputId = sprintf("target_%s", i),
            sprintf("Popover target %s", i)
          )
        })
      )
    )
  ),
  server = function(input, output, session) {
    # Enable/disable (don't run first)
    observeEvent(input$toggle,
      {
        lapply(
          seq_len(nrow(popovers)),
          function(i) toggleF7Popover(id = popovers[i, "id"])
        )
      },
      ignoreInit = TRUE
    )

    # show
    lapply(seq_len(nrow(popovers)), function(i) {
      observeEvent(input[[popovers[i, "id"]]], {
        addF7Popover(
          id = popovers[i, "id"],
          options = list(
            content = popovers[i, "content"]
          )
        )
      })
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
