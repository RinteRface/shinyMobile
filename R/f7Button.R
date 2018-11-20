#' Create a Framework7 button
#'
#' Build a Framework7 button
#'
#' @param ... Button text.
#' @param src Button link.
#' @param color Button color. See here for valid colors \url{https://framework7.io/docs/badge.html}.
#' @param fill Fill style. FALSE by default.
#' @param outline Outline style. FALSE by default.
#' @param shadow Button shadow. FALSE by default. Only for material design.
#' @param rounded Round style. FALSE by default.
#' @param size Button size. NULL by default but also "big" or "small".
#'
#' @note Not ready for production
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     title = "My app",
#'     f7Button(color = "blue", "My button", src = "https://www.google.com"),
#'     f7Button(color = "red", "My button", src = "https://www.google.com", fill = TRUE)
#'   ),
#'   server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Button <- function(..., src, color = NULL, fill = FALSE, outline = FALSE,
                     shadow = FALSE, rounded = FALSE, size = NULL) {

  buttonCl <- "button"
  if (!is.null(color)) buttonCl <- paste0(buttonCl, " color-", color)
  if (fill) buttonCl <- paste0(buttonCl, " button-fill")
  if (outline) buttonCl <- paste0(buttonCl, " button-outline")
  if (shadow) buttonCl <- paste0(buttonCl, " button-raised")
  if (rounded) buttonCl <- paste0(buttonCl, " button-round")
  if (!is.null(size)) buttonCl <- paste0(buttonCl, " button-", size)


  buttonTag <- shiny::tags$a(
    class = buttonCl,
    href = src,
    target = "_blank",
    ...
  )
  return(buttonTag)
}









