

# #' Change the value of an \link{f7Button} input on the client
# #'
# #' @note This function does not work if \link{f7Button} has a not NULL src argument.
# #'
# #' @param session The session object passed to function given to the server.
# #' @param inputId The input slot that will be used to access the value.
# #' @param label The contents of the button or link–usually a text label, but you could also use any other HTML, like an image.
# #' @param color Button color. Not compatible with outline. See here for valid colors https://framework7.io/docs/badge.html.
# #' @param fill Fill style. TRUE by default. Not compatible with outline
# #' @param outline Outline style. FALSE by default. Not compatible with fill.
# #' @param shadow Button shadow. FALSE by default. Only for material design.
# #' @param rounded Round style. FALSE by default.
# #' @param size Button size. NULL by default but also "large" or "small".
# #'
# #' @export
# #'
# #' @examples
# #' if (interactive()) {
# #'  library(shiny)
# #'  library(shinyMobile)
# #'
# #'  ui <- f7Page(
# #'    f7Button(color = "black", label = "Action Button", inputId = "button")
# #'  )
# #'
# #'  server <- function(input, output, session) {
# #'    observeEvent(input$button, {
# #'      updateF7Button(session, "button", label = "Don't click me", color = "red", size = "small", fill = FALSE)
# #'    })
# #'  }
# #' shinyApp(ui, server)
# #' }
# updateF7Button <- function(session, inputId, label = NULL, color = NULL,
#                            fill = TRUE, outline = FALSE, shadow = FALSE, rounded = FALSE,
#                            size = NULL) {
#   message <- dropNulls(
#     list(
#       label=label,
#       color = color,
#       fill = fill,
#       outline = outline,
#       shadow = shadow,
#       rounded = rounded,
#       size = size
#     )
#   )
#   session$sendInputMessage(inputId, message)
# }





# #' Change the value of a checkboxGroup input on the client
# #'
# #' @param session The session object passed to function given to the server.
# #' @param inputId The id of the input object.
# #' @param label The label to set for the input object.
# #' @param choices Checkbox group choices.
# #' @param selected Checkbox group selected value.
# #'
# #' @export
# #'
# #' @examples
# #' if(interactive()){
# #'  library(shiny)
# #'  library(shinyMobile)
# #'
# #'  shiny::shinyApp(
# #'    ui = f7Page(
# #'      title = "My app",
# #'      f7Fab("update", "Update"),
# #'      f7checkBoxGroup(
# #'        inputId = "variable",
# #'        label = "Choose a variable:",
# #'        choices = colnames(mtcars)[-1],
# #'        selected = NULL
# #'      ),
# #'      tableOutput("data")
# #'    ),
# #'    server = function(input, output, session) {
# #'      output$data <- renderTable({
# #'        mtcars[, c("mpg", input$variable), drop = FALSE]
# #'      }, rownames = TRUE)
# #'
# #'      observeEvent(input$update, {
# #'        updateF7CheckboxGroup(session, "variable", label = "Updated choices",
# #'             choices = colnames(mtcars)[-1], selected = "disp")
# #'      })
# #'
# #'    }
# #'  )
# #' }
# updateF7CheckboxGroup <- function(session, inputId, label = NULL,
#                                   choices = NULL, selected = NULL) {
#   message <- dropNulls(list(label=label, choices = choices, selected=selected))
#   session$sendInputMessage(inputId, message)
# }
