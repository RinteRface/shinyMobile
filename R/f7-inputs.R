#' Framework7 autocomplete input
#'
#' \code{f7AutoComplete} generates a Framework7 autocomplete input.
#'
#' @param inputId Autocomplete input id.
#' @param label Autocomplete label.
#' @param placeholder Text to write in the container.
#' @param value Autocomplete initial value, if any.
#' @param choices Autocomplete choices.
#' @param openIn Defines how to open Autocomplete,
#' can be page or popup (for Standalone) or dropdown.
#' @param typeahead Enables type ahead, will prefill input
#' value with first item in match. Only if openIn is "dropdown".
#' @param expandInput If TRUE then input which is used as
#' item-input in List View will be expanded to full
#' screen wide during dropdown visible. Only if openIn is "dropdown".
#' @param closeOnSelect Set to true and autocomplete will be closed when user picks value.
#' Not available if multiple is enabled. Only works
#' when openIn is 'popup' or 'page'.
#' @param dropdownPlaceholderText Specify dropdown placeholder text.
#' Only if openIn is "dropdown".
#' @param multiple Whether to allow multiple value selection. Only works
#' when openIn is 'popup' or 'page'.
#'
#' @rdname autocomplete
#'
#' @examples
#' # Autocomplete input
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'    ui = f7Page(
#'     title = "My app",
#'     f7SingleLayout(
#'      navbar = f7Navbar(title = "f7AutoComplete"),
#'      f7AutoComplete(
#'       inputId = "myautocomplete1",
#'       placeholder = "Some text here!",
#'       dropdownPlaceholderText = "Try to type Apple",
#'       label = "Type a fruit name",
#'       openIn = "dropdown",
#'       choices = c('Apple', 'Apricot', 'Avocado', 'Banana', 'Melon',
#'        'Orange', 'Peach', 'Pear', 'Pineapple')
#'      ),
#'      textOutput("autocompleteval1"),
#'      f7AutoComplete(
#'       inputId = "myautocomplete2",
#'       placeholder = "Some text here!",
#'       openIn = "popup",
#'       multiple = TRUE,
#'       label = "Type a fruit name",
#'       choices = c('Apple', 'Apricot', 'Avocado', 'Banana', 'Melon',
#'                   'Orange', 'Peach', 'Pear', 'Pineapple')
#'      ),
#'      verbatimTextOutput("autocompleteval2")
#'     )
#'    ),
#'    server = function(input, output) {
#'     observe({
#'      print(input$myautocomplete1)
#'      print(input$myautocomplete2)
#'     })
#'     output$autocompleteval1 <- renderText(input$myautocomplete1)
#'     output$autocompleteval2 <- renderPrint(input$myautocomplete2)
#'    }
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7AutoComplete <- function(inputId, label, placeholder = NULL,
                           value = choices[1], choices,
                           openIn = c("popup", "page", "dropdown"),
                           typeahead = TRUE, expandInput = TRUE, closeOnSelect = FALSE,
                           dropdownPlaceholderText = NULL, multiple = FALSE) {

  type <- match.arg(openIn)

  value <- jsonlite::toJSON(value)
  choices <- jsonlite::toJSON(choices)

  # autocomplete common props
  autoCompleteCommon <- list(
    id = inputId,
    class = "autocomplete-input",
    `data-choices` = choices,
    `data-value` = value,
    `data-open-in` = type
  )

  # specific props
  autoCompleteProps <- if (!(type %in% c("page", "popup"))) {
    list(
      type = "text",
      placeholder = placeholder,
      `data-typeahead` = typeahead,
      `data-expand-input` = expandInput,
      `data-dropdown-placeholder-text` = dropdownPlaceholderText
    )
  } else {
    list(
      class = "item-link item-content",
      href = "#",
      `data-multiple` = multiple,
      `data-close-on-select` = closeOnSelect
    )
  }

  # merge props
  autoCompleteProps <- c(autoCompleteCommon, autoCompleteProps)

  # remove NULL elements
  autoCompleteProps <- dropNulls(autoCompleteProps)

  # replace TRUE and FALSE by true and false for javascript
  autoCompleteProps <- lapply(autoCompleteProps, function(x) {
    if (identical(x, TRUE)) "true"
    else if (identical(x, FALSE)) "false"
    else x
  })

  # wrap props
  autoCompleteProps <- if (!(type %in% c("page", "popup"))) {
    do.call(shiny::tags$input, autoCompleteProps)
  } else {
    tempTag <- do.call(shiny::tags$a, autoCompleteProps)
    tempTag <- shiny::tagAppendChildren(
      tempTag,
      shiny::tags$input(type = "hidden"),
      shiny::tags$div(
        class = "item-inner",
        # label
        shiny::tags$div(class = "item-title", label),
        # input
        shiny::tags$div(class = "item-after")
      )
    )
  }

  # input tag + label wrapper
  if (!(type %in% c("page", "popup"))) {
    shiny::tags$div(
      class = "list no-hairlines-md",
      shiny::tags$ul(
        shiny::tags$li(
          class = "item-content item-input inline-label",
          shiny::tags$div(
            class = "item-inner",
            # label
            shiny::tags$div(class = "item-title item-label", label),
            # input
            shiny::tags$div(
              class = "item-input-wrap",
              autoCompleteProps
            )
          )
        )
      )
    )
  } else {
    shiny::tags$div(class = "list", shiny::tags$ul(autoCompleteProps))
  }
}




#' Update Framework7 autocomplete
#'
#' \code{updateF7AutoComplete} changes the value of an autocomplete input on the client.
#'
#' @param inputId The id of the input object.
#' @param value New value.
#' @param session The Shiny session object.
#'
#' @note You cannot update choices yet.
#'
#' @export
#' @rdname autocomplete
#'
#' @examples
#' # Update autocomplete
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
#'         inputId = "myautocomplete",
#'         value = "Banana"
#'       )
#'     })
#'   }
#'  )
#' }
updateF7AutoComplete <- function(inputId, value =  NULL,
                                 session = shiny::getDefaultReactiveDomain()) {
  message <- dropNulls(
    list(
      value = I(value)
    )
  )
  session$sendInputMessage(inputId, message)
}





#' Framework7 picker input
#'
#' \code{f7Picker} generates a picker input.
#'
#' @param inputId Picker input id.
#' @param label Picker label.
#' @param placeholder Text to write in the container.
#' @param value Picker initial value, if any.
#' @param choices Picker choices.
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
#' @rdname picker
#' @examples
#' # Picker input
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'    ui = f7Page(
#'     title = "My app",
#'     f7SingleLayout(
#'      navbar = f7Navbar(title = "f7Picker"),
#'      f7Picker(
#'       inputId = "mypicker",
#'       placeholder = "Some text here!",
#'       label = "Picker Input",
#'       choices = c('a', 'b', 'c')
#'      ),
#'      textOutput("pickerval")
#'     )
#'    ),
#'    server = function(input, output) {
#'     output$pickerval <- renderText(input$mypicker)
#'    }
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Picker<- function(inputId, label, placeholder = NULL, value = choices[1], choices,
                    rotateEffect = TRUE, openIn = "auto", scrollToInput = FALSE,
                    closeByOutsideClick = TRUE, toolbar = TRUE, toolbarCloseText = "Done",
                    sheetSwipeToClose = FALSE) {

  # for JS
  if (is.null(value)) stop("value cannot be NULL.")
  value <- jsonlite::toJSON(value)
  choices <- jsonlite::toJSON(choices)

  # picker props
  pickerProps <- dropNulls(
    list(
      id = inputId,
      class = "picker-input",
      type = "text",
      placeholder = placeholder,
      `data-choices` = choices,
      `data-value` = value,
      `data-rotate-effect` = rotateEffect,
      `data-open-in` = openIn,
      `data-scroll-to-input` = scrollToInput,
      `data-close-by-outside-click` = closeByOutsideClick,
      `data-toolbar` = toolbar,
      `data-toolbar-close-text` = toolbarCloseText,
      `data-sheet-swipe-to-close` = sheetSwipeToClose
    )
  )

  # replace TRUE and FALSE by true and false for javascript
  pickerProps <- lapply(pickerProps, function(x) {
    if (identical(x, TRUE)) "true"
    else if (identical(x, FALSE)) "false"
    else x
  })

  # wrap props
  pickerProps <- do.call(shiny::tags$input, pickerProps)

  # input tag
  inputTag <- shiny::tags$div(
    class = "item-content item-input",
    shiny::tags$div(
      class = "item-inner",
      shiny::tags$div(
        class = "item-input-wrap",
        pickerProps
      )
    )
  )


  # tag wrapper
  shiny::tagList(
    shiny::tags$div(
      class = "block-title",
      label
    ),
    shiny::tags$div(
      class = "list no-hairlines-md",
      shiny::tags$ul(
        shiny::tags$li(
          inputTag
        )
      )
    )
  )
}




