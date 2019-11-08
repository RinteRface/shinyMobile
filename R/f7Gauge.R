#' Create a Framework7 gauge
#'
#' Build a Framework7 gauge
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
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shiny::shinyApp(
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
#'        valueText = "50%",
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
#' @author David Granjon and Isabelle Rudolf, \email{dgranjon@@ymail.com}
#'
#' @export
f7Gauge <- function(id, type = NULL, value = NULL, size = NULL, bgColor = NULL,
                    borderBgColor = NULL, borderColor = NULL, borderWidth = NULL,
                    valueText = NULL, valueTextColor = NULL, valueFontSize = NULL,
                    valueFontWeight = NULL, labelText = NULL, labelTextColor = NULL,
                    labelFontSize = NULL, labelFontWeight = NULL) {

  gaugeCl <- paste("gauge", id)

   gaugeProps <- dropNulls(
     list(
       el = paste0(".", id),
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

   gaugeProps <- as.data.frame(gaugeProps)

   gaugeProps <- jsonlite::toJSON(gaugeProps)
   gaugeProps <- gsub(x = gaugeProps, pattern = "\\[", replacement = "")
   gaugeProps <- gsub(x = gaugeProps, pattern = "\\]", replacement = "")

   gaugeJS <- shiny::tags$script(
     paste0(
       "$(function() {
         app.gauge.create(", gaugeProps," );
       });
       "
     )
   )

   gaugeTag <- shiny::tags$div(class = gaugeCl, id = id)

  shiny::tagList(
    shiny::singleton(shiny::tags$head(gaugeJS)),
    gaugeTag
  )
}



#' update a framework7 gauge from the server side
#'
#' @param session Shiny session object.
#' @param id Gauge id.
#' @param value New value. Numeric between 0 and 100.
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'
#'  shiny::shinyApp(
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
#'              valueText = "50%",
#'              valueFontSize = 41,
#'              valueTextColor = "#2196f3",
#'              labelText = "amount of something"
#'           ),
#'           f7Button("go", "Update Gauge")
#'        )
#'     ),
#'     server = function(input, output, session) {
#'        observeEvent(input$go, {
#'           updateF7Gauge(session, id = "mygauge", value = 75)
#'        })
#'     }
#'  )
#' }
updateF7Gauge <- function(session, id, value) {
   session$sendCustomMessage(type = id, message = value)
}
