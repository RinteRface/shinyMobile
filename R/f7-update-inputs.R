#' Change the value of a button input on the client
#'
#' @param session The session object passed to function given to the server.
#' @param inputId The id of the input object.
#' @inheritParams f7Button
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     title = "Update f7Button",
#'     init = f7Init(theme = "light", skin = "ios"),
#'     f7SingleLayout(
#'       navbar = f7Navbar(title = "Update f7Button"),
#'       f7Button(
#'         "test",
#'         "Test",
#'         color = "orange",
#'         outline = FALSE,
#'         fill = TRUE,
#'         shadow = FALSE,
#'         rounded = FALSE,
#'         size = NULL),
#'       f7Toggle("prout", "Update Button")
#'     )
#'   ),
#'   server = function(input, output, session) {
#'     observe(print(input$test))
#'     observeEvent(input$prout, {
#'       if (input$prout) {
#'         updateF7Button(
#'           session = session,
#'           inputId = "test",
#'           label = "Updated",
#'           color = "purple",
#'           shadow = TRUE,
#'           rounded = TRUE,
#'           size = "large"
#'         )
#'       }
#'     })
#'   }
#'  )
#' }
#' @export
updateF7Button <- function (session, inputId, label = NULL, color = NULL,
                            fill = NULL, outline = NULL, shadow = NULL,
                            rounded = NULL, size = NULL) {
  message <- dropNulls(
    list(
      label = label,
      color = color,
      fill = fill,
      outline = outline,
      shadow = shadow,
      rounded = rounded,
      size = size
      )
    )
  session$sendInputMessage(inputId, message)
}





#' Toggle \link{f7Fabs} on the server side.
#'
#' @param session The session object passed to function given to the server.
#' @param inputId The id of the input object.
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     title = "Update f7Fabs",
#'     init = f7Init(theme = "light", skin = "ios"),
#'     f7SingleLayout(
#'       navbar = f7Navbar(title = "Update f7Fabs"),
#'       f7Button("toggleFabs", "Toggle Fabs"),
#'       f7Fabs(
#'         position = "center-center",
#'         id = "fabs",
#'         lapply(1:3, function(i) f7Fab(inputId = i, label = i))
#'       )
#'     )
#'   ),
#'   server = function(input, output, session) {
#'     observe(print(input$fabs))
#'     observeEvent(input$toggleFabs, {
#'       updateF7Fabs(
#'         session = session,
#'         inputId = "fabs"
#'       )
#'     })
#'   }
#'  )
#' }
updateF7Fabs <- function(session, inputId) {
  message <- NULL
  session$sendInputMessage(inputId, message)
}




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
#'  library(shinyMobile)
#'
#'  ui <- f7Page(
#'    f7SingleLayout(
#'     navbar = f7Navbar(title = "updateF7CheckBox"),
#'     f7Slider(
#'      inputId = "controller",
#'      label = "Number of observations",
#'      max = 10,
#'      min = 0,
#'      value = 1,
#'      step = 1,
#'      scale = TRUE
#'     ),
#'     f7checkBox(
#'      inputId = "check",
#'      label = "Checkbox"
#'     )
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
#'  library(shinyMobile)
#'
#'  ui <- f7Page(
#'    f7SingleLayout(
#'     navbar = f7Navbar(title = "updateF7Text"),
#'     f7Fab("trigger", "Click me"),
#'     f7Text(
#'      inputId = "text",
#'      label = "Caption",
#'      value = "Some text",
#'      placeholder = "Your text here"
#'     ),
#'     verbatimTextOutput("value")
#'    )
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




# #' Change the value of a date input on the client
# #'
# #' @inheritParams updateF7Text
# #' @export
# #' @examples
# #' if (interactive()) {
# #'  library(shiny)
# #'  library(shinyMobile)
# #'
# #'  ui <- f7Page(
# #'    f7SingleLayout(
# #'     navbar = f7Navbar(title = "updateF7Text"),
# #'     f7Fab("trigger", "Click me"),
# #'     f7Date(inputId = "date", label = "Date", value = "2014-04-30"),
# #'     verbatimTextOutput("datevalue")
# #'    )
# #'  )
# #'
# #'  server <- function(input, output, session) {
# #'    output$datevalue <- renderPrint(input$date)
# #'    observeEvent(input$trigger, {
# #'      updateF7Date(session, "date", value = "2020-01-15")
# #'    })
# #'  }
# #'  shinyApp(ui, server)
# #' }
# updateF7Date <- updateF7Text




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
#'  library(shinyMobile)
#'
#'  ui <- f7Page(
#'    f7SingleLayout(
#'     navbar = f7Navbar(title = "updateF7Fab"),
#'     f7Fab("trigger", "Click me")
#'    )
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




