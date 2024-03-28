library(shiny)
library(shinyMobile)

lorem_ipsum <- "Lorem ipsum dolor sit amet!"

tooltips <- data.frame(
  id = paste0("target_", 1:2),
  text = paste("Tooltip content", 1:2, lorem_ipsum),
  stringsAsFactors = FALSE
)

app <- shinyApp(
  ui = f7Page(
    title = "Tooltip",
    f7SingleLayout(
      navbar = f7Navbar(title = "f7Tooltip"),
      # Static tooltip
      f7Segment(
        f7Tooltip(
          f7Badge("Hover on me", color = "teal"),
          text = "A tooltip!"
        )
      ),
      # Dynamic tooltips
      f7Segment(
        f7Toggle(
          inputId = "toggle",
          "Enable tootlips",
          color = "deeporange",
          checked = TRUE
        )
      ),
      f7Segment(
        lapply(seq_len(nrow(tooltips)), function(i) {
          f7Button(
            inputId = sprintf("target_%s", i),
            sprintf("Target %s", i)
          )
        })
      ),
      f7Text("tooltip_text", "Tooltip new text", placeholder = "Type a text")
    )
  ),
  server = function(input, output, session) {
    # Update content
    observeEvent(input$tooltip_text, {
      lapply(seq_len(nrow(tooltips)), function(i) {
        updateF7Tooltip(
          id = tooltips[i, "id"],
          action = "update",
          text = input$tooltip_text
        )
      })
    }, ignoreInit = TRUE)

    observeEvent(input$toggle, {
      lapply(seq_len(nrow(tooltips)), function(i) {
        updateF7Tooltip(id = tooltips[i, "id"], action = "toggle")
      })
    }, ignoreInit = TRUE)

    # Create
    lapply(seq_len(nrow(tooltips)), function(i) {
      observeEvent(input[[tooltips[i, "id"]]], {
        addF7Tooltip(
          id = tooltips[i, "id"],
          options = list(
            text = tooltips[i, "text"]
          )
        )
      })
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
