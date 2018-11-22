#' Create a Framework7 gauge
#'
#' Build a Framework7 gauge
#'
#' @param ... Any text.
#' @param id Gauge ID.
#' @param type Gauge type. Can be "circle" or "semicircle". Default is "circle."
#' @param value Gauge value/percentage. Must be a number between 0 and 1. Default is 0.
#' @param size Generated SVG image size (in px). Default is 200.
#' @param bgColor Gauge background color. Can be any valid color string, e.g. #ff00ff, rgb(0,0,255), etc. Default is "transparent".
#' @param borderBgColor Main border/stroke background color.
#' @param borderColor Main border/stroke color.
#' @param borderWidth Main border/stroke width.
#' @param text Gauge value text (large text in the center of gauge).
#' @param textColor Value text color.
#' @param fontSize Value text font size.
#' @param fontWeight Value text font weight.
#' @param labelText Gauge additional label text.
#' @param labelTextColor Label text color.
#' @param labelFontSize Label text font size.
#' @param labelFontWeight Label text font weight.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     title = "My app",
#'     f7Gauge(id = "ID", type  = "semircircle", value = 10,
#'       textcolor = "#2196f3", bgcolor = "#2196f3",
#'       text = "Hello", label = "label")
#'   ),
#'   server = function(input, output) {}
#'  )
#' }
#'
#' @note not working yet
#'
#' @author David Granjon and Isabelle Rudolf, \email{dgranjon@@ymail.com}
#'
#' @export
f7Gauge <- function(..., id, type = NULL, value = NULL, size = NULL, bgColor = NULL,
                    borderBgColor = NULL, borderColor = NULL, borderWidth = NULL,
                    text = NULL, textColor = NULL, fontSize = NULL,
                    fontWeight = NULL, labelText = NULL, labelTextColor = NULL,
                    labelFontSize = NULL, labelFontWeight = NULL) {

  gaugeCl <- "gauge gauge-init"

  innerTag <- dropNulls(
    list(
      shiny::tags$div(
        id = id,
        class = gaugeCl,
        `data-type` = type,
        `data-value` = value,
        `data-size` = size,
        `data-bg-color` = bgColor,
        `data-border-bg-color` = borderBgColor,
        `data-border-color` = borderColor,
        `data-border-width` = borderWidth,
        `data-value-text` = text,
        `data-value-text-color` = textColor,
        `data-value-text-font-size` = fontSize,
        `data-value-text-font-weight` = fontWeight,
        `data-label-text` = labelText,
        `data-label-text-color` = labelTextColor,
        `data-label-font-size` = labelFontSize,
        `data-label-font-weight` = labelFontWeight
      )
    )
  )

  innerTag
  #outerTag <- shiny::tags$div(
  #  class = "block block-strong text-align-center",
  #  shiny::tags$div(
  #    class = "row",
  #    shiny::tags$div(
  #      class = "col text-align-center",
  #      innerTag
  #    )
  #  )
  #)


}