#' Change the value of a slider input on the client
#'
#' @param session The session object passed to function given to the server.
#' @param inputId The id of the input object.
#' @param min Slider minimum range.
#' @param max Slider maximum range
#' @param value Slider value or a vector containing 2 values (for a range).
#' @param scale Slider scale.
#' @param scaleSteps Number of scale steps.
#' @param scaleSubSteps Number of scale sub steps (each step will be divided by this value).
#' @param step Slider increase step size.
#' @param color See \link{getF7Colors} for valid colors.
#'
#' @export
#'
#' @note Important: you cannot transform a range slider into a simple slider and inversely.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'    ui = f7Page(
#'      title = "My app",
#'      f7SingleLayout(
#'        navbar = f7Navbar(title = "updateF7Slider"),
#'        f7Card(
#'          f7Button(inputId = "update", label = "Update slider"),
#'          f7Slider(
#'            inputId = "obs",
#'            label = "Range values",
#'            max = 500,
#'            min = 0,
#'            step = 1,
#'            color = "deeppurple",
#'            value = c(50, 100)
#'          ),
#'          verbatimTextOutput("test")
#'        )
#'      )
#'    ),
#'    server = function(input, output, session) {
#'
#'      output$test <- renderPrint({input$obs})
#'
#'      observeEvent(input$update, {
#'        updateF7Slider(
#'          session,
#'          inputId = "obs",
#'          value = c(1, 5),
#'          min = 0,
#'          scaleSteps = 10,
#'          scaleSubSteps = 5,
#'          step = 0.1,
#'          max = 10,
#'          color = "teal"
#'        )
#'      })
#'    }
#'  )
#' }
updateF7Slider <- function(session, inputId, min = NULL, max = NULL, value = NULL,
                           scale = FALSE, scaleSteps = NULL, scaleSubSteps = NULL,
                           step = NULL, color = NULL) {
  message <- dropNulls(list(
    value = value,
    min = min,
    max = max,
    scale = scale,
    step = step,
    scaleSteps = scaleSteps,
    scaleSubSteps = scaleSubSteps,
    color = color
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
#'  library(shinyMobile)
#'
#'  shinyApp(
#'    ui = f7Page(
#'      title = "My app",
#'      f7SingleLayout(
#'        navbar = f7Navbar(title = "updateF7Toggle"),
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




#' Change the value of a stepper input on the client
#'
#' @param session The session object passed to function given to the server.
#' @param inputId The id of the input object.
#' @param min Stepper minimum value.
#' @param max Stepper maximum value.
#' @param value Stepper value. Must belong to \[min, max\].
#' @param step increment step. 1 by default.
#' @param fill Whether to fill the stepper. FALSE by default.
#' @param rounded Whether to round the stepper. FALSE by default.
#' @param raised Whether to put a relied around the stepper. FALSE by default.
#' @param size Stepper size: "small", "large" or NULL.
#' @param color Stepper color: NULL or "red", "green", "blue", "pink", "yellow", "orange", "grey" and "black".
#' @param wraps In wraps mode incrementing beyond maximum value sets value to minimum value,
#' likewise, decrementing below minimum value sets value to maximum value. FALSE by default.
#' @param decimalPoint Number of digits after dot, when in manual input mode.
#' @param autorepeat Pressing and holding one of its buttons increments or decrements the stepper’s
#' value repeatedly. With dynamic autorepeat, the rate of change depends on how long the user
#' continues pressing the control. TRUE by default.
#' @param manual It is possible to enter value manually from keyboard or mobile keypad. When click on input field, stepper enter into manual input mode, which allow type value from keyboar and check fractional part with defined accurancy. Click outside or enter Return key, ending manual mode. TRUE by default.
#'
#' @export
#'
#' @note While updating, the autorepeat field does not work correctly.
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'   ui = f7Page(
#'     title = "My app",
#'     f7SingleLayout(
#'       navbar = f7Navbar(title = "updateF7Stepper"),
#'       f7Card(
#'         f7Button(inputId = "update", label = "Update stepper"),
#'         f7Stepper(
#'           inputId = "stepper",
#'           label = "My stepper",
#'           min = 0,
#'           max = 10,
#'           size = "small",
#'           value = 4,
#'           wraps = TRUE,
#'           autorepeat = TRUE,
#'           rounded = FALSE,
#'           raised = FALSE,
#'           manual = FALSE
#'         ),
#'         verbatimTextOutput("test")
#'       )
#'     )
#'   ),
#'   server = function(input, output, session) {
#'
#'     output$test <- renderPrint(input$stepper)
#'
#'     observeEvent(input$update, {
#'       updateF7Stepper(
#'         session,
#'         inputId = "stepper",
#'         value = 0.1,
#'         step = 0.01,
#'         size = "large",
#'         min = 0,
#'         max = 1,
#'         wraps = FALSE,
#'         autorepeat = FALSE,
#'         rounded = TRUE,
#'         raised = TRUE,
#'         color = "pink",
#'         manual = TRUE,
#'         decimalPoint = 2
#'       )
#'     })
#'   }
#'  )
#' }
updateF7Stepper <- function(session, inputId, min = NULL, max = NULL,
                            value = NULL, step = NULL, fill = NULL,
                            rounded = NULL, raised = NULL, size = NULL,
                            color = NULL, wraps = NULL, decimalPoint = NULL,
                            autorepeat = NULL, manual = NULL) {
  message <- dropNulls(list(
    min = min,
    max = max,
    value = value,
    step = step,
    fill = fill,
    rounded = rounded,
    raised = raised,
    size = size,
    color = color,
    wraps = wraps,
    decimalPoint = decimalPoint,
    autorepeat = autorepeat,
    manual = manual
  ))
  session$sendInputMessage(inputId, message)
}




#' Change the value of a picker input on the client
#'
#' @param session The session object passed to function given to the server.
#' @param inputId The id of the input object.
#' @param value Picker initial value, if any.
#' @param choices New picker choices.
#' @param rotateEffect Enables 3D rotate effect. Default to TRUE.
#' @param openIn Can be auto, popover (to open picker in popover), sheet (to open in sheet modal).
#'  In case of auto will open in sheet modal on small screens and in popover on large screens. Default
#'  to auto.
#' @param scrollToInput Scroll viewport (page-content) to input when picker opened. Default
#'  to FALSE.
#' @param closeByOutsideClick If enabled, picker will be closed by clicking outside of picker or related input element.
#'  Default to TRUE.
#' @param toolbar Enables picker toolbar. Default to TRUE.
#' @param toolbarCloseText Text for Done/Close toolbar button.
#' @param sheetSwipeToClose Enables ability to close Picker sheet with swipe. Default to FALSE.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shinyApp(
#'   ui = f7Page(
#'     title = "My app",
#'     f7SingleLayout(
#'       navbar = f7Navbar(title = "Update picker"),
#'       f7Card(
#'         f7Button(inputId = "update", label = "Update picker"),
#'         f7Picker(
#'           inputId = "mypicker",
#'           placeholder = "Some text here!",
#'           label = "Picker Input",
#'           choices = c('a', 'b', 'c')
#'         ),
#'         verbatimTextOutput("pickerval"),
#'         br(),
#'         f7Button(inputId = "removeToolbar", label = "Remove picker toolbar", color = "red")
#'       )
#'     )
#'   ),
#'   server = function(input, output, session) {
#'
#'     output$pickerval <- renderText(input$mypicker)
#'
#'     observeEvent(input$update, {
#'       updateF7Picker(
#'         session,
#'         inputId = "mypicker",
#'         value = "b",
#'         choices = letters,
#'         openIn = "sheet",
#'         toolbarCloseText = "Prout",
#'         sheetSwipeToClose = TRUE
#'       )
#'     })
#'
#'     observeEvent(input$removeToolbar, {
#'       updateF7Picker(
#'         session,
#'         inputId = "mypicker",
#'         value = "b",
#'         choices = letters,
#'         openIn = "sheet",
#'         toolbar = FALSE
#'       )
#'     })
#'
#'   }
#'  )
#' }
updateF7Picker <- function(session, inputId, value = NULL, choices = NULL,
                           rotateEffect = NULL, openIn = NULL, scrollToInput = NULL,
                           closeByOutsideClick = NULL, toolbar = NULL, toolbarCloseText = NULL,
                           sheetSwipeToClose = NULL) {
  message <- dropNulls(list(
    value = value,
    choices = choices,
    rotateEffect = rotateEffect,
    openIn = openIn,
    scrollToInput = scrollToInput,
    closeByOutsideClick = closeByOutsideClick,
    toolbar = toolbar,
    toolbarCloseText = toolbarCloseText,
    sheetSwipeToClose = sheetSwipeToClose
  ))
  session$sendInputMessage(inputId, message)
}





#' Change the value of a date picker input on the client
#'
#' @param session The session object passed to function given to the server.
#' @param inputId The id of the input object.
#' @param value The new value for the input.
#' @param ... Parameters used to update the date picker, use same arguments as in \code{\link{f7DatePicker}}.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   shinyApp(
#'     ui = f7Page(
#'       title = "My app",
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "Update date picker"),
#'         f7Card(
#'           f7Button(inputId = "selectToday", label = "Select today"),
#'           f7Button(inputId = "rmToolbar", label = "Remove toolbar"),
#'           f7Button(inputId = "addToolbar", label = "Add toolbar"),
#'           f7DatePicker(
#'             inputId = "mypicker",
#'             label = "Choose a date",
#'             value = Sys.Date() - 7,
#'             openIn = "auto",
#'             direction = "horizontal"
#'           ),
#'           verbatimTextOutput("pickerval")
#'         )
#'       )
#'     ),
#'     server = function(input, output, session) {
#'
#'       output$pickerval <- renderPrint(input$mypicker)
#'
#'       observeEvent(input$selectToday, {
#'         updateF7DatePicker(
#'           session,
#'           inputId = "mypicker",
#'           value = Sys.Date()
#'         )
#'       })
#'
#'       observeEvent(input$rmToolbar, {
#'         updateF7DatePicker(
#'           session,
#'           inputId = "mypicker",
#'           toolbar = FALSE,
#'           dateFormat = "yyyy-mm-dd" # preserve date format
#'         )
#'       })
#'
#'       observeEvent(input$addToolbar, {
#'         updateF7DatePicker(
#'           session,
#'           inputId = "mypicker",
#'           toolbar = TRUE,
#'           dateFormat = "yyyy-mm-dd" # preserve date format
#'         )
#'       })
#'
#'     }
#'   )
#' }
updateF7DatePicker <- function(session, inputId, value = NULL, ...) {
  if (!is.null(value) && length(value) == 1) {
    value <- list(value)
  }
  config <- dropNulls(list(...))
  if (length(config) == 0)
    config <- NULL
  message <- dropNulls(list(
    value = value,
    config = config
  ))
  session$sendInputMessage(inputId, message)
}





#' Change the value of an autocomplete input on the client
#'
#' @param session The session object passed to function given to the server.
#' @param inputId The id of the input object.
#' @param value Picker initial value, if any.
#'
#' @note You cannot update choices yet.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shinyApp(
#'   ui = f7Page(
#'     title = "My app",
#'     f7SingleLayout(
#'       navbar = f7Navbar(title = "Update autocomplete"),
#'       f7Card(
#'         f7Button(inputId = "update", label = "Update autocomplete"),
#'         f7AutoComplete(
#'          inputId = "myautocomplete",
#'          placeholder = "Some text here!",
#'          openIn = "dropdown",
#'          label = "Type a fruit name",
#'          choices = c('Apple', 'Apricot', 'Avocado', 'Banana', 'Melon',
#'                      'Orange', 'Peach', 'Pear', 'Pineapple')
#'         ),
#'         verbatimTextOutput("autocompleteval")
#'       )
#'     )
#'   ),
#'   server = function(input, output, session) {
#'
#'     observe({
#'      print(input$myautocomplete)
#'     })
#'
#'     output$autocompleteval <- renderText(input$myautocomplete)
#'
#'     observeEvent(input$update, {
#'       updateF7AutoComplete(
#'         session,
#'         inputId = "myautocomplete",
#'         value = "Banana"
#'       )
#'     })
#'   }
#'  )
#' }
updateF7AutoComplete <- function(session, inputId, value =  NULL) {
  message <- dropNulls(
    list(
      value = value
    )
  )
  session$sendInputMessage(inputId, message)
}







#' Change the value of a select input on the client
#'
#' @param session The session object passed to function given to the server.
#' @param inputId The id of the input object.
#' @param selected New value.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'    ui = f7Page(
#'      title = "My app",
#'      f7SingleLayout(
#'        navbar = f7Navbar(title = "updateF7Select"),
#'        f7Card(
#'          f7Button(inputId = "update", label = "Update select"),
#'          br(),
#'          f7Select(
#'           inputId = "variable",
#'           label = "Choose a variable:",
#'           choices = colnames(mtcars)[-1],
#'           selected = "hp"
#'          ),
#'          verbatimTextOutput("test")
#'        )
#'      )
#'    ),
#'    server = function(input, output, session) {
#'
#'      output$test <- renderPrint(input$variable)
#'
#'      observeEvent(input$update, {
#'        updateF7Select(
#'          session,
#'          inputId = "variable",
#'          selected = "gear"
#'        )
#'      })
#'    }
#'  )
#' }
updateF7Select <- function(session, inputId, selected = NULL) {
  message <- dropNulls(list(
    selected = selected
  ))
  session$sendInputMessage(inputId, message)
}
