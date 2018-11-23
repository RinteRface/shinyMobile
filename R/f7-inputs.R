#' Create a Framework7 picker input
#'
#' Build a Framework7 picker input
#'
#' @param inputId Picker input id.
#' @param label Picker label.
#' @param placeHolder Text to write in the container.
#' @param choices Picker choices.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'     title = "My app",
#'     f7pickerInput(
#'      inputId = "my-picker",
#'      placeHolder = "Some text here!",
#'      label = "Picker Input",
#'      choices = c('a', 'b', 'c')
#'     )
#'    ),
#'    server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7pickerInput <- function(inputId, label, placeHolder = NULL, choices) {

  # input tag
  inputTag <- shiny::tags$div(
    class = "item-content item-input item-input-with-value",
    shiny::tags$div(
      class = "item-inner",
      shiny::tags$div(
        class = "item-input-wrap",
        shiny::tags$input(
          class = "input-with-value",
          id = inputId,
          type = "text",
          placeholder = placeHolder,
          readonly = "readonly"
        )
      )
    )
  )

  # JS
  choices <- jsonlite::toJSON(choices)
  choices <- paste("values: ", choices)

  pickerJS <- shiny::tags$script(
    paste0(
      "var pickerDevice = app.picker.create({
          inputEl: '#", inputId,"',
          cols: [
            {
              textAlign: 'center',
              ", choices,"
            }
          ]
         });
        "
    )
  )

 # tag wrapper
 mainTag <- shiny::tags$div(
   class = "block-title",
   label,
   shiny::tags$div(
     class = "list no-hairlines-md",
     shiny::tags$ul(
       shiny::tags$li(
         inputTag
       )
     )
   )
 )

 # final input tag
 shiny::tagList(
   shiny::singleton(shiny::tags$head(pickerJS)),
   mainTag
 )

}
