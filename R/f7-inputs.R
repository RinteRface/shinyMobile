#' Create a Framework7 autocomplete input
#'
#' Build a Framework7 autocomplete input
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
#' @examples
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
  mainTag <- if (!(type %in% c("page", "popup"))) {
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

  # final input tag
  shiny::tagList(f7InputsDeps(), mainTag)

}




#' Create a Framework7 picker input
#'
#' Build a Framework7 picker input
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
#' @examples
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
  mainTag <- shiny::tagList(
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

  # final input tag
  shiny::tagList(f7InputsDeps(), mainTag)

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
    f7InputsDeps(),
    shiny::singleton(pickerProps),
    labelTag,
    wrapperTag
  )

}





#' Create a Framework7 date input
#'
#' @param inputId Date input id.
#' @param label Input label.
#' @param value Start value.
#' @param min Minimum date.
#' @param max Maximum date.
#' @param format Date format: "yyyy-mm-dd", for instance.
#'
#' @export
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shinyApp(
#'    ui = f7Page(
#'      preloader = FALSE,
#'      color = "pink",
#'      title = "My app",
#'      f7SingleLayout(
#'        navbar = f7Navbar(title = "f7DatePicker"),
#'        f7DatePicker(
#'          inputId = "date",
#'          label = "Choose a date",
#'          value = "2019-08-24"
#'        ),
#'        "The selected date is",
#'        textOutput("selectDate")
#'      )
#'    ),
#'    server = function(input, output, session) {
#'      output$selectDate <- renderText(input$date)
#'    }
#'  )
#' }
f7DatePicker <- function(inputId, label, value = NULL,
                         min = NULL, max = NULL,
                         format = "yyyy-mm-dd") {

  # label
  labelTag <- shiny::tags$div(
    class = "block-title",
    label
  )

  inputTag <- shiny::tags$input(
    type = "text",
    placeholder = value,
    class = "calendar-input",
    id = inputId
  )

  wrapperTag <- shiny::tagList(
    f7InputsDeps(),
    labelTag,
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
                inputTag
              )
            )
          )
        )
      )
    )
  )
  wrapperTag
}



#' Create a F7 Checkbox
#'
#' @param inputId The input slot that will be used to access the value.
#' @param label Display label for the control, or NULL for no label.
#' @param value Initial value (TRUE or FALSE).
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'     title = "My app",
#'     f7SingleLayout(
#'      navbar = f7Navbar(title = "f7checkBox"),
#'      f7Card(
#'       f7checkBox(
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
f7checkBox <- function(inputId, label, value = FALSE){
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



#' Create an f7 checkbox group input
#'
#' @param inputId Checkbox group input.
#' @param label Checkbox group label.
#' @param choices Checkbox group choices.
#' @param selected Checkbox group selected value.
#'
#' @export
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
#'       navbar = f7Navbar(title = "f7checkBoxGroup"),
#'       f7checkBoxGroup(
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
f7checkBoxGroup <- function(inputId, label, choices = NULL, selected = NULL) {

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

  shiny::tags$div(
    class = "list shiny-input-checkboxgroup",
    id = inputId,
    shiny::tags$ul(
      choicesTag
    )
  )
}






#' Create option html tag based on choice input
#'
#' Used by \link{f7SmartSelect} and \link{f7Select}
#'
#' @param choices Vector of possibilities.
#' @param selected Default selected value.
#'
createSelectOptions <- function(choices, selected) {
  options <- lapply(X = seq_along(choices), function(i) {
    shiny::tags$option(
      value = choices[[i]],
      choices[[i]],
      selected = if (!is.null(selected)) {
        if (choices[[i]] %in% selected) NA else NULL
      }
    )
  })

  return(options)
}



#' Create an f7 select input
#'
#' @param inputId Select input id.
#' @param label Select input label.
#' @param choices Select input choices.
#' @param selected Select input default selected value.
#'
#' @export
#'
#' @examples
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
f7Select <- function(inputId, label, choices, selected = NULL) {


  options <- createSelectOptions(choices, selected)

  selectTag <- shiny::tags$div(
    class = "list",
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

  shiny::tagList(f7InputsDeps(), selectTag)

}



#' Create a Framework7 smart select
#'
#' It is nicer than the classic \link{f7Select}
#' and allows for search.
#'
#' @param inputId Select input id.
#' @param label Select input label.
#' @param choices Select input choices.
#' @param selected Default selected item.
#' @param type Smart select type: either \code{c("sheet", "popup", "popover")}.
#' Note that the search bar is only available when the type is popup.
#' @param smart Whether to enable the search bar. TRUE by default.
#' @param multiple Whether to allow multiple values. FALSE by default.
#'
#' @export
#'
#' @examples
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
#'          type = "popup"
#'        ),
#'        tableOutput("data")
#'      )
#'    ),
#'    server = function(input, output) {
#'      output$data <- renderTable({
#'        mtcars[, c("mpg", input$variable), drop = FALSE]
#'      }, rownames = TRUE)
#'    }
#'  )
#' }
f7SmartSelect <- function(inputId, label, choices, selected = NULL,
                          type = c("sheet", "popup", "popover"),
                          smart = TRUE, multiple = FALSE) {

  options <- createSelectOptions(choices, selected)

  type <- match.arg(type)

  shiny::tags$div(
    class = "list",
    shiny::tags$ul(
      shiny::tags$li(
        shiny::tags$a(
          class = "item-link smart-select smart-select-init",
          `data-open-in` = type,
          `data-searchbar` = if (smart & type == "popup") "true" else NULL,
          `data-searchbar-placeholder` = if (smart & type == "popup") "Search" else NULL,
          shiny::tags$select(
            id = inputId,
            multiple = if (multiple) NA else NULL,
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
          )
        )
      )
    )
  )
}


#' Create an f7 text input
#'
#' @param inputId Text input id.
#' @param label Text input label.
#' @param value Text input value.
#' @param placeholder Text input placeholder.
#'
#' @export
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shiny::shinyApp(
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
f7Text <- function(inputId, label, value = "", placeholder = NULL) {

  shiny::tags$div(
    class = "list",
    id = inputId,
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
              type = "text",
              placeholder = placeholder,
              class = ""
            ),
            shiny::span(class="input-clear-button")
          )
        )
      )
    )
  )
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
#   dateTag <- shiny::tags$div(
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
#
#   shiny::tagList(f7InputsDeps(), dateTag)
#
# }