#' Update Framework7 picker
#'
#' \code{updateF7Picker} changes the value of a picker input on the client.
#'
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
#' @param session The Shiny session object, usually the default value will suffice.
#'
#' @export
#' @rdname picker
#'
#' @examples
#' # Update picker input
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
updateF7Picker <- function(inputId, value = NULL, choices = NULL,
                           rotateEffect = NULL, openIn = NULL, scrollToInput = NULL,
                           closeByOutsideClick = NULL, toolbar = NULL, toolbarCloseText = NULL,
                           sheetSwipeToClose = NULL,
                           session = shiny::getDefaultReactiveDomain()) {
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




f7ColorPickerPalettes <- list(
  c('#FFEBEE', '#FFCDD2', '#EF9A9A',
    '#E57373', '#EF5350', '#F44336',
    '#E53935', '#D32F2F', '#C62828',
    '#B71C1C'),
  c('#F3E5F5', '#E1BEE7', '#CE93D8',
    '#BA68C8', '#AB47BC', '#9C27B0',
    '#8E24AA', '#7B1FA2', '#6A1B9A',
    '#4A148C'),
  c('#E8EAF6', '#C5CAE9', '#9FA8DA',
    '#7986CB', '#5C6BC0', '#3F51B5',
    '#3949AB', '#303F9F', '#283593',
    '#1A237E'),
  c('#E1F5FE', '#B3E5FC', '#81D4FA',
    '#4FC3F7', '#29B6F6', '#03A9F4',
    '#039BE5', '#0288D1', '#0277BD',
    '#01579B'),
  c('#E0F2F1', '#B2DFDB', '#80CBC4',
    '#4DB6AC', '#26A69A', '#009688',
    '#00897B', '#00796B', '#00695C',
    '#004D40'),
  c('#F1F8E9', '#DCEDC8', '#C5E1A5',
    '#AED581', '#9CCC65', '#8BC34A',
    '#7CB342', '#689F38', '#558B2F',
    '#33691E'),
  c('#FFFDE7', '#FFF9C4', '#FFF59D',
    '#FFF176', '#FFEE58', '#FFEB3B',
    '#FDD835', '#FBC02D', '#F9A825',
    '#F57F17'),
  c('#FFF3E0', '#FFE0B2', '#FFCC80',
    '#FFB74D', '#FFA726', '#FF9800',
    '#FB8C00', '#F57C00', '#EF6C00',
    '#E65100')
)

f7ColorPickerModules <- c(
  "wheel", "sb-spectrum",
  "hue-slider", "hs-spectrum",
  "brightness-slider", "rgb-slider",
  "hsb-sliders", "alpha-slider",
  "rgb-bars", "palette", "hex",
  "current-color", "initial-current-colors"
)



globalVariables(c("f7ColorPickerPalettes", "f7ColorPickerModules"))

#' Create a Framework7 color picker input
#'
#' @param inputId Color picker input.
#' @param label Color picker label.
#' @param value Color picker value. hex, rgb, hsl, hsb, alpha, hue,
#' rgba, hsla are supported.
#' @param placeholder Color picker placeholder.
#' @param modules Picker color modules. Choose at least one.
#' @param palettes Picker color predefined palettes. Must be a list
#' of color vectors, each value specified as HEX string.
#' @param sliderValue When enabled, it will display sliders values.
#' @param sliderValueEditable When enabled, it will display sliders values as <input>
#' elements to edit directly.
#' @param sliderLabel When enabled, it will display sliders labels with text.
#' @param hexLabel When enabled, it will display HEX module label text, e.g. HEX.
#' @param hexValueEditable When enabled, it will display HEX module value as <input> element to edit directly.
#' @param groupedModules When enabled it will add more exposure
#' to sliders modules to make them look more separated.
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
#'        navbar = f7Navbar(title = "f7ColorPicker"),
#'        f7ColorPicker(
#'          inputId = "mycolorpicker",
#'          placeholder = "Some text here!",
#'          label = "Select a color"
#'        ),
#'        "The picker value is:",
#'        textOutput("colorPickerVal")
#'      )
#'    ),
#'    server = function(input, output) {
#'      output$colorPickerVal <- renderText(input$mycolorpicker)
#'    }
#'  )
#' }
f7ColorPicker <- function(inputId, label, value = "#ff0000", placeholder = NULL,
                          modules = f7ColorPickerModules, palettes = f7ColorPickerPalettes,
                          sliderValue =  TRUE, sliderValueEditable = TRUE,
                          sliderLabel = TRUE, hexLabel = TRUE,
                          hexValueEditable = TRUE, groupedModules = TRUE) {

  # if the value is provided as a rgb, hsl, hsb, rgba or hsla
  if (is.numeric(value) & length(value) > 1) value <- jsonlite::toJSON(value)

  modules <- jsonlite::toJSON(modules)
  palettes <- jsonlite::toJSON(palettes)
  # We define a global variable that is
  # reused in the pickerInputBinding.js
  pickerProps <- shiny::tags$script(
    paste0(
      'var colorPickerModules = ', modules, ';
       var colorPickerPalettes = ', palettes, ';
       var colorPickerValue = "', value, '";
       var colorPickerSliderValue = ', tolower(sliderValue), ';
       var colorPickerSliderValueEditable = ', tolower(sliderValueEditable), ';
       var colorPickerSliderLabel = ', tolower(sliderLabel), ';
       var colorPickerHexLabel = ', tolower(hexLabel), ';
       var colorPickerHexValueEditable = ', tolower(hexValueEditable), ';
       var colorPickerGroupedModules = ', tolower(groupedModules), ';
      '
    )
  )


  inputTag <- shiny::tags$input(
    type = "text",
    placeholder = placeholder,
    id = inputId,
    class = "color-picker-input"
  )

  wrapperTag <- shiny::tags$div(
    class = "list no-hairlines-md",
    shiny::tags$ul(
      shiny::tags$li(
        shiny::tags$div(
          class = "item-content item-input",
          shiny::tags$div(
            class = "item-media",
            shiny::tags$i(
              class = "icon demo-list-icon",
              id = paste0(inputId, "-value")
            )
          ),
          shiny::tags$div(
            class = "item-inner",
            shiny::tags$div(
              class = "item-input-wrap",
              inputTag
            )
          )
        )
      )
    )
  )

  labelTag <- shiny::tags$div(class = "block-title", label)
  shiny::tagList(
    shiny::singleton(pickerProps),
    labelTag,
    wrapperTag
  )

}





#' Framework7 date picker
#'
#' \code{f7DatePicker} creates a Framework7 date picker input.
#'
#' @param inputId Date input id.
#' @param label Input label.
#' @param value Array with initial selected dates. Each array item represents selected date.
#' @param multiple If \code{TRUE} allow to select multiple dates.
#' @param direction Months layout direction, could be 'horizontal' or 'vertical'.
#' @param minDate Minimum allowed date.
#' @param maxDate Maximum allowed date.
#' @param dateFormat Date format: "yyyy-mm-dd", for instance.
#' @param openIn Can be auto, popover (to open calendar in popover), sheet
#' (to open in sheet modal) or customModal (to open in custom Calendar modal overlay).
#' In case of auto will open in sheet modal on small screens and in popover on large screens.
#' @param scrollToInput Scroll viewport (page-content) to input when calendar opened.
#' @param closeByOutsideClick If enabled, picker will be closed by clicking outside of picker or related input element.
#' @param toolbar Enables calendar toolbar.
#' @param toolbarCloseText Text for Done/Close toolbar button.
#' @param header Enables calendar header.
#' @param headerPlaceholder Default calendar header placeholder text.
#'
#' @importFrom jsonlite toJSON
#' @rdname datepicker
#'
#' @return a \code{Date} vector.
#'
#' @export
#' @examples
#' # Date picker
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   shinyApp(
#'     ui = f7Page(
#'       title = "My app",
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "f7DatePicker"),
#'         f7DatePicker(
#'           inputId = "date",
#'           label = "Choose a date",
#'           value = "2019-08-24"
#'         ),
#'         "The selected date is",
#'         verbatimTextOutput("selectDate"),
#'         f7DatePicker(
#'           inputId = "multipleDates",
#'           label = "Choose multiple dates",
#'           value = Sys.Date() + 0:3,
#'           multiple = TRUE
#'         ),
#'         "The selected date is",
#'         verbatimTextOutput("selectMultipleDates"),
#'         f7DatePicker(
#'           inputId = "default",
#'           label = "Choose a date",
#'           value = NULL
#'         ),
#'         "The selected date is",
#'         verbatimTextOutput("selectDefault")
#'       )
#'     ),
#'     server = function(input, output, session) {
#'
#'       output$selectDate <- renderPrint(input$date)
#'       output$selectMultipleDates <- renderPrint(input$multipleDates)
#'       output$selectDefault <- renderPrint(input$default)
#'
#'     }
#'   )
#' }
f7DatePicker <- function(inputId, label, value = NULL, multiple = FALSE, direction = c("horizontal", "vertical"),
                         minDate = NULL, maxDate = NULL, dateFormat = "yyyy-mm-dd",
                         openIn = c("auto", "popover", "sheet", "customModal"),
                         scrollToInput = FALSE, closeByOutsideClick = TRUE,
                         toolbar = TRUE, toolbarCloseText = "Done", header = FALSE,
                         headerPlaceholder = "Select date") {

  direction <- match.arg(direction)
  openIn <- match.arg(openIn)

  if (!is.null(value) && length(value) == 1) {
    value <- list(value)
  }

  config <- dropNulls(list(
    value = value,
    multiple = multiple,
    direction = direction,
    minDate = minDate,
    maxDate = maxDate,
    dateFormat = dateFormat,
    openIn = openIn,
    scrollToInput = scrollToInput,
    closeByClickOutside = closeByOutsideClick,
    toolbar = toolbar,
    toolbarCloseText = toolbarCloseText,
    header = header,
    headerPlaceholder = headerPlaceholder
  ))

  # date picker props
  datePickerTag <- shiny::tags$input(
    type = "text",
    class = "calendar-input",
    id = inputId
  )

  # label
  labelTag <- shiny::tags$div(class = "block-title", label)

  shiny::tagList(
    if (!is.null(label)) labelTag,
    # input tag
    shiny::tags$div(
      class = "list no-hairlines-md",
      shiny::tags$ul(
        shiny::tags$li(
          shiny::tags$div(
            class = "item-content item-input",
            shiny::tags$div(
              class = "item-inner",
              shiny::tags$div(
                class = "item-input-wrap",
                datePickerTag,
                shiny::tags$script(
                  type = "application/json",
                  `data-for` = inputId,
                  jsonlite::toJSON(
                    x = config,
                    auto_unbox = TRUE,
                    json_verbatim = TRUE
                  )
                )
              )
            )
          )
        )
      )
    )
  )
}





#' Update Framework7 date picker
#'
#' \code{updateF7DatePicker} changes the value of a date picker input on the client.
#'
#' @param inputId The id of the input object.
#' @param value The new value for the input.
#' @param ... Parameters used to update the date picker,
#'  use same arguments as in \code{\link{f7DatePicker}}.
#' @param session The Shiny session object, usually the default value will suffice.
#'
#' @export
#'
#' @rdname datepicker
#'
#' @examples
#' # Update date picker
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
#'           inputId = "mypicker",
#'           value = Sys.Date()
#'         )
#'       })
#'
#'       observeEvent(input$rmToolbar, {
#'         updateF7DatePicker(
#'           inputId = "mypicker",
#'           toolbar = FALSE,
#'           dateFormat = "yyyy-mm-dd" # preserve date format
#'         )
#'       })
#'
#'       observeEvent(input$addToolbar, {
#'         updateF7DatePicker(
#'           inputId = "mypicker",
#'           toolbar = TRUE,
#'           dateFormat = "yyyy-mm-dd" # preserve date format
#'         )
#'       })
#'
#'     }
#'   )
#' }
updateF7DatePicker <- function(inputId, value = NULL, ...,
                               session = shiny::getDefaultReactiveDomain()) {
  if (!is.null(value)) {
    if (length(value) == 1) {
      value <- list(as.character(value))
    } else {
      value <- as.character(value)
    }
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





#' Framework7 checkbox
#'
#' \code{f7Checkbox} creates a checkbox input.
#'
#' @param inputId The input slot that will be used to access the value.
#' @param label Display label for the control, or NULL for no label.
#' @param value Initial value (TRUE or FALSE).
#'
#' @rdname checkbox
#'
#' @export
f7checkBox <- function(inputId, label, value = FALSE) {

  .Deprecated(
    "f7Checkbox",
    package = "shinyMobile",
    "f7checkBox will be removed in future release. Please use
    f7Checkbox instead.",
    old = as.character(sys.call(sys.parent()))[1L]
  )
  f7Checkbox(inputId, label, value)
}


#' Framework7 checkbox
#'
#' \link{f7Checkbox} creates a checkbox input.
#'
#' @param inputId The input slot that will be used to access the value.
#' @param label Display label for the control, or NULL for no label.
#' @param value Initial value (TRUE or FALSE).
#'
#' @rdname checkbox
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'    ui = f7Page(
#'     title = "My app",
#'     f7SingleLayout(
#'      navbar = f7Navbar(title = "f7Checkbox"),
#'      f7Card(
#'       f7Checkbox(
#'        inputId = "check",
#'        label = "Checkbox",
#'        value = FALSE
#'       ),
#'       verbatimTextOutput("test")
#'      )
#'     )
#'    ),
#'    server = function(input, output) {
#'     output$test <- renderPrint({input$check})
#'    }
#'  )
#' }
#
#' @export
f7Checkbox <- function(inputId, label, value = FALSE) {

  value <- shiny::restoreInput(id = inputId, default = value)
  inputTag <- shiny::tags$input(id = inputId, type = "checkbox")
  if (!is.null(value) && value)
    inputTag$attribs$checked <- "checked"
  shiny::tags$label(
    class = "item-checkbox item-content shiny-input-container",
    inputTag,
    shiny::tags$i(class = "icon icon-checkbox"),
    shiny::tags$div(
      class = "item-inner",
      shiny::tags$div(class = "item-title", label)
    )
  )
}


 
#' Deprecated functions
#'
#' \code{f7checkBox} creates a checkbox input. Use \link{f7Checkbox} instead.
#'
#' @rdname f7-deprecated
#' @inheritParams f7checkBoxGroup
#' @keywords internal
#' @export
f7checkBox <- function(inputId, label, value = FALSE){

  .Deprecated(
    "f7Checkbox",
    package = "shinyMobile",
    "f7checkBox will be removed in future release. Please use
      f7Checkbox instead.",
    old = as.character(sys.call(sys.parent()))[1L])
  f7Checkbox(inputId, label, value)
}


#' Update Framework7 checkbox
#'
#' \code{updateF7Checkbox} changes the value of a checkbox input on the client.
#'
#' @rdname checkbox
#' @param inputId The id of the input object.
#' @param label The label to set for the input object.
#' @param value The value to set for the input object.
#' @param session The Shiny session object.
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
#'      updateF7Checkbox("check", value = x_even)
#'    })
#'  }
#'
#' shinyApp(ui, server)
#' }
updateF7Checkbox <- function(inputId, label = NULL, value = NULL,
                             session = shiny::getDefaultReactiveDomain()) {
  message <- dropNulls(list(label=label, value=value))
  session$sendInputMessage(inputId, message)
}




#' Framework7 checkbox group
#'
#' \code{f7CheckboxGroup} creates a checkbox group input
#'
#' @param inputId Checkbox group input.
#' @param label Checkbox group label.
#' @param choices Checkbox group choices.
#' @param selected Checkbox group selected value.
#'
#' @export
#' @rdname checkboxgroup
#'
#' @examples
#' if(interactive()){
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   shiny::shinyApp(
#'     ui = f7Page(
#'      title = "My app",
#'      f7SingleLayout(
#'       navbar = f7Navbar(title = "f7CheckboxGroup"),
#'       f7CheckboxGroup(
#'        inputId = "variable",
#'        label = "Choose a variable:",
#'        choices = colnames(mtcars)[-1],
#'        selected = NULL
#'       ),
#'       tableOutput("data")
#'      )
#'     ),
#'     server = function(input, output) {
#'      output$data <- renderTable({
#'       mtcars[, c("mpg", input$variable), drop = FALSE]
#'       }, rownames = TRUE)
#'     }
#'   )
#'  }
f7CheckboxGroup <- function(inputId, label, choices = NULL, selected = NULL) {

  selectedPosition <- if (!is.null(selected)) match(selected, choices) else NULL

  choicesTag <- lapply(X = seq_along(choices), function(i) {
    shiny::tags$li(
      shiny::tags$label(
        class = "item-checkbox item-content",
        shiny::tags$input(
          type = "checkbox",
          name = inputId,
          value = choices[[i]]
        ),
        shiny::tags$i(class = "icon icon-checkbox"),
        shiny::tags$div(
          class = "item-inner",
          shiny::tags$div(class="item-title", choices[[i]])
        )
      )
    )
  })

  if (!is.null(selected)) choicesTag[[selectedPosition]]$children[[1]]$children[[1]]$attribs[["checked"]] <- NA

  shiny::tagList(
    shiny::tags$div(
      class = "block-title",
      label
    ),
    shiny::tags$div(
      class = "list shiny-input-checkboxgroup",
      id = inputId,
      shiny::tags$ul(
        choicesTag
      )
    )
  )

}



#' Deprecated functions
#'
#' \code{f7checkBoxGroup} creates a checkbox group input.
#' Use \link{f7CheckboxGroup} instead
#'
#' @rdname f7-deprecated
#' @inheritParams f7checkBoxGroup
#' @keywords internal
#' @export
f7checkBoxGroup <- function(inputId, label, choices = NULL, selected = NULL) {

  .Deprecated(
    "f7CheckboxGroup",
    package = "shinyMobile",
    "f7checkBoxGroup will be removed in future release. Please use
    f7CheckboxGroup instead.",
    old = as.character(sys.call(sys.parent()))[1L]
  )

  f7CheckboxGroup(inputId, label, choices, selected)
}




#' Create option html tag based on choice input
#'
#' Used by \link{f7SmartSelect} and \link{f7Select}
#'
#' @param choices Vector of possibilities.
#' @param selected Default selected value.
#'
createSelectOptions <- function(choices, selected) {
  choices <- choicesWithNames(choices)
  options <- lapply(X = seq_along(choices), function(i) {
    if (inherits(choices[[1]], "list")) {
      shiny::tags$optgroup(
        label = names(choices)[i],
        lapply(X = seq_along(choices[[i]]), function(j) {
          shiny::tags$option(
            value = choices[[i]][[j]],
            names(choices[[i]])[j],
            selected = if (!is.null(selected)) {
              if (choices[[i]][[j]] %in% selected) NA else NULL
            }
          )
        })
      )
    } else {
      shiny::tags$option(
        value = choices[[i]],
        names(choices)[i],
        selected = if (!is.null(selected)) {
          if (choices[[i]] %in% selected) NA else NULL
        }
      )
    }
  })

  return(options)
}


choicesWithNames <- function(choices) {
  listify <- function(obj) {
    makeNamed <- function(x) {
      if (is.null(names(x)))
        names(x) <- character(length(x))
      x
    }
    res <- lapply(obj, function(val) {
      if (is.list(val))
        listify(val)
      else if (length(val) == 1 && is.null(names(val)))
        val
      else makeNamed(as.list(val))
    })
    makeNamed(res)
  }
  choices <- listify(choices)
  if (length(choices) == 0)
    return(choices)
  choices <- mapply(choices, names(choices), FUN = function(choice,
                                                            name) {
    if (!is.list(choice))
      return(choice)
    if (name == "")
      stop("All sub-lists in \"choices\" must be named.")
    choicesWithNames(choice)
  }, SIMPLIFY = FALSE)
  missing <- names(choices) == ""
  names(choices)[missing] <- as.character(choices)[missing]
  choices
}


#' Framework7 select input
#'
#' \code{f7Select} creates a select input.
#'
#' @param inputId Select input id.
#' @param label Select input label.
#' @param choices Select input choices.
#' @param selected Select input default selected value.
#' @param width The width of the input, e.g. \code{400px}, or \code{100\%}.
#'
#' @export
#' @rdname select
#'
#' @examples
#' # Select input
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'      title = "My app",
#'      f7SingleLayout(
#'       navbar = f7Navbar(title = "f7Select"),
#'       f7Select(
#'        inputId = "variable",
#'        label = "Choose a variable:",
#'        choices = colnames(mtcars)[-1],
#'        selected = "hp"
#'       ),
#'       tableOutput("data")
#'      )
#'    ),
#'    server = function(input, output) {
#'      output$data <- renderTable({
#'        mtcars[, c("mpg", input$variable), drop = FALSE]
#'      }, rownames = TRUE)
#'    }
#'  )
#' }
f7Select <- function(inputId, label, choices, selected = NULL, width = NULL) {


  options <- createSelectOptions(choices, selected)

  shiny::tags$div(
    class = "list",
    style = if (!is.null(width)) paste0("width:", htmltools::validateCssUnit(width), ";"),
    shiny::tags$ul(
      shiny::tags$li(
        class = "item-content item-input",
        shiny::tags$div(
          class = "item-inner",
          shiny::tags$div(class = "item-title item-label", label),

          shiny::tags$div(
            class = "item-input-wrap input-dropdown-wrap",
            shiny::tags$select(
              class = "input-select",
              id = inputId,
              placeholer = "Please choose...",
              options
            )
          )
        )
      )
    )
  )
}




#' Update Framework7 select
#'
#' \code{updateF7Select} changes the value of a select input on the client
#'
#' @param inputId The id of the input object.
#' @param selected New value.
#' @param session The Shiny session object, usually the default value will suffice.
#'
#' @export
#' @rdname select
#'
#' @examples
#' # Update select input
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
#'          inputId = "variable",
#'          selected = "gear"
#'        )
#'      })
#'    }
#'  )
#' }
updateF7Select <- function(inputId, selected = NULL,
                           session = shiny::getDefaultReactiveDomain()) {
  message <- dropNulls(list(
    selected = selected
  ))
  session$sendInputMessage(inputId, message)
}





#' Framework7 smart select
#'
#' \code{f7SmartSelect} is smarter than the classic \link{f7Select},
#' allows for choices filtering, ...
#'
#' @param inputId Select input id.
#' @param label Select input label.
#' @param choices Select input choices.
#' @param selected Default selected item.
#' @param openIn Smart select type: either \code{c("sheet", "popup", "popover")}.
#' Note that the search bar is only available when the type is popup.
#' @param searchbar Whether to enable the search bar. TRUE by default.
#' @param multiple Whether to allow multiple values. FALSE by default.
#' @param maxlength Maximum items to select when multiple is TRUE.
#' @param virtualList Enable Virtual List for smart select if your select has a lot
#' of options. Default to FALSE.
#' @param ... Other options. See \url{https://v5.framework7.io/docs/smart-select.html#smart-select-parameters}.
#'
#' @rdname smartselect
#'
#' @export
#'
#' @examples
#' # Smart select input
#' if (interactive()) {
#' library(shiny)
#' library(shinyMobile)
#'
#'  shinyApp(
#'    ui = f7Page(
#'      title = "My app",
#'      f7SingleLayout(
#'        navbar = f7Navbar(title = "f7SmartSelect"),
#'        f7SmartSelect(
#'          inputId = "variable",
#'          label = "Choose a variable:",
#'          selected = "drat",
#'          choices = colnames(mtcars)[-1],
#'          openIn = "popup"
#'        ),
#'        tableOutput("data"),
#'        f7SmartSelect(
#'          inputId = "variable2",
#'          label = "Group variables:",
#'          choices = list(
#'           `East Coast` = list("NY", "NJ", "CT"),
#'           `West Coast` = list("WA", "OR", "CA"),
#'           `Midwest` = list("MN", "WI", "IA")
#'          ),
#'          openIn = "sheet"
#'        ),
#'        textOutput("var")
#'      )
#'    ),
#'    server = function(input, output) {
#'      output$var <- renderText(input$variable2)
#'      output$data <- renderTable({
#'        mtcars[, c("mpg", input$variable), drop = FALSE]
#'      }, rownames = TRUE)
#'    }
#'  )
#' }
f7SmartSelect <- function(inputId, label, choices, selected = NULL,
                          openIn = c("page", "sheet", "popup", "popover"),
                          searchbar = TRUE, multiple = FALSE, maxlength = NULL,
                          virtualList = FALSE, ...) {

  options <- createSelectOptions(choices, selected)
  type <- match.arg(openIn)

  config <- dropNulls(list(
    openIn = openIn,
    searchbar = searchbar,
    searchbarPlaceholder = "Search",
    virtualList = virtualList,
    ...
  ))

  shiny::tags$div(
    class = "list",
    shiny::tags$ul(
      shiny::tags$li(
        shiny::tags$a(
          class = "item-link smart-select",
          id = inputId,
          shiny::tags$select(
            id = inputId,
            multiple = if (multiple) NA else NULL,
            maxlength = if (!is.null(maxlength)) maxlength else NULL,
            options
          ),
          shiny::tags$div(
            class = "item-content",
            shiny::tags$div(
              class = "item-inner",
              shiny::tags$div(
                class = "item-title", label
              )
            )
          ),
          shiny::tags$script(
            type = "application/json",
            `data-for` = inputId,
            jsonlite::toJSON(
              x = config,
              auto_unbox = TRUE,
              json_verbatim = TRUE
            )
          )
        )
      )
    )
  )
}




#' Update Framework7 smart select
#'
#' \code{updateF7SmartSelect} changes the value of a smart select input on the client.
#'
#' @param inputId The id of the input object.
#' @param selected The new value for the input.
#' @param choices The new choices.
#' @param ... Parameters used to update the smart select,
#'  use same arguments as in \code{\link{f7SmartSelect}}.
#' @param multiple Whether to allow multiple values.
#' @param maxLength Maximum items to select when multiple is TRUE.
#' @param session The Shiny session object, usually the default value will suffice.
#'
#' @rdname smartselect
#' @export
#'
#' @examples
#' # Update smart select
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'   ui = f7Page(
#'     title = "My app",
#'     f7SingleLayout(
#'       navbar = f7Navbar(title = "Update f7SmartSelect"),
#'       f7Button("updateSmartSelect", "Update Smart Select"),
#'       f7SmartSelect(
#'         inputId = "variable",
#'         label = "Choose a variable:",
#'         selected = "drat",
#'         choices = colnames(mtcars)[-1],
#'         openIn = "popup"
#'       ),
#'       tableOutput("data")
#'     )
#'   ),
#'   server = function(input, output, session) {
#'     output$data <- renderTable({
#'       mtcars[, c("mpg", input$variable), drop = FALSE]
#'     }, rownames = TRUE)
#'
#'     observeEvent(input$updateSmartSelect, {
#'       updateF7SmartSelect(
#'         inputId = "variable",
#'         openIn = "sheet",
#'         selected = "hp",
#'         choices = c("hp", "gear"),
#'         multiple = TRUE,
#'         maxLength = 3
#'       )
#'     })
#'   }
#'  )
#' }
updateF7SmartSelect <- function(inputId, selected = NULL, choices = NULL, multiple = NULL,
                                maxLength = NULL, ...,
                                session = shiny::getDefaultReactiveDomain()) {

  if (!is.null(selected)) {
    if (length(selected) == 1) {
      selected <- list(as.character(selected))
    } else {
      selected <- as.character(selected)
    }
  }
  config <- dropNulls(list(...))
  if (length(config) == 0)
    config <- NULL
  message <- dropNulls(list(
    selected = selected,
    choices = choices,
    multiple = multiple,
    maxLength = maxLength,
    config = config
  ))
  session$sendInputMessage(inputId, message)
}




#' Framework7 text input
#'
#' \code{f7Text} creates a text input container.
#'
#' @param inputId Text input id.
#' @param label Text input label.
#' @param value Text input value.
#' @param placeholder Text input placeholder.
#'
#' @rdname text
#'
#' @export
#'
#' @examples
#' # A text input
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'    ui = f7Page(
#'      title = "My app",
#'      f7SingleLayout(
#'       navbar = f7Navbar(title = "f7Text"),
#'       f7Text(
#'        inputId = "caption",
#'        label = "Caption",
#'        value = "Data Summary",
#'        placeholder = "Your text here"
#'       ),
#'       verbatimTextOutput("value")
#'      )
#'    ),
#'    server = function(input, output) {
#'      output$value <- renderPrint({ input$caption })
#'    }
#'  )
#' }
f7Text <- function(inputId, label, value = "", placeholder = NULL#,
                   #style = NULL, inset = FALSE, icon = NULL
                   ) {

  # possible styles c("inline", "floating", "outline")

  wrapperCl <- "list"
  #if (inset) wrapperCl <- paste0(wrapperCl, " inset")

  itemCl <- "item-content item-input"
  itemLabelCl <- "item-title"

  #if (!is.null(style)) {
  #  if (style == "inline") wrapperCl <- paste0(wrapperCl, " inline-labels")
  #  if (style == "outline") itemCl <- paste0(itemCl, " item-input-outline")
  #  if (style == "floating") itemLabelCl <- paste0(itemLabelCl, " item-floating-label")
  #}

  inputTag <- shiny::tags$input(
    id = inputId,
    value = value,
    type = "text",
    placeholder = placeholder
  )


  shiny::tags$div(
    class = wrapperCl,
    #id = inputId,
    shiny::tags$ul(
      shiny::tags$li(
        class = itemCl,
        #if (!is.null(icon)) shiny::tags$div(class = "item-media", icon),
        shiny::tags$div(
          class = "item-inner",
          shiny::tags$div(class = itemLabelCl, label),
          shiny::tags$div(
            class = "item-input-wrap",
            inputTag,
            shiny::span(class="input-clear-button")
          )
        )
      )
    )
  )
}



#' Update Framework7 text input
#'
#' \code{updateF7Text} changes the value of a text input on the client.
#'
#' @param inputId The id of the input object.
#' @param label The label to set for the input object.
#' @param value The value to set for the input object.
#' @param placeholder The placeholder to set for the input object.
#' @param session The Shiny session object, usually the default value will suffice.
#'
#' @export
#' @rdname text
#'
#' @examples
#' # Update text input
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  ui <- f7Page(
#'    f7SingleLayout(
#'     navbar = f7Navbar(title = "updateF7Text"),
#'     f7Block(f7Button("trigger", "Click me")),
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
#'      updateF7Text("text", value = "Updated Text")
#'    })
#'  }
#' shinyApp(ui, server)
#' }
updateF7Text <- function(inputId, label = NULL, value = NULL, placeholder = NULL, session = shiny::getDefaultReactiveDomain()) {
  message <- dropNulls(list(label=label, value=value, placeholder=placeholder))
  session$sendInputMessage(inputId, message)
}



# #' Create an f7 date input
# #'
# #' This does only work for mobiles or tablets!
# #'
# #' @param inputId Date input id.
# #' @param label Date input label.
# #' @param value Date input value.
# #' @param placeholder Date input placeholder.
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
# #'      f7SingleLayout(
# #'       navbar = f7Navbar(title = "f7Date"),
# #'       f7Date(inputId = "date", label = "Date", value = "2014-04-30"),
# #'       verbatimTextOutput("datevalue")
# #'      )
# #'    ),
# #'    server = function(input, output) {
# #'      output$datevalue <- renderPrint({ input$date })
# #'    }
# #'  )
# #' }
# f7Date <- function(inputId, label, value = "", placeholder = NULL) {
#
#   shiny::tags$div(
#     class = "list",
#     shiny::tags$ul(
#       shiny::tags$li(
#         class = "item-content item-input item-input-outline",
#         shiny::tags$div(
#           class = "item-inner",
#           shiny::tags$div(class = "item-title item-label", label),
#           shiny::tags$div(
#             class = "item-input-wrap",
#             shiny::tags$input(
#               id = inputId,
#               value = value,
#               type = "date",
#               placeholder = placeholder,
#               class = "date-input"
#             )
#           )
#         )
#       )
#     )
#   )
# }




#' Framework7 text area input
#'
#' \code{f7TextArea} creates a f7 text area input.
#'
#' @inheritParams f7Text
#' @param resize Whether to box can be resized. Default to FALSE.
#'
#' @export
#' @rdname textarea
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'    ui = f7Page(
#'      title = "My app",
#'      f7TextArea(
#'       inputId = "textarea",
#'       label = "Text Area",
#'       value = "Lorem ipsum dolor sit amet, consectetur
#'        adipiscing elit, sed do eiusmod tempor incididunt ut
#'        labore et dolore magna aliqua",
#'       placeholder = "Your text here",
#'       resize = TRUE
#'      ),
#'      textOutput("value")
#'    ),
#'    server = function(input, output) {
#'      output$value <- renderText({ input$textarea })
#'    }
#'  )
#' }
f7TextArea <- function(inputId, label, value = "", placeholder = NULL,
                       resize = FALSE) {

  areaCl <- if (resize) "resizable" else NULL

  shiny::tags$div(
    class = "list",
    shiny::tags$ul(
      shiny::tags$li(
        class = "item-content item-input",
        shiny::tags$div(
          class = "item-inner",
          shiny::tags$div(class = "item-title item-label", label),
          shiny::tags$div(
            class = "item-input-wrap",
            shiny::tags$textarea(
              id = inputId,
              value,
              placeholder = placeholder,
              class = areaCl
            ),
            shiny::span(class = "input-clear-button")
          )
        )
      )
    )
  )
}




#' Update Framework7 text area input
#'
#' \code{updateF7TextArea} changes the value of a text area input on the client.
#'
#' @inheritParams updateF7Text
#' @rdname textarea
#' @export
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  ui <- f7Page(
#'    f7SingleLayout(
#'     navbar = f7Navbar(title = "updateF7TextArea"),
#'     f7Block(f7Button("trigger", "Click me")),
#'     f7TextArea(
#'      inputId = "textarea",
#'      label = "Text Area",
#'      value = "Lorem ipsum dolor sit amet, consectetur
#'               adipiscing elit, sed do eiusmod tempor incididunt ut
#'               labore et dolore magna aliqua",
#'      placeholder = "Your text here",
#'      resize = TRUE
#'      ),
#'     verbatimTextOutput("value")
#'    )
#'  )
#'
#'  server <- function(input, output, session) {
#'    output$value <- renderPrint(input$textarea)
#'    observeEvent(input$trigger, {
#'      updateF7Text("textarea", value = "Updated Text")
#'    })
#'  }
#' shinyApp(ui, server)
#' }
updateF7TextArea <- updateF7Text



#' Create an f7 password input
#'
#' @inheritParams f7Text
#' @export
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
#'       navbar = f7Navbar(title = "f7Password"),
#'       f7Password(
#'        inputId = "password",
#'        label = "Password:",
#'        placeholder = "Your password here"
#'       ),
#'       verbatimTextOutput("value")
#'      )
#'    ),
#'    server = function(input, output) {
#'      output$value <- renderPrint({ input$password })
#'    }
#'  )
#' }
f7Password <- function(inputId, label, value = "", placeholder = NULL) {
  shiny::tags$div(
    class = "list",
    shiny::tags$ul(
      shiny::tags$li(
        class = "item-content item-input",
        shiny::tags$div(
          class = "item-inner",
          shiny::tags$div(class = "item-title item-label", label),
          shiny::tags$div(
            class = "item-input-wrap",
            shiny::tags$input(
              id = inputId,
              value = value,
              type = "password",
              placeholder = placeholder,
              class = ""
            ),
            shiny::span(class = "input-clear-button")
          )
        )
      )
    )
  )
}



#' Framework7 range slider
#'
#' \code{f7Slider} creates a f7 slider input.
#'
#' @param inputId Slider input id.
#' @param label Slider label.
#' @param min Slider minimum range.
#' @param max Slider maximum range.
#' @param value Slider value or a vector containing 2 values (for a range).
#' @param step Slider increase step size.
#' @param scale Slider scale.
#' @param scaleSteps Number of scale steps.
#' @param scaleSubSteps Number of scale sub steps (each step will be divided by this value).
#' @param vertical Whether to apply a vertical display. FALSE by default.
#' @param verticalReversed Makes vertical range slider reversed (vertical must be also enabled).
#' FALSE by default.
#' @param labels Enables additional label around range slider knob. List of 2 \link{f7Icon}
#' expected.
#' @param color See \link{getF7Colors} for valid colors.
#' @param noSwipping Prevent swiping when slider is manipulated in an \link{f7TabLayout}.
#'
#' @note labels option only works when vertical is FALSE!
#'
#' @rdname slider
#'
#' @export
#'
#' @examples
#' # Slider input
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'    ui = f7Page(
#'     title = "My app",
#'     f7SingleLayout(
#'      navbar = f7Navbar(title = "f7Slider"),
#'      f7Card(
#'       f7Slider(
#'        inputId = "obs",
#'        label = "Number of observations",
#'        max = 1000,
#'        min = 0,
#'        value = 100,
#'        scaleSteps = 5,
#'        scaleSubSteps = 3,
#'        scale = TRUE,
#'        color = "orange",
#'        labels = tagList(
#'         f7Icon("circle"),
#'         f7Icon("circle_fill")
#'        )
#'       ),
#'       verbatimTextOutput("test")
#'      ),
#'      plotOutput("distPlot")
#'     )
#'    ),
#'    server = function(input, output) {
#'     output$test <- renderPrint({input$obs})
#'     output$distPlot <- renderPlot({
#'      hist(rnorm(input$obs))
#'     })
#'    }
#'  )
#' }
#'
#' # Create a range
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'    ui = f7Page(
#'     title = "My app",
#'     f7SingleLayout(
#'      navbar = f7Navbar(title = "f7Slider Range"),
#'      f7Card(
#'       f7Slider(
#'        inputId = "obs",
#'        label = "Range values",
#'        max = 500,
#'        min = 0,
#'        value = c(50, 100),
#'        scale = FALSE
#'       ),
#'       verbatimTextOutput("test")
#'      )
#'     )
#'    ),
#'    server = function(input, output) {
#'     output$test <- renderPrint({input$obs})
#'    }
#'  )
#' }
#'
f7Slider <- function(inputId, label, min, max, value, step = 1, scale = FALSE,
                     scaleSteps = 5, scaleSubSteps = 0, vertical = FALSE,
                     verticalReversed = FALSE, labels = NULL, color = NULL,
                     noSwipping = TRUE) {

  if (!is.null(labels)) {
    if (length(labels) < 2) stop("labels must be a tagList with 2 elements.")
  }

  sliderCl <- "range-slider"
  if (!is.null(color)) sliderCl <- paste0(sliderCl, " color-", color)

  if (isTRUE(noSwipping)) {
    sliderCl <- paste(sliderCl, "swiper-no-swiping")
  }

  sliderProps <- dropNulls(
    list(
      class = sliderCl,
      id = inputId,
      style = if (vertical) {
        if (scale) {
          "height: 160px; margin: 20px;"
        } else {
          "height: 160px;"
        }
      } else {
        NULL
      },
      `data-dual` = if (length(value) == 2) "true" else NULL,
      `data-min`= min,
      `data-max`= max,
      `data-vertical` = tolower(vertical),
      `data-vertical-reversed` = if (vertical) tolower(verticalReversed) else NULL,
      `data-label`= "true",
      `data-step`= step,
      `data-value`= if (length(value) == 1) value else NULL,
      `data-value-left` = if (length(value) == 2) value[1] else NULL,
      `data-value-right` = if (length(value) == 2) value[2] else NULL,
      `data-scale`= tolower(scale),
      `data-scale-steps`= scaleSteps,
      `data-scale-sub-steps` = scaleSubSteps
    )
  )

  # wrap props
  rangeTag <- do.call(shiny::tags$div, sliderProps)


  labels <- if (!is.null(labels)) {
    lapply(seq_along(labels), function(i) {
      isF7Icon <- (grep(x = labels[[i]][[1]]$attribs$class, pattern = "f7-icons") == 1)
      if (class(labels[[i]][[1]]) != "shiny.tag" || !isF7Icon) {
        stop("Label must be a f7Icon.")
      }
      shiny::tags$div(
        class = "item-cell width-auto flex-shrink-0",
        labels[[i]]
      )
    })
  } else {
    NULL
  }

  # wrapper
  shiny::tags$div(
    # HTML skeleton
    if (!is.null(label)) shiny::tags$div(class = "block-title", label),
    if (!is.null(labels)) {
      shiny::tags$div(
        class = "list simple-list",
        shiny::tags$ul(
          shiny::tags$li(
            labels[[1]],
            shiny::tags$div(class = "item-cell flex-shrink-3", rangeTag),
            labels[[2]]
          )
        )
      )
    } else {
      shiny::tags$div(class = "block", rangeTag)
    }
  )
}




#' Update Framework7 range slider
#'
#' \code{updateF7Slider} changes the value of a slider input on the client.
#'
#' @param inputId The id of the input object.
#' @param min Slider minimum range.
#' @param max Slider maximum range
#' @param value Slider value or a vector containing 2 values (for a range).
#' @param scale Slider scale.
#' @param scaleSteps Number of scale steps.
#' @param scaleSubSteps Number of scale sub steps (each step will be divided by this value).
#' @param step Slider increase step size.
#' @param color See \link{getF7Colors} for valid colors.
#' @param session The Shiny session object.
#'
#' @export
#' @rdname slider
#'
#' @note Important: you cannot transform a range slider into a simple slider and inversely.
#'
#' @examples
#' # Update f7Slider
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
updateF7Slider <- function(inputId, min = NULL, max = NULL, value = NULL,
                           scale = FALSE, scaleSteps = NULL, scaleSubSteps = NULL,
                           step = NULL, color = NULL,
                           session = shiny::getDefaultReactiveDomain()) {
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




#' Framework7 stepper input
#'
#' \code{f7Stepper} creates a stepper input.
#'
#' @param inputId Stepper input id.
#' @param label Stepper label.
#' @param min Stepper minimum value.
#' @param max Stepper maximum value.
#' @param value Stepper value. Must belong to \code{\[min, max\]}.
#' @param step Increment step. 1 by default.
#' @param fill Whether to fill the stepper. FALSE by default.
#' @param rounded Whether to round the stepper. FALSE by default.
#' @param raised Whether to put a relied around the stepper. FALSE by default.
#' @param size Stepper size: "small", "large" or NULL.
#' @param color Stepper color: NULL or "red", "green", "blue", "pink", "yellow", "orange", "grey" and "black".
#' @param wraps In wraps mode incrementing beyond maximum value sets value to minimum value,
#' likewise, decrementing below minimum value sets value to maximum value. FALSE by default.
#' @param autorepeat Pressing and holding one of its buttons increments or decrements the stepper’s
#' value repeatedly. With dynamic autorepeat, the rate of change depends on how long the user
#' continues pressing the control. TRUE by default.
#' @param manual It is possible to enter value manually from keyboard or mobile keypad. When click on
#' input field, stepper enter into manual input mode, which allow type value from keyboar and check
#' fractional part with defined accurancy. Click outside or enter Return key, ending manual mode.
#' TRUE by default.
#' @param decimalPoint Number of digits after dot, when in manual input mode.
#' @param buttonsEndInputMode Disables manual input mode on Stepper's minus or plus button click.
#'
#'
#' @rdname stepper
#' @examples
#' # Stepper input
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'    ui = f7Page(
#'     title = "My app",
#'     f7SingleLayout(
#'      navbar = f7Navbar(title = "f7Stepper"),
#'      f7Stepper(
#'       inputId = "stepper",
#'       label = "My stepper",
#'       min = 0,
#'       max = 10,
#'       value = 4
#'      ),
#'      verbatimTextOutput("test"),
#'      f7Stepper(
#'       inputId = "stepper2",
#'       label = "My stepper 2",
#'       min = 0,
#'       max = 10,
#'       value = 4,
#'       color = "orange",
#'       raised = TRUE,
#'       fill = TRUE,
#'       rounded = TRUE
#'      ),
#'      verbatimTextOutput("test2")
#'     )
#'    ),
#'    server = function(input, output) {
#'     output$test <- renderPrint(input$stepper)
#'     output$test2 <- renderPrint(input$stepper2)
#'    }
#'  )
#' }
#
#' @export
f7Stepper <- function(inputId, label, min, max, value, step = 1,
                      fill = FALSE, rounded = FALSE, raised = FALSE, size = NULL,
                      color = NULL, wraps = FALSE, autorepeat = TRUE, manual = FALSE,
                      decimalPoint = 4, buttonsEndInputMode = TRUE) {

  stepperCl <- "stepper"
  if (fill) stepperCl <- paste0(stepperCl, " stepper-fill")
  if (rounded) stepperCl <- paste0(stepperCl, " stepper-round")
  if (!is.null(size)) {
    if (size == "small") {
      stepperCl <- paste0(stepperCl, " stepper-small")
    } else if (size == "large") {
      stepperCl <- paste0(stepperCl, " stepper-large")
    }
  }
  if (raised) stepperCl <- paste0(stepperCl, " stepper-raised")
  if (!is.null(color)) stepperCl <- paste0(stepperCl, " color-", color)

  # stepper props
  stepperProps <- dropNulls(
    list(
      class = stepperCl,
      id = inputId,
      # numeric
      `data-min` = min,
      `data-max` = max,
      `data-step` = step,
      `data-value` = value,
      `data-decimal-point` = decimalPoint,
      # booleans
      `data-wraps` = wraps,
      `data-autorepeat` = autorepeat,
      `data-autorepeat-dynamic` = autorepeat,
      `data-manual-input-mode` = manual,
      `data-buttons-end-input-mode` = buttonsEndInputMode
    )
  )

  # replace TRUE and FALSE by true and false for javascript
  stepperProps <- lapply(stepperProps, function(x) {
    if (identical(x, TRUE)) "true"
    else if (identical(x, FALSE)) "false"
    else x
  })

  # wrap props
  stepperProps <- do.call(shiny::tags$div, stepperProps)

  stepperTag <- shiny::tagAppendChildren(
    stepperProps,
    shiny::tags$div(class = "stepper-button-minus"),
    shiny::tags$div(
      class = "stepper-input-wrap",
      shiny::tags$input(
        type = "text",
        value = value,
        min = min,
        max = max,
        step = step
      )
    ),
    shiny::tags$div(class = "stepper-button-plus")
  )

  # main wrapper
  shiny::tagList(
    # stepper tag
    shiny::tags$small(label),
    stepperTag
  )
}





#' Update Framework7 stepper
#'
#' \code{updateF7Stepper} changes the value of a stepper input on the client.
#'
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
#' @param manual It is possible to enter value manually from keyboard or mobile keypad.
#'  When click on input field, stepper enter into manual input mode, which allow type value
#'  from keyboar and check fractional part with defined accurancy. Click outside or enter
#'  Return key, ending manual mode. TRUE by default.
#' @param session The Shiny session object, usually the default value will suffice.
#'
#' @export
#' @rdname stepper
#'
#' @note While updating, the autorepeat field does not work correctly.
#'
#' @examples
#' # Update stepper input
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
updateF7Stepper <- function(inputId, min = NULL, max = NULL,
                            value = NULL, step = NULL, fill = NULL,
                            rounded = NULL, raised = NULL, size = NULL,
                            color = NULL, wraps = NULL, decimalPoint = NULL,
                            autorepeat = NULL, manual = NULL,
                            session = shiny::getDefaultReactiveDomain()) {
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





#' Framework7 toggle input
#'
#' \code{f7Toggle} creates a F7 toggle switch input.
#'
#' @param inputId Toggle input id.
#' @param label Toggle label.
#' @param checked Whether to check the toggle. FALSE by default.
#' @param color Toggle color: NULL or "red", "green", "blue", "pink", "yellow", "orange", "grey" and "black".
#'
#' @rdname toggle
#' @examples
#' # f7Toggle
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'    ui = f7Page(
#'     title = "My app",
#'     f7SingleLayout(
#'      navbar = f7Navbar(title = "f7Toggle"),
#'      f7Toggle(
#'       inputId = "toggle",
#'       label = "My toggle",
#'       color = "pink",
#'       checked = TRUE
#'      ),
#'      verbatimTextOutput("test"),
#'      f7Toggle(
#'       inputId = "toggle2",
#'       label = "My toggle 2"
#'      ),
#'      verbatimTextOutput("test2")
#'     )
#'    ),
#'    server = function(input, output) {
#'     output$test <- renderPrint(input$toggle)
#'     output$test2 <- renderPrint(input$toggle2)
#'    }
#'  )
#' }
#
#' @export
f7Toggle <- function(inputId, label, checked = FALSE, color = NULL) {

  toggleCl <- "toggle"
  if (!is.null(color)) toggleCl <- paste0(toggleCl, " color-", color)

  shiny::tagList(
    # toggle tag
    shiny::tags$span(label),
    shiny::tags$label(
      class = toggleCl,
      id = inputId,
      shiny::tags$input(
        type = "checkbox",
        checked = if (checked) NA else NULL
      ),
      shiny::tags$span(class = "toggle-icon")
    )
  )
}





#' Update Framework7 toggle input
#'
#' \code{updateF7Toggle} changes the value of a toggle input on the client.
#'
#' @param inputId The id of the input object.
#' @param checked Whether the toggle is TRUE or FALSE.
#' @param color Toggle color.
#' @param session The Shiny session object.
#'
#' @export
#' @rdname toggle
#'
#' @examples
#' # Update f7Toggle
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
#'          inputId = "toggle",
#'          checked = TRUE,
#'          color = "green"
#'        )
#'      })
#'    }
#'  )
#' }
updateF7Toggle <- function(inputId, checked = NULL, color = NULL,
                           session = shiny::getDefaultReactiveDomain()) {
  message <- dropNulls(list(
    checked = checked,
    color = color
  ))
  session$sendInputMessage(inputId, message)
}




#' Framework7 radio input
#'
#' \code{f7Radio} creates a radio button input.
#'
#' @param inputId Radio input id.
#' @param label Radio label
#' @param choices List of choices.
#' @param selected Selected element. NULL by default.
#'
#' @export
#' @rdname radio
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'    ui = f7Page(
#'     title = "My app",
#'     f7SingleLayout(
#'      navbar = f7Navbar(title = "f7Radio"),
#'      f7Radio(
#'       inputId = "radio",
#'       label = "Choose a fruit:",
#'       choices = c("banana", "apple", "peach"),
#'       selected = "apple"
#'      ),
#'      plotOutput("plot")
#'     )
#'    ),
#'    server = function(input, output) {
#'     output$plot <- renderPlot({
#'      if (input$radio == "apple") hist(mtcars[, "mpg"])
#'     })
#'    }
#'  )
#' }
f7Radio <- function(inputId, label, choices = NULL, selected = NULL) {

  shiny::tagList(
    shiny::tags$div(
      class = "block-title",
      label
    ),
    shiny::tags$div(
      class = "list shiny-input-radiogroup",
      id = inputId,
      shiny::tags$ul(
        createRadioOptions(choices, selected, inputId)
      )
    )
  )

}





#' Update Framework7 radio buttons
#'
#' \code{updateF7Radio} updates a radio button input.
#'
#' @param inputId Radio input id.
#' @param label New radio label
#' @param choices New list of choices.
#' @param selected New selected element. NULL by default.
#' @param session Shiny session object.
#'
#' @rdname radio
#' @export
#'
#' @examples
#' # Update radio
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'   ui = f7Page(
#'     title = "Update radio",
#'     f7SingleLayout(
#'       navbar = f7Navbar(title = "Update f7Radio"),
#'       f7Button("go", "Update radio"),
#'       f7Radio(
#'         inputId = "radio",
#'         label = "Choose a fruit:",
#'         choices = c("banana", "apple", "peach"),
#'         selected = "apple"
#'       ),
#'       textOutput("radio_value")
#'     )
#'   ),
#'   server = function(input, output, session) {
#'     output$radio_value <- renderText(input$radio)
#'
#'     observeEvent(input$go, {
#'       updateF7Radio(
#'         session,
#'         inputId = "radio",
#'         label = "New label",
#'         choices = colnames(mtcars),
#'         selected = colnames(mtcars)[1]
#'       )
#'     })
#'   }
#'  )
#' }
updateF7Radio <- function (inputId, label = NULL, choices = NULL,
                           selected = NULL, session = shiny::getDefaultReactiveDomain()) {

  if (is.null(selected)) {
    if (!is.null(choices))
      selected <- choices[[1]]
  }

  message <- dropNulls(
    list(
      label = label,
      options = as.character(createRadioOptions(choices, selected, inputId)),
      value = selected
    )
  )

  session$sendInputMessage(inputId, message)
}


#' Generates a list of option for \link{f7Radio}
#'
#' @param choices List of choices.
#' @param selected Selected value
#' @param inputId Radio input id.
#'
#' @keywords internal
createRadioOptions <- function(choices, selected, inputId) {
  selectedPosition <- if (!is.null(selected)) match(selected, choices) else NULL

  choicesTag <- lapply(X = seq_along(choices), function(i) {
    shiny::tags$li(
      shiny::tags$label(
        class = "item-radio item-content",
        shiny::tags$input(
          type = "radio",
          name = inputId,
          value = choices[[i]]
        ),
        shiny::tags$i(class = "icon icon-radio"),
        shiny::tags$div(
          class = "item-inner",
          shiny::tags$div(class="item-title", choices[[i]])
        )
      )
    )
  })

  if (!is.null(selected)) choicesTag[[selectedPosition]]$children[[1]]$children[[1]]$attribs[["checked"]] <- NA

  shiny::tags$ul(choicesTag)
}
