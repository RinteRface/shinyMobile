#' Framework7 gauge
#'
#' \code{f7Gauge} creates a gauge instance.
#'
#' @rdname gauge
#'
#' @param id Gauge ID.
#' @param type Gauge type. Can be "circle" or "semicircle". Default is "circle."
#' @param value Gauge value/percentage. Must be a number between 0 and 100.
#' @param size Generated SVG image size (in px). Default is 200.
#' @param bgColor Gauge background color. Can be any valid color string, e.g. #ff00ff, rgb(0,0,255), etc. Default is "transparent".
#' @param borderBgColor Main border/stroke background color.
#' @param borderColor Main border/stroke color.
#' @param borderWidth Main border/stroke width.
#' @param valueText Gauge value text (large text in the center of gauge).
#' @param valueTextColor Value text color.
#' @param valueFontSize Value text font size.
#' @param valueFontWeight Value text font weight.
#' @param labelText Gauge additional label text.
#' @param labelTextColor Label text color.
#' @param labelFontSize Label text font size.
#' @param labelFontWeight Label text font weight.
#'
#' @examples
#' # Gauge
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'   ui = f7Page(
#'     title = "Gauges",
#'     f7SingleLayout(
#'      navbar = f7Navbar(title = "f7Gauge"),
#'      f7Block(
#'       f7Gauge(
#'        id = "mygauge",
#'        type  = "semicircle",
#'        value = 50,
#'        borderColor = "#2196f3",
#'        borderWidth = 10,
#'        valueFontSize = 41,
#'        valueTextColor = "#2196f3",
#'        labelText = "amount of something"
#'       )
#'      )
#'     )
#'   ),
#'   server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon \email{dgranjon@@ymail.com}
#'
#' @export
f7Gauge <- function(id, type = "circle", value, size = 200,
                    bgColor = "transparent", borderBgColor = "#eeeeee", borderColor = "#000000",
                    borderWidth = "10", valueText = NULL,
                    valueTextColor = "#000000", valueFontSize = "31",
                    valueFontWeight = "500", labelText = NULL, labelTextColor = "#888888",
                    labelFontSize = "14", labelFontWeight = "400") {

  if (is.null(valueText)) valueText <- paste(value, "%")

  gaugeProps <- dropNulls(
    list(
      type = type,
      value = value / 100,
      size = size,
      bgColor = bgColor,
      borderBgColor = borderBgColor,
      borderColor = borderColor,
      borderWidth = borderWidth,
      valueText = valueText,
      valueTextColor = valueTextColor,
      valueFontSize = valueFontSize,
      valueFontWeight = valueFontWeight,
      labelText = labelText,
      labelTextColor = labelTextColor,
      labelFontSize = labelFontSize,
      labelFontWeight = labelFontWeight
    )
  )

  gaugeConfig <- shiny::tags$script(
    type = "application/json",
    `data-for` = id,
    jsonlite::toJSON(
      x = gaugeProps,
      auto_unbox = TRUE,
      json_verbatim = TRUE
    )
  )

  shiny::tags$div(
    class = "gauge",
    id = id,
    gaugeConfig
  )
}



#' Update Framework7 gauge
#'
#' \code{updateF7Gauge} updates a framework7 gauge from the server side.
#'
#' @rdname gauge
#'
#' @param id Gauge id.
#' @param value New value. Numeric between 0 and 100.
#' @param size Generated SVG image size (in px). Default is 200.
#' @param bgColor Gauge background color. Can be any valid color string, e.g. #ff00ff, rgb(0,0,255), etc. Default is "transparent".
#' @param borderBgColor Main border/stroke background color.
#' @param borderColor Main border/stroke color.
#' @param borderWidth Main border/stroke width.
#' @param valueText Gauge value text (large text in the center of gauge).
#' @param valueTextColor Value text color.
#' @param valueFontSize Value text font size.
#' @param valueFontWeight Value text font weight.
#' @param labelText Gauge additional label text.
#' @param labelTextColor Label text color.
#' @param labelFontSize Label text font size.
#' @param labelFontWeight Label text font weight.
#' @param session Shiny session object.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'
#'  shinyApp(
#'     ui = f7Page(
#'        title = "Gauges",
#'        f7SingleLayout(
#'           navbar = f7Navbar(title = "update f7Gauge"),
#'           f7Gauge(
#'              id = "mygauge",
#'              type  = "semicircle",
#'              value = 50,
#'              borderColor = "#2196f3",
#'              borderWidth = 10,
#'              valueFontSize = 41,
#'              valueTextColor = "#2196f3",
#'              labelText = "amount of something"
#'           ),
#'           f7Button("go", "Update Gauge")
#'        )
#'     ),
#'     server = function(input, output, session) {
#'        observeEvent(input$go, {
#'           updateF7Gauge(id = "mygauge", value = 75, labelText = "New label!")
#'        })
#'     }
#'  )
#' }
updateF7Gauge <- function(id, value = NULL, labelText = NULL, size = NULL,
                          bgColor = NULL, borderBgColor = NULL,
                          borderColor = NULL, borderWidth = NULL,
                          valueText = NULL,
                          valueTextColor = NULL, valueFontSize = NULL,
                          valueFontWeight = NULL, labelTextColor = NULL,
                          labelFontSize = NULL, labelFontWeight = NULL,
                          session = shiny::getDefaultReactiveDomain()) {

  if (is.null(valueText)) valueText <- paste(value, "%")

  message <- dropNulls(
    list(
      id = id,
      value = value / 100,
      size = size,
      bgColor = bgColor,
      borderBgColor = borderBgColor,
      borderColor = borderColor,
      borderWidth = borderWidth,
      valueText = valueText,
      valueTextColor = valueTextColor,
      valueFontSize = valueFontSize,
      valueFontWeight = valueFontWeight,
      labelText = labelText,
      labelTextColor = labelTextColor,
      labelFontSize = labelFontSize,
      labelFontWeight = labelFontWeight
    )
  )

  sendCustomMessage("update-gauge", message, session)
}
