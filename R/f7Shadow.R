#' Create a Framework7 shadow effect
#'
#' Build a Framework7 shadow effect
#'
#' @param tag Tag to apply the shadow on.
#' @param intensity Shadow intensity. Numeric between 1 and 24. 24 is the highest elevation.
#' @param hover Whether to display the shadow on hover. FALSE by default.
#' @param pressed Whether to display the shadow on click. FALSE by default.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'     title = "Shadows",
#'     f7Init(theme = "auto"),
#'     f7Shadow(
#'      intensity = 16,
#'      hover = TRUE,
#'      pressed = TRUE,
#'      f7Card(
#'       title = "Card header",
#'       "This is a simple card with plain text,
#'        but cards can also contain their own header,
#'        footer, list view, image, or any other element.",
#'       footer = tagList(
#'        f7Button(color = "blue", "My button", src = "https://www.google.com"),
#'        f7Badge("Badge", color = "green")
#'       )
#'      )
#'     )
#'    ),
#'    server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Shadow <- function(tag, intensity, hover = FALSE, pressed = FALSE) {

  shadowCl <- if (hover) {
    if (pressed) {
      paste0("elevation-hover-", intensity, " elevation-pressed-", intensity, " elevation-transition")
    } else {
      paste0("elevation-hover-", intensity, " elevation-transition")
    }
  } else {
    if (pressed) {
      paste0("elevation-pressed-", intensity, " elevation-transition")
    } else {
      paste0("elevation-", intensity)
    }
  }

  tag$attribs$class <- paste(tag$attribs$class, shadowCl)
  return(tag)
}
