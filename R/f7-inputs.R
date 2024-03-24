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
#' @param expandInput `r lifecycle::badge("deprecated")`:
#' removed from Framework7.
#' @param closeOnSelect Set to true and autocomplete will be closed when user picks value.
#' Not available if multiple is enabled. Only works
#' when openIn is 'popup' or 'page'.
#' @param dropdownPlaceholderText Specify dropdown placeholder text.
#' Only if openIn is "dropdown".
#' @param multiple Whether to allow multiple value selection. Only works
#' when openIn is 'popup' or 'page'.
#' @param limit Limit number of maximum displayed items in autocomplete per query.
#'
#' @rdname autocomplete
#'
#' @example inst/examples/autocomplete/app.R
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7AutoComplete <- function(inputId, label, placeholder = NULL,
                           value = choices[1], choices,
                           openIn = c("popup", "page", "dropdown"),
                           typeahead = TRUE, expandInput = deprecated(), closeOnSelect = FALSE,
                           dropdownPlaceholderText = NULL, multiple = FALSE, limit = NULL) {
  if (lifecycle::is_present(expandInput)) {
    lifecycle::deprecate_warn(
      when = "1.1.0",
      what = "f7AutoComplete(expandInput)",
      details = "expandInput has been
      removed from Framework7 and will be removed from shinyMobile
      in the next release."
    )
  }
  type <- match.arg(openIn)

  if (is.null(value)) value <- character()

  value <- jsonlite::toJSON(value)
  choices <- jsonlite::toJSON(choices)

  # autocomplete common props
  autoCompleteCommon <- list(
    id = inputId,
    class = "autocomplete-input",
    `data-choices` = choices,
    `data-value` = value,
    `data-open-in` = type,
    `data-limit` = limit
  )

  # specific props
  autoCompleteProps <- if (!(type %in% c("page", "popup"))) {
    list(
      type = "text",
      placeholder = placeholder,
      `data-typeahead` = typeahead,
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
    if (identical(x, TRUE)) {
      "true"
    } else if (identical(x, FALSE)) {
      "false"
    } else {
      x
    }
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
      class = "list list-strong-ios list-outline-ios",
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
    shiny::tags$div(class = "list list-strong list-outline-ios", shiny::tags$ul(autoCompleteProps))
  }
}

#' Update Framework7 autocomplete
#'
#' \code{updateF7AutoComplete} changes the value of an autocomplete input on the client.
#'
#' @param session The Shiny session object.
#'
#' @export
#' @rdname autocomplete
updateF7AutoComplete <- function(inputId, value = NULL, choices = NULL,
                                 session = shiny::getDefaultReactiveDomain()) {
  message <- dropNulls(
    list(
      value = I(value),
      choices = choices
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
#' @param options Other options to pass to the picker. See
#' \url{https://framework7.io/docs/picker#picker-parameters}.
#'
#' @rdname picker
#' @examples
#' # Picker input
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   shinyApp(
#'     ui = f7Page(
#'       title = "My app",
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "f7Picker"),
#'         f7Picker(
#'           inputId = "mypicker",
#'           placeholder = "Some text here!",
#'           label = "Picker Input",
#'           choices = c("a", "b", "c")
#'         ),
#'         textOutput("pickerval")
#'       )
#'     ),
#'     server = function(input, output) {
#'       output$pickerval <- renderText(input$mypicker)
#'     }
#'   )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Picker <- function(inputId, label, placeholder = NULL, value = choices[1], choices,
                     rotateEffect = TRUE, openIn = "auto", scrollToInput = FALSE,
                     closeByOutsideClick = TRUE, toolbar = TRUE, toolbarCloseText = "Done",
                     sheetSwipeToClose = FALSE, options = list()) {
  # for JS
  if (is.null(value)) stop("value cannot be NULL.")

  # TO DO: create helper function for sheet, picker, ...
  # since they're all the same ...
  pickerProps <- dropNulls(
    c(
      list(
        value = value,
        values = choices,
        displayValues = if (length(names(choices))) names(choices),
        rotateEffect = rotateEffect,
        openIn = openIn,
        scrollToInput = scrollToInput,
        closeByOutsideClick = closeByOutsideClick,
        toolbar = toolbar,
        toolbarCloseText = toolbarCloseText,
        sheetSwipeToClose = sheetSwipeToClose
      ),
      options
    )
  )

  pickerConfig <- shiny::tags$script(
    type = "application/json",
    `data-for` = inputId,
    jsonlite::toJSON(
      x = pickerProps,
      auto_unbox = TRUE,
      json_verbatim = TRUE
    )
  )

  # input tag
  inputTag <- shiny::tags$li(
    shiny::tags$div(
      class = "item-content item-input",
      shiny::tags$div(
        class = "item-inner",
        shiny::tags$div(
          class = "item-input-wrap",
          shiny::tags$input(
            id = inputId,
            class = "picker-input",
            type = "text",
            placeholder = placeholder
          ),
          pickerConfig
        )
      )
    )
  )

  # tag wrapper
  shiny::tagList(
    shiny::tags$div(
      class = "block-title",
      label
    ),
    f7List(inputTag)
  )
}

#' Update Framework7 picker
#'
#' \code{updateF7Picker} changes the value of a picker input on the client.
#'
#' @param ... Other options to pass to picker. See
#' \url{https://framework7.io/docs/picker#picker-parameters}.
#' @param session The Shiny session object, usually the default value will suffice.
#'
#' @export
#' @rdname picker
#'
#' @examples
#' # Update picker input
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'   shinyApp(
#'     ui = f7Page(
#'       title = "My app",
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "Update picker"),
#'         f7Card(
#'           f7Button(inputId = "update", label = "Update picker"),
#'           f7Picker(
#'             inputId = "mypicker",
#'             placeholder = "Some text here!",
#'             label = "Picker Input",
#'             choices = c("a", "b", "c")
#'           ),
#'           verbatimTextOutput("pickerval"),
#'           br(),
#'           f7Button(inputId = "removeToolbar", label = "Remove picker toolbar", color = "red")
#'         )
#'       )
#'     ),
#'     server = function(input, output, session) {
#'       output$pickerval <- renderText(input$mypicker)
#'
#'       observeEvent(input$update, {
#'         updateF7Picker(
#'           inputId = "mypicker",
#'           value = "b",
#'           choices = letters,
#'           openIn = "sheet",
#'           toolbarCloseText = "Prout",
#'           sheetSwipeToClose = TRUE
#'         )
#'       })
#'
#'       observeEvent(input$removeToolbar, {
#'         updateF7Picker(
#'           inputId = "mypicker",
#'           value = "b",
#'           choices = letters,
#'           openIn = "sheet",
#'           toolbar = FALSE
#'         )
#'       })
#'     }
#'   )
#' }
updateF7Picker <- function(inputId, value = NULL, choices = NULL,
                           rotateEffect = NULL, openIn = NULL, scrollToInput = NULL,
                           closeByOutsideClick = NULL, toolbar = NULL, toolbarCloseText = NULL,
                           sheetSwipeToClose = NULL, ...,
                           session = shiny::getDefaultReactiveDomain()) {
  message <- dropNulls(
    list(
      value = value,
      choices = choices,
      rotateEffect = rotateEffect,
      openIn = openIn,
      scrollToInput = scrollToInput,
      closeByOutsideClick = closeByOutsideClick,
      toolbar = toolbar,
      toolbarCloseText = toolbarCloseText,
      sheetSwipeToClose = sheetSwipeToClose,
      ...
    )
  )
  session$sendInputMessage(inputId, message)
}




f7ColorPickerPalettes <- list(
  c(
    "#FFEBEE", "#FFCDD2", "#EF9A9A",
    "#E57373", "#EF5350", "#F44336",
    "#E53935", "#D32F2F", "#C62828",
    "#B71C1C"
  ),
  c(
    "#F3E5F5", "#E1BEE7", "#CE93D8",
    "#BA68C8", "#AB47BC", "#9C27B0",
    "#8E24AA", "#7B1FA2", "#6A1B9A",
    "#4A148C"
  ),
  c(
    "#E8EAF6", "#C5CAE9", "#9FA8DA",
    "#7986CB", "#5C6BC0", "#3F51B5",
    "#3949AB", "#303F9F", "#283593",
    "#1A237E"
  ),
  c(
    "#E1F5FE", "#B3E5FC", "#81D4FA",
    "#4FC3F7", "#29B6F6", "#03A9F4",
    "#039BE5", "#0288D1", "#0277BD",
    "#01579B"
  ),
  c(
    "#E0F2F1", "#B2DFDB", "#80CBC4",
    "#4DB6AC", "#26A69A", "#009688",
    "#00897B", "#00796B", "#00695C",
    "#004D40"
  ),
  c(
    "#F1F8E9", "#DCEDC8", "#C5E1A5",
    "#AED581", "#9CCC65", "#8BC34A",
    "#7CB342", "#689F38", "#558B2F",
    "#33691E"
  ),
  c(
    "#FFFDE7", "#FFF9C4", "#FFF59D",
    "#FFF176", "#FFEE58", "#FFEB3B",
    "#FDD835", "#FBC02D", "#F9A825",
    "#F57F17"
  ),
  c(
    "#FFF3E0", "#FFE0B2", "#FFCC80",
    "#FFB74D", "#FFA726", "#FF9800",
    "#FB8C00", "#F57C00", "#EF6C00",
    "#E65100"
  )
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
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   shinyApp(
#'     ui = f7Page(
#'       title = "My app",
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "f7ColorPicker"),
#'         f7ColorPicker(
#'           inputId = "mycolorpicker",
#'           placeholder = "Some text here!",
#'           label = "Select a color"
#'         ),
#'         "The picker value is:",
#'         textOutput("colorPickerVal")
#'       )
#'     ),
#'     server = function(input, output) {
#'       output$colorPickerVal <- renderText(input$mycolorpicker)
#'     }
#'   )
#' }
f7ColorPicker <- function(inputId, label, value = "#ff0000", placeholder = NULL,
                          modules = f7ColorPickerModules, palettes = f7ColorPickerPalettes,
                          sliderValue = TRUE, sliderValueEditable = TRUE,
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
      "var colorPickerModules = ", modules, ";
       var colorPickerPalettes = ", palettes, ';
       var colorPickerValue = "', value, '";
       var colorPickerSliderValue = ', tolower(sliderValue), ";
       var colorPickerSliderValueEditable = ", tolower(sliderValueEditable), ";
       var colorPickerSliderLabel = ", tolower(sliderLabel), ";
       var colorPickerHexLabel = ", tolower(hexLabel), ";
       var colorPickerHexValueEditable = ", tolower(hexValueEditable), ";
       var colorPickerGroupedModules = ", tolower(groupedModules), ";
      "
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
#'       output$selectDate <- renderPrint(input$date)
#'       output$selectMultipleDates <- renderPrint(input$multipleDates)
#'       output$selectDefault <- renderPrint(input$default)
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
  if (length(config) == 0) {
    config <- NULL
  }
  message <- dropNulls(list(
    value = value,
    config = config
  ))
  session$sendInputMessage(inputId, message)
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
#' @example inst/examples/checkbox/app.R
#' @export
f7Checkbox <- function(inputId, label, value = FALSE) {
  value <- shiny::restoreInput(id = inputId, default = value)
  inputTag <- shiny::tags$input(id = inputId, type = "checkbox")
  if (!is.null(value) && value) {
    inputTag$attribs$checked <- "checked"
  }
  shiny::tagList(
    shiny::tags$span(label),
    shiny::tags$label(
      class = "checkbox",
      inputTag,
      shiny::tags$i(class = "icon-checkbox"),
    )
  )
}

#' Update Framework7 checkbox
#'
#' \code{updateF7Checkbox} changes the value of a checkbox input on the client.
#'
#' @rdname checkbox
#' @param session The Shiny session object.
#' @export
updateF7Checkbox <- function(inputId, label = NULL, value = NULL,
                             session = shiny::getDefaultReactiveDomain()) {
  message <- dropNulls(list(label = label, value = value))
  session$sendInputMessage(inputId, message)
}

#' Framework7 checkbox group
#'
#' \code{f7CheckboxGroup} creates a checkbox group input
#'
#' @inheritParams f7GroupInput
#'
#' @export
#' @rdname checkboxgroup
#'
#' @example inst/examples/checkboxgroup/app.R
f7CheckboxGroup <- function(
    inputId, label, choices = NULL, selected = NULL,
    position = c("left", "right"), inset = FALSE,
    outline = FALSE, dividers = FALSE, strong = FALSE) {
  position <- match.arg(position)
  f7GroupInput(
    type = "checkbox",
    inputId = inputId,
    label = label,
    choices = choices,
    selected = selected,
    position = position,
    inset = inset,
    outline = outline,
    dividers = dividers,
    strong = strong
  )
}

#' Framework7 checkbox group custom choice
#'
#' Custom choice item for \link{f7CheckboxGroup}.
#'
#' @param ... Choice content. Text is striped if too long.
#' @param title Item title.
#' @param subtitle Item subtitle.
#' @param after Display at the right of title.
#'
#' @export
#' @rdname checkboxgroup
f7CheckboxChoice <- function(..., title, subtitle = NULL, after = NULL) {
  # We can benefit from f7ListItem, though we don't
  # need all of the generated tag, hence the use of
  # htmltools::tagQuery ...
  structure(
    htmltools::tagQuery(
      f7ListItem(
        ...,
        title = title,
        subtitle = subtitle,
        right = after
      )
    )$
      find(".item-inner")$
      selectedTags()[[1]]$
      children,
    class = "custom_choice"
  )
}

#' Create option html tag based on choice input
#'
#' Used by \link{f7SmartSelect} and \link{f7Select}
#'
#' @param choices Vector of possibilities.
#' @param selected Default selected value.
#' @keywords internal
createSelectOptions <- function(choices, selected) {
  choices <- choicesWithNames(choices)
  lapply(X = seq_along(choices), function(i) {
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
}

choicesWithNames <- function(choices) {
  listify <- function(obj) {
    makeNamed <- function(x) {
      if (is.null(names(x))) {
        names(x) <- character(length(x))
      }
      x
    }
    res <- lapply(obj, function(val) {
      if (is.list(val)) {
        listify(val)
      } else if (length(val) == 1 && is.null(names(val))) {
        val
      } else {
        makeNamed(as.list(val))
      }
    })
    makeNamed(res)
  }
  choices <- listify(choices)
  if (length(choices) == 0) {
    return(choices)
  }
  choices <- mapply(choices, names(choices), FUN = function(choice,
                                                            name) {
    if (!is.list(choice)) {
      return(choice)
    }
    if (name == "") {
      stop("All sub-lists in \"choices\" must be named.")
    }
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
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   shiny::shinyApp(
#'     ui = f7Page(
#'       title = "My app",
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "f7Select"),
#'         f7Select(
#'           inputId = "variable",
#'           label = "Choose a variable:",
#'           choices = colnames(mtcars)[-1],
#'           selected = "hp"
#'         ),
#'         tableOutput("data")
#'       )
#'     ),
#'     server = function(input, output) {
#'       output$data <- renderTable(
#'         {
#'           mtcars[, c("mpg", input$variable), drop = FALSE]
#'         },
#'         rownames = TRUE
#'       )
#'     }
#'   )
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
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   shinyApp(
#'     ui = f7Page(
#'       title = "My app",
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "updateF7Select"),
#'         f7Card(
#'           f7Button(inputId = "update", label = "Update select"),
#'           br(),
#'           f7Select(
#'             inputId = "variable",
#'             label = "Choose a variable:",
#'             choices = colnames(mtcars)[-1],
#'             selected = "hp"
#'           ),
#'           verbatimTextOutput("test")
#'         )
#'       )
#'     ),
#'     server = function(input, output, session) {
#'       output$test <- renderPrint(input$variable)
#'
#'       observeEvent(input$update, {
#'         updateF7Select(
#'           inputId = "variable",
#'           selected = "gear"
#'         )
#'       })
#'     }
#'   )
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
#' @param ... Other options. See \url{https://framework7.io/docs/smart-select#smart-select-parameters}.
#'
#' @rdname smartselect
#'
#' @export
#'
#' @examples
#' # Smart select input
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   shinyApp(
#'     ui = f7Page(
#'       title = "My app",
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "f7SmartSelect"),
#'         f7SmartSelect(
#'           inputId = "variable",
#'           label = "Choose a variable:",
#'           selected = "drat",
#'           choices = colnames(mtcars)[-1],
#'           openIn = "popup"
#'         ),
#'         tableOutput("data"),
#'         f7SmartSelect(
#'           inputId = "variable2",
#'           label = "Group variables:",
#'           choices = list(
#'             `East Coast` = list("NY", "NJ", "CT"),
#'             `West Coast` = list("WA", "OR", "CA"),
#'             `Midwest` = list("MN", "WI", "IA")
#'           ),
#'           openIn = "sheet"
#'         ),
#'         textOutput("var")
#'       )
#'     ),
#'     server = function(input, output) {
#'       output$var <- renderText(input$variable2)
#'       output$data <- renderTable(
#'         {
#'           mtcars[, c("mpg", input$variable), drop = FALSE]
#'         },
#'         rownames = TRUE
#'       )
#'     }
#'   )
#' }
f7SmartSelect <- function(inputId, label, choices, selected = NULL,
                          openIn = c("page", "sheet", "popup", "popover"),
                          searchbar = TRUE, multiple = FALSE, maxlength = NULL,
                          virtualList = FALSE, ...) {
  options <- createSelectOptions(choices, selected)
  type <- match.arg(openIn)

  config <- dropNulls(list(
    openIn = type,
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
#' @param session The Shiny session object, usually the default value will suffice.
#'
#' @rdname smartselect
#' @export
#'
#' @examples
#' # Update smart select
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   shinyApp(
#'     ui = f7Page(
#'       title = "My app",
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "Update f7SmartSelect"),
#'         f7Button("updateSmartSelect", "Update Smart Select"),
#'         f7SmartSelect(
#'           inputId = "variable",
#'           label = "Choose a variable:",
#'           selected = "drat",
#'           choices = colnames(mtcars)[-1],
#'           openIn = "popup"
#'         ),
#'         tableOutput("data")
#'       )
#'     ),
#'     server = function(input, output, session) {
#'       output$data <- renderTable(
#'         {
#'           mtcars[, c("mpg", input$variable), drop = FALSE]
#'         },
#'         rownames = TRUE
#'       )
#'
#'       observeEvent(input$updateSmartSelect, {
#'         updateF7SmartSelect(
#'           inputId = "variable",
#'           openIn = "sheet",
#'           selected = "hp",
#'           choices = c("hp", "gear"),
#'           multiple = TRUE,
#'           maxLength = 3
#'         )
#'       })
#'     }
#'   )
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
  if (length(config) == 0) {
    config <- NULL
  }
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
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   shinyApp(
#'     ui = f7Page(
#'       title = "My app",
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "f7Text"),
#'         f7Text(
#'           inputId = "caption",
#'           label = "Caption",
#'           value = "Data Summary",
#'           placeholder = "Your text here"
#'         ),
#'         verbatimTextOutput("value")
#'       )
#'     ),
#'     server = function(input, output) {
#'       output$value <- renderPrint({
#'         input$caption
#'       })
#'     }
#'   )
#' }
f7Text <- function(inputId, label, value = "", placeholder = NULL # ,
                   # style = NULL, inset = FALSE, icon = NULL
) {
  # possible styles c("inline", "floating", "outline")

  wrapperCl <- "list"
  # if (inset) wrapperCl <- paste0(wrapperCl, " inset")

  itemCl <- "item-content item-input"
  itemLabelCl <- "item-title"

  # if (!is.null(style)) {
  #  if (style == "inline") wrapperCl <- paste0(wrapperCl, " inline-labels")
  #  if (style == "outline") itemCl <- paste0(itemCl, " item-input-outline")
  #  if (style == "floating") itemLabelCl <- paste0(itemLabelCl, " item-floating-label")
  # }

  inputTag <- shiny::tags$input(
    id = inputId,
    value = value,
    type = "text",
    placeholder = placeholder
  )


  shiny::tags$div(
    class = wrapperCl,
    # id = inputId,
    shiny::tags$ul(
      shiny::tags$li(
        class = itemCl,
        # if (!is.null(icon)) shiny::tags$div(class = "item-media", icon),
        shiny::tags$div(
          class = "item-inner",
          shiny::tags$div(class = itemLabelCl, label),
          shiny::tags$div(
            class = "item-input-wrap",
            inputTag,
            shiny::span(class = "input-clear-button")
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
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   ui <- f7Page(
#'     f7SingleLayout(
#'       navbar = f7Navbar(title = "updateF7Text"),
#'       f7Block(f7Button("trigger", "Click me")),
#'       f7Text(
#'         inputId = "text",
#'         label = "Caption",
#'         value = "Some text",
#'         placeholder = "Your text here"
#'       ),
#'       verbatimTextOutput("value")
#'     )
#'   )
#'
#'   server <- function(input, output, session) {
#'     output$value <- renderPrint(input$text)
#'     observeEvent(input$trigger, {
#'       updateF7Text("text", value = "Updated Text")
#'     })
#'   }
#'   shinyApp(ui, server)
#' }
updateF7Text <- function(inputId, label = NULL, value = NULL, placeholder = NULL, session = shiny::getDefaultReactiveDomain()) {
  message <- dropNulls(list(label = label, value = value, placeholder = placeholder))
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
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   shinyApp(
#'     ui = f7Page(
#'       title = "My app",
#'       f7TextArea(
#'         inputId = "textarea",
#'         label = "Text Area",
#'         value = "Lorem ipsum dolor sit amet, consectetur
#'        adipiscing elit, sed do eiusmod tempor incididunt ut
#'        labore et dolore magna aliqua",
#'         placeholder = "Your text here",
#'         resize = TRUE
#'       ),
#'       textOutput("value")
#'     ),
#'     server = function(input, output) {
#'       output$value <- renderText({
#'         input$textarea
#'       })
#'     }
#'   )
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
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   ui <- f7Page(
#'     f7SingleLayout(
#'       navbar = f7Navbar(title = "updateF7TextArea"),
#'       f7Block(f7Button("trigger", "Click me")),
#'       f7TextArea(
#'         inputId = "textarea",
#'         label = "Text Area",
#'         value = "Lorem ipsum dolor sit amet, consectetur
#'               adipiscing elit, sed do eiusmod tempor incididunt ut
#'               labore et dolore magna aliqua",
#'         placeholder = "Your text here",
#'         resize = TRUE
#'       ),
#'       verbatimTextOutput("value")
#'     )
#'   )
#'
#'   server <- function(input, output, session) {
#'     output$value <- renderPrint(input$textarea)
#'     observeEvent(input$trigger, {
#'       updateF7Text("textarea", value = "Updated Text")
#'     })
#'   }
#'   shinyApp(ui, server)
#' }
updateF7TextArea <- updateF7Text



#' Create an f7 password input
#'
#' @inheritParams f7Text
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
#'         navbar = f7Navbar(title = "f7Password"),
#'         f7Password(
#'           inputId = "password",
#'           label = "Password:",
#'           placeholder = "Your password here"
#'         ),
#'         verbatimTextOutput("value")
#'       )
#'     ),
#'     server = function(input, output) {
#'       output$value <- renderPrint({
#'         input$password
#'       })
#'     }
#'   )
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
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   shinyApp(
#'     ui = f7Page(
#'       title = "My app",
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "f7Slider"),
#'         f7Card(
#'           f7Slider(
#'             inputId = "obs",
#'             label = "Number of observations",
#'             max = 1000,
#'             min = 0,
#'             value = 100,
#'             scaleSteps = 5,
#'             scaleSubSteps = 3,
#'             scale = TRUE,
#'             color = "orange",
#'             labels = tagList(
#'               f7Icon("circle"),
#'               f7Icon("circle_fill")
#'             )
#'           ),
#'           verbatimTextOutput("test")
#'         ),
#'         plotOutput("distPlot")
#'       )
#'     ),
#'     server = function(input, output) {
#'       output$test <- renderPrint({
#'         input$obs
#'       })
#'       output$distPlot <- renderPlot({
#'         hist(rnorm(input$obs))
#'       })
#'     }
#'   )
#' }
#'
#' # Create a range
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   shinyApp(
#'     ui = f7Page(
#'       title = "My app",
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "f7Slider Range"),
#'         f7Card(
#'           f7Slider(
#'             inputId = "obs",
#'             label = "Range values",
#'             max = 500,
#'             min = 0,
#'             value = c(50, 100),
#'             scale = FALSE
#'           ),
#'           verbatimTextOutput("test")
#'         )
#'       )
#'     ),
#'     server = function(input, output) {
#'       output$test <- renderPrint({
#'         input$obs
#'       })
#'     }
#'   )
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
      `data-min` = min,
      `data-max` = max,
      `data-vertical` = tolower(vertical),
      `data-vertical-reversed` = if (vertical) tolower(verticalReversed) else NULL,
      `data-label` = "true",
      `data-step` = step,
      `data-value` = if (length(value) == 1) value else NULL,
      `data-value-left` = if (length(value) == 2) value[1] else NULL,
      `data-value-right` = if (length(value) == 2) value[2] else NULL,
      `data-scale` = tolower(scale),
      `data-scale-steps` = scaleSteps,
      `data-scale-sub-steps` = scaleSubSteps
    )
  )

  # wrap props
  rangeTag <- do.call(shiny::tags$div, sliderProps)


  labels <- if (!is.null(labels)) {
    lapply(seq_along(labels), function(i) {
      isF7Icon <- grepl(x = labels[[i]]$attribs$class, pattern = "f7-icons")
      if (!inherits(labels[[i]], "shiny.tag") || !isF7Icon) {
        stop("Label must be a f7Icon.")
      }
      shiny::tags$div(
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
        class = "list simple-list list-strong-ios list-outline-ios",
        shiny::tags$ul(
          shiny::tags$li(
            labels[[1]],
            shiny::tags$div(
              style = "width: 100%; margin: 0 16px",
              rangeTag
            ),
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
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   shinyApp(
#'     ui = f7Page(
#'       title = "My app",
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "updateF7Slider"),
#'         f7Card(
#'           f7Button(inputId = "update", label = "Update slider"),
#'           f7Slider(
#'             inputId = "obs",
#'             label = "Range values",
#'             max = 500,
#'             min = 0,
#'             step = 1,
#'             color = "deeppurple",
#'             value = c(50, 100)
#'           ),
#'           verbatimTextOutput("test")
#'         )
#'       )
#'     ),
#'     server = function(input, output, session) {
#'       output$test <- renderPrint({
#'         input$obs
#'       })
#'
#'       observeEvent(input$update, {
#'         updateF7Slider(
#'           inputId = "obs",
#'           value = c(1, 5),
#'           min = 0,
#'           scaleSteps = 10,
#'           scaleSubSteps = 5,
#'           step = 0.1,
#'           max = 10,
#'           color = "teal"
#'         )
#'       })
#'     }
#'   )
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
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   shinyApp(
#'     ui = f7Page(
#'       title = "My app",
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "f7Stepper"),
#'         f7Stepper(
#'           inputId = "stepper",
#'           label = "My stepper",
#'           min = 0,
#'           max = 10,
#'           value = 4
#'         ),
#'         verbatimTextOutput("test"),
#'         f7Stepper(
#'           inputId = "stepper2",
#'           label = "My stepper 2",
#'           min = 0,
#'           max = 10,
#'           value = 4,
#'           color = "orange",
#'           raised = TRUE,
#'           fill = TRUE,
#'           rounded = TRUE
#'         ),
#'         verbatimTextOutput("test2")
#'       )
#'     ),
#'     server = function(input, output) {
#'       output$test <- renderPrint(input$stepper)
#'       output$test2 <- renderPrint(input$stepper2)
#'     }
#'   )
#' }
#' #
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
    if (identical(x, TRUE)) {
      "true"
    } else if (identical(x, FALSE)) {
      "false"
    } else {
      x
    }
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
    shiny::tags$div(
      style = "display: flex; align-items: center;",
      # stepper tag
      shiny::tags$small(label,
        style = "padding: 5px"
      ),
      stepperTag
    ),
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
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   shinyApp(
#'     ui = f7Page(
#'       title = "My app",
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "updateF7Stepper"),
#'         f7Card(
#'           f7Button(inputId = "update", label = "Update stepper"),
#'           f7Stepper(
#'             inputId = "stepper",
#'             label = "My stepper",
#'             min = 0,
#'             max = 10,
#'             size = "small",
#'             value = 4,
#'             wraps = TRUE,
#'             autorepeat = TRUE,
#'             rounded = FALSE,
#'             raised = FALSE,
#'             manual = FALSE
#'           ),
#'           verbatimTextOutput("test")
#'         )
#'       )
#'     ),
#'     server = function(input, output, session) {
#'       output$test <- renderPrint(input$stepper)
#'
#'       observeEvent(input$update, {
#'         updateF7Stepper(
#'           inputId = "stepper",
#'           value = 0.1,
#'           step = 0.01,
#'           size = "large",
#'           min = 0,
#'           max = 1,
#'           wraps = FALSE,
#'           autorepeat = FALSE,
#'           rounded = TRUE,
#'           raised = TRUE,
#'           color = "pink",
#'           manual = TRUE,
#'           decimalPoint = 2
#'         )
#'       })
#'     }
#'   )
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
#' @param color
#' Toggle color: NULL or "primary", "red", "green", "blue",
#' "pink", "yellow", "orange", "purple", "deeppurple", "lightblue",
#' "teal, "lime", "deeporange", "gray", "white", "black".
#'
#' @rdname toggle
#' @export
f7Toggle <- function(inputId, label, checked = FALSE, color = NULL) {
  toggleCl <- "toggle"
  if (!is.null(color)) toggleCl <- paste0(toggleCl, " color-", color)

  shiny::tagList(
    # toggle tag
    shiny::tags$span(label,
      style = "padding: 5px"
    ),
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
#' @param session The Shiny session object.
#'
#' @export
#' @rdname toggle
#'
#' @examples
#' # Update f7Toggle
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   shinyApp(
#'     ui = f7Page(
#'       title = "My app",
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "updateF7Toggle"),
#'         f7Card(
#'           f7Button(inputId = "update", label = "Update toggle"),
#'           f7Toggle(
#'             inputId = "toggle",
#'             label = "My toggle",
#'             color = "pink",
#'             checked = FALSE
#'           ),
#'           verbatimTextOutput("test")
#'         )
#'       )
#'     ),
#'     server = function(input, output, session) {
#'       output$test <- renderPrint({
#'         input$toggle
#'       })
#'
#'       observeEvent(input$update, {
#'         updateF7Toggle(
#'           inputId = "toggle",
#'           checked = !input$toggle,
#'           color = "green"
#'         )
#'       })
#'     }
#'   )
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
#' @inheritParams f7GroupInput
#'
#' @export
#' @rdname radio
#' @example inst/examples/radio/app.R
f7Radio <- function(
    inputId, label, choices = NULL, selected = NULL,
    position = c("left", "right"), inset = FALSE,
    outline = FALSE, dividers = FALSE, strong = FALSE) {
  position <- match.arg(position)
  f7GroupInput(
    type = "radio",
    inputId = inputId,
    label = label,
    choices = choices,
    selected = selected,
    position = position,
    inset = inset,
    outline = outline,
    dividers = dividers,
    strong = strong
  )
}

#' Update Framework7 radio buttons
#'
#' \code{updateF7Radio} updates a radio button input.
#'
#' @param session Shiny session object.
#'
#' @rdname radio
#' @export
updateF7Radio <- function(inputId, label = NULL, choices = NULL,
                          selected = NULL, session = shiny::getDefaultReactiveDomain()) {
  if (is.null(selected)) {
    if (!is.null(choices)) {
      selected <- choices[[1]]
    }
  }

  options <- NULL
  if (!is.null(choices)) {
    options <- as.character(
      shiny::tags$ul(
        createOptions(inputId, choices, selected, type = "radio")
      )
    )
  }

  message <- dropNulls(
    list(
      label = label,
      options = options,
      value = selected
    )
  )

  session$sendInputMessage(inputId, message)
}

#' @export
#' @inheritParams f7CheckboxChoice
#' @rdname radio
f7RadioChoice <- f7CheckboxChoice

#' Framework7 group input
#'
#' Useful to create \code{f7Radio} and \link{f7CheckboxGroup}.
#'
#' @param inputId Input id.
#' @param label Input label
#' @param choices List of choices. Can be a simple
#' vector or named list or a list of \link{f7RadioChoice} or
#' \link{f7CheckboxChoice}
#' @param selected Selected element. NULL by default. If you pass
#' \link{f7RadioChoice} or \link{f7CheckboxChoice} in choices,
#' selected must be a numeric value corresponding to the index of the element to select.
#' @param position Check mark side.
#' \code{"left"} or \code{"right"}.
#' @inheritParams f7List
#'
#' @keywords internal
f7GroupInput <- function(
    type, inputId, label, choices, selected,
    position, inset, outline, dividers, strong) {
  has_media_list <- inherits(choices[[1]], "custom_choice")

  mainCl <- sprintf("shiny-input-%sgroup", type)

  tmp <- f7List(
    mode = if (has_media_list) "media" else NULL,
    inset = inset,
    outline = outline,
    dividers = dividers,
    strong = strong,
    createOptions(
      inputId,
      choices,
      selected,
      position,
      has_media_list,
      type = type
    )
  )

  tmp$attribs$id <- inputId
  tmp$attribs$class <- paste(
    tmp$attribs$class,
    mainCl
  )

  shiny::tagList(
    shiny::tags$div(
      class = "block-title",
      label
    ),
    tmp
  )
}

#' Generates a list of option
#'
#' For \link{f7Radio} and \link{f7CheckboxGroup}
#'
#' @param inputId Radio input id.
#' @param choices List of choices.
#' @param selected Selected value
#' @param position Check mark position.
#' @param has_media_list For custom choices.
#' @param type Choose either "checkbox" or "radio"
#'
#' @keywords internal
createOptions <- function(
    inputId, choices, selected,
    position = "left", has_media_list = FALSE, type) {
  if (has_media_list) position <- "start"

  selectedPosition <- NULL
  selectedPosition <- if (!is.null(selected)) {
    if (has_media_list) {
      if (!is.numeric(selected) || selected > length(choices)) {
        stop("When using f7*Choice (Radio or Checkbox),
        selected must be a numeric value of the choice to select.
        selected can't be higher than the total number of choices.")
      }
      selected
    } else {
      match(selected, choices)
    }
  }

  lapply(X = seq_along(choices), function(i) {
    shiny::tags$li(
      shiny::tags$label(
        class = sprintf(
          "item-%s item-%s-icon-%s item-content",
          type,
          type,
          position
        ),
        shiny::tags$input(
          type = type,
          name = inputId,
          value = if (has_media_list) {
            names(choices)[[i]] %OR% i
          } else {
            choices[[i]]
          },
          checked = if (!is.null(selectedPosition)) {
            if (i == selectedPosition) NA
          }
        ),
        shiny::tags$i(class = sprintf("icon icon-%s", type)),
        shiny::tags$div(
          class = "item-inner",
          if (has_media_list) {
            choices[[i]]
          } else {
            shiny::tags$div(class = "item-title", choices[[i]])
          }
        )
      )
    )
  })
}
