library(shinyF7)
library(htmltools)

f7Button <- function(..., color = NULL, fill = FALSE, outline = FALSE,
                     raised = FALSE, segmented = FALSE, round = FALSE,
                     big = FALSE, small = FALSE) {

  buttonCl <- "button"
  if (!is.null(color)) buttonCl <- paste0(buttonCl, " color-", color)
  if (fill) buttonCl <- paste0(buttonCl, " button-fill")
  if (outline) buttonCl <- paste0(buttonCl, " button-outline")
  if (raised) buttonCl <- paste0(buttonCl, " button-raised")
  if (segmented) buttonCl <- paste0(buttonCl, " button-segmented")
  if (round) buttonCl <- paste0(buttonCl, " button-round")
  if (big) buttonCl <- paste0(buttonCl, " button-big")
  if (small) buttonCl <- paste0(buttonCl, " button-small")


  buttonTag <- shiny::tags$button(
    class = buttonCl,
      shiny::tags$a(class = "bottom",
      ...
    )
  )

  return(buttonTag)
}


shiny::shinyApp(
  ui = f7Page(
    title = "My app",
    f7Button(color = "blue", "my Button"),
  ),
  server = function(input, output) {}
)
