#' Change the value of a checkbox input on the client
#'
#' @param session The session object passed to function given to the server.
#' @param inputId The id of the input object.
#' @param label	The label to set for the input object.
#' @param value The value to set for the input object.
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyF7)
#'
#'  ui <- f7Page(
#'    init = f7Init(theme = "ios"),
#'    f7Slider(
#'     inputId = "controller",
#'     label = "Number of observations",
#'     max = 10,
#'     min = 0,
#'     value = 1,
#'     step = 1,
#'     scale = TRUE
#'    ),
#'    f7checkBox(
#'     inputId = "check",
#'     label = "Checkbox"
#'    )
#'  )
#'
#'  server <- function(input, output, session) {
#'    observe({
#'      # TRUE if input$controller is odd, FALSE if even.
#'      x_even <- input$controller %% 2 == 1
#'
#'      if (x_even) {
#'       showNotification(
#'        id = "notif",
#'        paste("The slider is ", input$controller, "and the checkbox is", input$check),
#'        duration = NULL,
#'        type = "warning"
#'       )
#'      } else {
#'       removeNotification("notif")
#'      }
#'
#'      updateF7Checkbox(session, "check", value = x_even)
#'    })
#'  }
#'
#' shinyApp(ui, server)
#' }
#' @export
updateF7Checkbox <- function(session, inputId, label = NULL, value = NULL) {
  message <- dropNulls(list(label=label, value=value))
  session$sendInputMessage(inputId, message)
}




#' Change the value of a text input on the client
#'
#' @param session The session object passed to function given to the server.
#' @param inputId The id of the input object.
#' @param label The label to set for the input object.
#' @param value The value to set for the input object.
#' @param placeholder The placeholder to set for the input object.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyF7)
#'
#'  ui <- f7Page(
#'    init = f7Init(theme = "ios"),
#'    f7Fab("trigger", "Click me"),
#'    f7Text(
#'     inputId = "text",
#'     label = "Caption",
#'     value = "Some text",
#'     placeholder = "Your text here"
#'    ),
#'    verbatimTextOutput("value")
#'  )
#'
#'  server <- function(input, output, session) {
#'    output$value <- renderPrint(input$text)
#'    observeEvent(input$trigger, {
#'      updateF7Text(session, "text", value = "Updated Text")
#'    })
#'  }
#' shinyApp(ui, server)
#' }
updateF7Text <- function(session, inputId, label = NULL, value = NULL, placeholder = NULL) {
  message <- dropNulls(list(label=label, value=value, placeholder=placeholder))
  session$sendInputMessage(inputId, message)
}







#' Change the value of a \link{f7Fab} input on the client
#'
#' @param session The session object passed to function given to the server.
#' @param inputId The id of the input object.
#' @param label The label to set for the input object.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyF7)
#'
#'  ui <- f7Page(
#'    init = f7Init(theme = "ios"),
#'    f7Fab("trigger", "Click me")
#'  )
#'
#'  server <- function(input, output, session) {
#'    observeEvent(input$trigger, {
#'      updateF7Fab(session, "trigger", label = "Don't click me")
#'    })
#'  }
#' shinyApp(ui, server)
#' }
updateF7Fab <- function(session, inputId, label = NULL) {
  message <- dropNulls(list(label=label))
  session$sendInputMessage(inputId, message)
}



# #' Change the value of a \link{f7Button} input on the client
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
# #'  library(shinyF7)
# #'
# #'  ui <- f7Page(
# #'    f7Init(),
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
# #'  library(shinyF7)
# #'
# #'  shiny::shinyApp(
# #'    ui = f7Page(
# #'      title = "My app",
# #'      f7Init(theme = "auto"),
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




#' Change the value of a slider input on the client
#'
#' @param session The session object passed to function given to the server.
#' @param inputId The id of the input object.
#' @param min Slider minimum range.
#' @param max Slider maximum range
#' @param value Slider value or a vector containing 2 values (for a range).
#' @param scale Slider scale.
#'
#' @export
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shinyApp(
#'   ui = f7Page(
#'     title = "My app",
#'     init = f7Init(theme = "auto"),
#'     f7SingleLayout(
#'       navbar = f7Navbar(title = "Update f7Slider"),
#'       f7Card(
#'         f7Button(inputId = "update", label = "Update slider"),
#'         f7Slider(
#'           inputId = "obs",
#'           label = "Range values",
#'           max = 500,
#'           min = 0,
#'           value = c(50, 100),
#'           scale = TRUE,
#'           vertical = FALSE
#'         ),
#'         verbatimTextOutput("test")
#'       )
#'     )
#'   ),
#'   server = function(input, output, session) {
#'
#'     output$test <- renderPrint({input$obs})
#'
#'     observeEvent(input$update, {
#'       updateF7Slider(
#'         session,
#'         inputId = "obs",
#'         value = c(20, 40),
#'         min = 10,
#'         max = 50,
#'         scale = FALSE
#'       )
#'     })
#'   }
#'  )
#' }
updateF7Slider <- function(session, inputId, min = NULL, max = NULL, value = NULL,
                           scale = FALSE) {
  message <- dropNulls(list(
    value = value,
    min = min,
    max = max,
    scale = scale
  ))
  session$sendInputMessage(inputId, message)
}





#' Change the value of a toggle input on the client
#'
#' @param session The session object passed to function given to the server.
#' @param inputId The id of the input object.
#' @param checked Whether the toggle is TRUE or FALSE.
#' @param color Toggle color.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shinyApp(
#'    ui = f7Page(
#'      title = "My app",
#'      init = f7Init(theme = "auto"),
#'      f7SingleLayout(
#'        navbar = f7Navbar(title = "Update toggle"),
#'        f7Card(
#'          f7Button(inputId = "update", label = "Update toggle"),
#'          f7Toggle(
#'            inputId = "toggle",
#'            label = "My toggle",
#'            color = "pink",
#'            checked = FALSE
#'          ),
#'          verbatimTextOutput("test")
#'        )
#'      )
#'    ),
#'    server = function(input, output, session) {
#'
#'      output$test <- renderPrint({input$toggle})
#'
#'      observeEvent(input$update, {
#'        updateF7Toggle(
#'          session,
#'          inputId = "toggle",
#'          checked = TRUE,
#'          color = "green"
#'        )
#'      })
#'    }
#'  )
#' }
updateF7Toggle <- function(session, inputId, checked = NULL, color = NULL) {
  message <- dropNulls(list(
    checked = checked,
    color = color
  ))
  session$sendInputMessage(inputId, message)
}
