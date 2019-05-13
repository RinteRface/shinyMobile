# #' Create a Framework7 picker input
# #'
# #' Build a Framework7 picker input
# #'
# #' @param inputId Picker input id.
# #' @param label Picker label.
# #' @param placeHolder Text to write in the container.
# #' @param choices Picker choices.
# #'
# #' @examples
# #' if(interactive()){
# #'  library(shiny)
# #'  library(shinyF7)
# #'
# #'  shiny::shinyApp(
# #'    ui = f7Page(
# #'     title = "My app",
# #'     f7pickerInput(
# #'      inputId = "my-picker",
# #'      placeHolder = "Some text here!",
# #'      label = "Picker Input",
# #'      choices = c('a', 'b', 'c')
# #'     )
# #'    ),
# #'    server = function(input, output) {}
# #'  )
# #' }
# #'
# #' @author David Granjon, \email{dgranjon@@ymail.com}
# #'
# #' @export
# f7pickerInput <- function(inputId, label, placeHolder = NULL, choices) {
#
#   # input tag
#   inputTag <- shiny::tags$div(
#     class = "item-content item-input item-input-with-value",
#     shiny::tags$div(
#       class = "item-inner",
#       shiny::tags$div(
#         class = "item-input-wrap",
#         shiny::tags$input(
#           class = "input-with-value",
#           id = inputId,
#           type = "text",
#           placeholder = placeHolder,
#           readonly = "readonly"
#         )
#       )
#     )
#   )
#
#   # JS
#   choices <- jsonlite::toJSON(choices)
#   choices <- paste("values: ", choices)
#
#   pickerJS <- shiny::tags$script(
#     paste0(
#       "var pickerDevice = app.picker.create({
#           inputEl: '#", inputId,"',
#           cols: [
#             {
#               textAlign: 'center',
#               ", choices,"
#             }
#           ]
#          });
#         "
#     )
#   )
#
#   # tag wrapper
#   mainTag <- shiny::tags$div(
#     class = "block-title",
#     label,
#     shiny::tags$div(
#       class = "list no-hairlines-md",
#       shiny::tags$ul(
#         shiny::tags$li(
#           inputTag
#         )
#       )
#     )
#   )
#
#   # final input tag
#   shiny::tagList(
#     shiny::singleton(shiny::tags$head(pickerJS)),
#     mainTag
#   )
#
# }



#' Create a F7 Checkbox
#'
#' @param inputId The input slot that will be used to access the value.
#' @param label Display label for the control, or NULL for no label.
#' @param value Initial value (TRUE or FALSE).
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'     title = "My app",
#'     f7Init(theme = "auto"),
#'     f7Card(
#'      f7checkBox(
#'       inputId = "check",
#'       label = "Checkbox",
#'       value = FALSE
#'      ),
#'      verbatimTextOutput("test")
#'     )
#'    ),
#'    server = function(input, output) {
#'     output$test <- renderPrint({input$check})
#'    }
#'  )
#' }
#
#' @export
f7checkBox <- function(inputId, label, value = FALSE){
  value <- shiny::restoreInput(id = inputId, default = value)
  inputTag <- shiny::tags$input(id = inputId, type = "checkbox")
  if (!is.null(value) && value)
    inputTag$attribs$checked <- "checked"
  shiny::tags$label(
    class = "checkbox form-group shiny-input-container",
    inputTag,
    shiny::tags$i(class = "icon icon-checkbox"),
    shiny::tags$div(
      class = "item-inner",
      shiny::tags$div(class = "item-title", label)
    )
  )
}





#' Create a f7 slider
#'
#' @param inputId Slider input id.
#' @param label Slider label.
#' @param min Slider minimum range.
#' @param max Slider maximum range.
#' @param value Slider value.
#' @param step Slider increase step size.
#' @param scale Slider scale.
#' @param vertical Whether to apply a vertical display. FALSE by default. Does not work yet.
#'
#' @export
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'     title = "My app",
#'     f7Init(theme = "auto"),
#'     f7Card(
#'      f7Slider(
#'       inputId = "obs",
#'       label = "Number of observations",
#'       max = 1000,
#'       min = 0,
#'       value = 100,
#'       scale = TRUE
#'      ),
#'      verbatimTextOutput("test")
#'     ),
#'     plotOutput("distPlot")
#'    ),
#'    server = function(input, output) {
#'     output$test <- renderPrint({input$obs})
#'     output$distPlot <- renderPlot({
#'      hist(rnorm(input$obs))
#'     })
#'    }
#'  )
#' }
f7Slider <- function(inputId, label, min, max, value,
                     step = NULL, scale = FALSE, vertical = FALSE) {

    # custom input binding
    shiny::tagList(
      shiny::singleton(
        shiny::tags$head(
          shiny::includeScript(path = system.file("framework7-4.3.1/input-bindings/sliderInputBinding.js", package = "shinyF7"))
        )
      ),
      # slider initialization
      shiny::singleton(
        shiny::tags$head(
          shiny::tags$script(
            paste0(
              "// init the slider component
                $(function() {
                  var range = app.range.create({ el: '#", inputId,"' });
                });
              "
            )
          )
        )
      ),
      shiny::br(),
      shiny::tags$div(class = "block-title", label),
      shiny::tags$div(
        class = "range-slider",
        id = inputId,
        `data-min`= min,
        `data-max`= max,
        `data-vertical` = tolower(vertical),
        `data-label`="true",
        `data-step`= 5,
        `data-value`= value,
        `data-scale`= tolower(scale),
        `data-scale-steps`= 5,
        `data-scale-sub-steps`="4"
      )
    )
}


# #' Create a F7 radio stepper
# #'
# #' @examples
# #' if(interactive()){
# #'  library(shiny)
# #'  library(shinyF7)
# #'
# #'  shiny::shinyApp(
# #'    ui = f7Page(
# #'     title = "My app",
# #'     f7Init(theme = "auto"),
# #'     f7Card(f7Stepper())
# #'    ),
# #'    server = function(input, output) {}
# #'  )
# #' }
# #
# #' @export
# f7Stepper <- function() {
#   HTML(
#     '<div class="block block-strong text-align-center">
#   <div class="row">
#     <div class="col">
#       <div class="stepper stepper-fill stepper-init" data-wraps="true" data-autorepeat="true" data-autorepeat-dynamic="true" data-decimal-point="2" data-manual-input-mode="true">
#         <div class="stepper-button-minus"></div>
#         <div class="stepper-input-wrap">
#           <input type="text" value="0" min="0" max="1000" step="1">
#         </div>
#         <div class="stepper-button-plus"></div>
#       </div>
#     </div>
#   </div>
# </div>
#     '
#   )
# }