# #' Create an f7 text area input
# #'
# #' @inheritParams f7Text
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
# #'      f7TextArea(
# #'       inputId = "textarea",
# #'       label = "Text Area",
# #'       value = "Lorem ipsum dolor sit amet, consectetur
# #'        adipiscing elit, sed do eiusmod tempor incididunt ut
# #'        labore et dolore magna aliqua",
# #'       placeholder = "Your text here"
# #'      ),
# #'      verbatimTextOutput("value")
# #'    ),
# #'    server = function(input, output) {
# #'      output$value <- renderPrint({ input$textarea })
# #'    }
# #'  )
# #' }
# f7TextArea <- function(inputId, label, value = "", placeholder = NULL) {
#   shiny::tags$div(
#     class = "list",
#     id = inputId,
#     shiny::tags$ul(
#       shiny::tags$li(
#         class = "item-content item-input",
#         shiny::tags$div(
#           class = "item-inner",
#           shiny::tags$div(class = "item-title item-label", label),
#           shiny::tags$div(
#             class = "item-input-wrap",
#             shiny::tags$textarea(
#               id = inputId,
#               value,
#               placeholder = placeholder,
#               class = NA,
#               rows = 4,
#               cols = 4
#             )
#           )
#         )
#       )
#     )
#   )
# }






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
#'  shiny::shinyApp(
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
    id = inputId,
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
            shiny::span(class="input-clear-button")
          )
        )
      )
    )
  )
}



#' Create a f7 slider
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
#' @param noSwipping Prevent swiping when slider is manipulated in a \code{\link{f7TabLayout}}.
#'
#' @note labels option only works when vertical is FALSE!
#'
#' @export
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shiny::shinyApp(
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
#'  shiny::shinyApp(
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
      isF7Icon <- (grep(x = labels[[i]]$attribs$class, pattern = "f7-icons") == 1)
      if (class(labels[[i]]) != "shiny.tag" | !isF7Icon) {
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
    f7InputsDeps(),
    # HTML skeleton
    shiny::br(),
    shiny::tags$div(class = "block-title", label),
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


#' Create a F7 radio stepper
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
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shiny::shinyApp(
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
    f7InputsDeps(),
    # stepper tag
    shiny::tags$small(label),
    stepperTag
  )
}







#' Create a F7 toggle switch
#'
#' @param inputId Toggle input id.
#' @param label Toggle label.
#' @param checked Whether to check the toggle. FALSE by default.
#' @param color Toggle color: NULL or "red", "green", "blue", "pink", "yellow", "orange", "grey" and "black".
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shiny::shinyApp(
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

    # input binding
    f7InputsDeps(),
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





#' Create an f7 radio button input
#'
#' @param inputId Radio input id.
#' @param label Radio label
#' @param choices List of choices.
#' @param selected Selected element. NULL by default.
#'
#' @export
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shiny::shinyApp(
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

  shiny::tags$div(
    class = "list shiny-input-radiogroup",
    id = inputId,
    shiny::tags$ul(
      choicesTag
    )
  )
}
