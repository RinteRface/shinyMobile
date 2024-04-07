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
#' @param ... Extra options.
#' See \url{https://framework7.io/docs/autocomplete#autocomplete-parameters}
#' @param style Autocomplete styling parameters.
#' Only available when `openIn` is "dropdown".
#'
#' @rdname autocomplete
#' @note Contrary to \link{f7Text}, this input can't be cleared.
#'
#' @example inst/examples/autocomplete/app.R
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7AutoComplete <- function(
    inputId, label = NULL, placeholder = NULL,
    value = NULL, choices,
    openIn = c("popup", "page", "dropdown"),
    typeahead = TRUE, expandInput = deprecated(), closeOnSelect = FALSE,
    dropdownPlaceholderText = NULL, multiple = FALSE, limit = NULL,
    style = list(
      media = NULL,
      description = NULL,
      floating = FALSE,
      outline = FALSE
    ), ...) {
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

  is_standalone <- type %in% c("page", "popup")

  config <- dropNulls(
    list(
      choices = choices,
      value = I(value),
      openIn = type,
      limit = limit,
      multiple = if (is_standalone) multiple,
      closeOnSelect = if (is_standalone) closeOnSelect,
      typeahead = if (!is_standalone) typeahead,
      dropdownPlaceholderText = if (!is_standalone) dropdownPlaceholderText,
      ...
    )
  )

  configTag <- buildConfig(inputId, config)

  # wrap props
  autoCompleteInnerTag <- if (!is_standalone) {
    shiny::tags$input(
      id = inputId,
      class = "autocomplete-input",
      type = "text",
      placeholder = placeholder,
      configTag
    )
  } else {
    tempTag <- shiny::tags$a(
      id = inputId,
      class = "autocomplete-input item-link item-content",
      href = "#",
      configTag
    )
    shiny::tagAppendChildren(
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
  style$clearable <- FALSE
  if (!is_standalone) {
    listify(
      htmltools::tagQuery(
        createInputLayout(
          label = label,
          autoCompleteInnerTag,
          style = style
        )
      )$
        find(".item-input")$
        addClass("inline-label")$
        allTags()
    )
  } else {
    listify(autoCompleteInnerTag)
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
updateF7AutoComplete <- function(inputId, value = NULL, choices = NULL, ...,
                                 session = shiny::getDefaultReactiveDomain()) {
  message <- dropNulls(
    list(
      value = I(value),
      choices = choices,
      ...
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
#' @param ... Other options to pass to the picker. See
#' \url{https://framework7.io/docs/picker#picker-parameters}.
#'
#' @rdname picker
#' @example inst/examples/picker/app.R
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Picker <- function(inputId, label, placeholder = NULL, value = choices[1], choices,
                     rotateEffect = TRUE, openIn = "auto", scrollToInput = FALSE,
                     closeByOutsideClick = TRUE, toolbar = TRUE, toolbarCloseText = "Done",
                     sheetSwipeToClose = FALSE, ...) {
  if (length(value) > 1) stop("value must be a single element")

  # JS needs array
  if (!is.null(value)) {
    value <- list(value)
  } else {
    value <- list()
  }

  # TO DO: create helper function for sheet, picker, ...
  # since they're all the same ...
  config <- dropNulls(
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
      sheetSwipeToClose = sheetSwipeToClose,
      ...
    )
  )

  buildPickerInput(
    inputId,
    label,
    config,
    "picker-input",
    placeholder
  )
}

#' Build input tag for picker elements
#'
#' @keywords internal
buildPickerInput <- function(id, label, config, class, placeholder = NULL) {
  inputTag <- shiny::tags$li(
    shiny::tags$div(
      class = "item-content item-input",
      shiny::tags$div(
        class = "item-inner",
        shiny::tags$div(
          class = "item-input-wrap",
          shiny::tags$input(
            id = id,
            class = class,
            type = "text",
            placeholder = placeholder
          ),
          buildConfig(id, config)
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
    listify(inputTag)
  )
}

#' Build config tag for JavaScript
#'
#' See \url{https://unleash-shiny.rinterface.com/shiny-input-system#boxes-on-steroids-more}
#'
#' @keywords internal
buildConfig <- function(id, config) {
  shiny::tags$script(
    type = "application/json",
    `data-for` = id,
    jsonlite::toJSON(
      x = config,
      auto_unbox = TRUE,
      json_verbatim = TRUE
    )
  )
}

#' Update Framework7 picker
#'
#' \code{updateF7Picker} changes the value of a picker input on the client.
#'
#' @param session The Shiny session object, usually the default value will suffice.
#'
#' @export
#' @rdname picker
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
#' @param value Initial picker value in hex.
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
#' @param ... Other options to pass to the picker. See
#' \url{https://framework7.io/docs/color-picker#color-picker-parameters}.
#'
#' @return The return value is a list and includes hex, rgb, hsl, hsb, alpha, hue, rgba, and hsla values.
#' See \url{https://framework7.io/docs/color-picker#color-picker-value}.
#'
#' @example inst/examples/colorpicker/app.R
#'
#' @export
f7ColorPicker <- function(inputId, label, value = "#ff0000", placeholder = NULL,
                          modules = f7ColorPickerModules, palettes = f7ColorPickerPalettes,
                          sliderValue = TRUE, sliderValueEditable = TRUE,
                          sliderLabel = TRUE, hexLabel = TRUE,
                          hexValueEditable = TRUE, groupedModules = TRUE, ...) {
  if (!is.null(value) && length(value) == 1) {
    # needed by JS (array)
    value <- list(hex = value)
  } else {
    stop("value cannot be NULL and must be a single color")
  }

  config <- dropNulls(list(
    value = value,
    modules = modules,
    palettes = palettes,
    sliderValue = sliderValue,
    sliderValueEditable = sliderValueEditable,
    sliderLabel = sliderLabel,
    hexLabel = hexLabel,
    hexValueEditable = hexValueEditable,
    groupedModules = groupedModules,
    ...
  ))

  buildPickerInput(
    inputId,
    label,
    config,
    "color-picker-input",
    placeholder
  )
}

#' Framework7 date picker
#'
#' \code{f7DatePicker} creates a Framework7 date picker input.
#'
#' @param inputId Date input id.
#' @param label Input label.
#' @param value Array with initial selected dates. Each array item represents selected date.
#' If timePicker enabled, the value needs to be an object of type POSIXct.
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
#' @param ... Other options to pass to the picker. See
#' \url{https://framework7.io/docs/calendar#calendar-parameters}.
#'
#' @importFrom jsonlite toJSON
#' @rdname datepicker
#'
#' @return a \code{Date} vector.
#'
#' @export
#' @example inst/examples/datepicker/app.R
f7DatePicker <- function(inputId, label, value = NULL, multiple = FALSE, direction = c("horizontal", "vertical"),
                         minDate = NULL, maxDate = NULL, dateFormat = "yyyy-mm-dd",
                         openIn = c("auto", "popover", "sheet", "customModal"),
                         scrollToInput = FALSE, closeByOutsideClick = TRUE,
                         toolbar = TRUE, toolbarCloseText = "Done", header = FALSE,
                         headerPlaceholder = "Select date", ...) {
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
    headerPlaceholder = headerPlaceholder,
    ...
  ))

  buildPickerInput(
    inputId,
    label,
    config,
    "calendar-input"
  )
}

#' Update Framework7 date picker
#'
#' \code{updateF7DatePicker} changes the value of a date picker input on the client.
#'
#' @param session The Shiny session object, usually the default value will suffice.
#'
#' @export
#'
#' @rdname datepicker
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
    position = c("left", "right"), style = list(
      inset = FALSE,
      outline = FALSE, dividers = FALSE, strong = FALSE
    )) {
  position <- match.arg(position)
  f7GroupInput(
    type = "checkbox",
    inputId = inputId,
    label = label,
    choices = choices,
    selected = selected,
    position = position,
    style = style
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
        media = f7Icon(), # fake item to force layout
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
#' @param choices Select input choices.
#' @param selected Select input default selected value.
#' @param width The width of the input, e.g. \code{400px}, or \code{100\%}.
#' @inheritParams f7Text
#'
#' @note Contrary to \link{f7Text}, \link{f7Select} can't be cleared and
#' label can't float.
#'
#' @export
#' @rdname select
#'
#' @example inst/examples/select/app.R
f7Select <- function(
    inputId, label, choices, selected = NULL, width = NULL,
    style = list(
      media = NULL,
      description = NULL,
      outline = FALSE
    )) {
  options <- createSelectOptions(choices, selected)

  style$clearable <- FALSE # Can't be cleared
  style$floating <- FALSE # Can't be changed because can't be cleared

  selectTag <- createInputLayout(
    shiny::tags$select(
      class = "input-select",
      id = inputId,
      placeholder = "Please choose...",
      options
    ),
    label = label,
    dropdown = TRUE,
    style = style
  )

  if (!is.null(width)) {
    selectTag$attribs$style <- paste0("width:", htmltools::validateCssUnit(width), ";")
  }

  selectTag
}

#' Update Framework7 select
#'
#' \code{updateF7Select} changes the value of a select input on the client
#'
#' @param session The Shiny session object, usually the default value will suffice.
#'
#' @export
#' @rdname select
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
#' @param maxLength Maximum items to select when multiple is TRUE.
#' @param virtualList Enable Virtual List for smart select if your select has a lot
#' of options. Default to FALSE.
#' @param ... Other options. See \url{https://framework7.io/docs/smart-select#smart-select-parameters}.
#'
#' @rdname smartselect
#'
#' @export
#'
#' @example inst/examples/smartselect/app.R
f7SmartSelect <- function(inputId, label, choices, selected = NULL,
                          openIn = c("page", "sheet", "popup", "popover"),
                          searchbar = TRUE, multiple = FALSE, maxLength = NULL,
                          virtualList = FALSE, ...) {
  options <- createSelectOptions(choices, selected)
  type <- match.arg(openIn)

  config <- dropNulls(list(
    openIn = type,
    searchbar = searchbar,
    searchbarPlaceholder = "Search",
    virtualList = virtualList,
    maxLength = maxLength,
    ...
  ))

  listify(
    shiny::tags$li(
      shiny::tags$a(
        class = "item-link smart-select",
        id = inputId,
        shiny::tags$select(
          multiple = if (multiple) NA else NULL,
          options
        ),
        htmltools::tagQuery(
          f7ListItem(title = label)
        )$
          find(".item-content")$
          selectedTags(),
        buildConfig(inputId, config)
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

#' Create common input layout
#'
#' See \url{https://framework7.io/docs/inputs#inputs-layout}.
#'
#' @keywords internal
createInputLayout <- function(
    ..., label = NULL, style, dropdown = FALSE) {
  if (style$floating && is.null(label)) {
    stop("floating can't be used when label is NULL")
  }

  item <- f7ListItem(
    media = style$media, # icon
    title = label # label
  )

  classes <- c(
    "item-input",
    if (style$outline) "item-input-outline",
    if (!is.null(style$description)) "item-input-with-info"
  )

  item <- htmltools::tagQuery(item)$
    find(".item-content")$
    addClass(classes)$
    allTags()

  # Add label on title + add input wrap sibling
  if (!is.null(label)) {
    item <- htmltools::tagQuery(item)$
      find(".item-title")$
      addClass("item-label")$
      allTags()
  }

  innerItems <- shiny::tags$div(
    class = paste0(
      "item-input-wrap",
      if (dropdown) " input-dropdown-wrap"
    ),
    ...,
    if (style$clearable) shiny::span(class = "input-clear-button"),
    if (!is.null(style$description)) {
      shiny::tags$div(
        class = "item-input-info",
        style$description
      )
    }
  )

  item <- if (is.null(label)) {
    htmltools::tagQuery(item)$
      find(".item-inner")$
      append(innerItems)$
      allTags()
  } else {
    htmltools::tagQuery(item)$
      find(".item-title")$
      after(innerItems)$
      allTags()
  }

  # Remove extra item-title-row class if media
  if (!is.null(style$media) && !is.null(label)) {
    inner <- htmltools::tagQuery(item)$
      find(".item-title-row")$
      selectedTags()[[1]]$children

    item <- htmltools::tagQuery(item)$
      find(".item-title-row")$
      replaceWith(inner)$
      allTags()
  }

  if (style$floating) {
    item <- htmltools::tagQuery(item)$
      find(".item-title")$
      removeClass("item-label")$
      addClass("item-floating-label")$
      allTags()
  }

  # Is item wrapped in a f7List? If yes, we return it,
  # if no, we wrap it to avoid rendering issues.
  # This list can't be styled as this would conflict
  # with the input style.
  listify(item)
}

listify <- function(tag) {
  is_wrapped <- sum(
    grepl(
      "^f7List",
      perl = TRUE,
      as.character(sys.calls())
    )
  ) == 1

  # This list can't be styled as this would conflict
  # with the input style.
  if (!is_wrapped) f7List(tag) else tag
}

#' Create an input tag
#'
#' Useful for text inputs, password input ...
#'
#' @keywords internal
createInputTag <- function(inputId, value = NULL, type, placeholder, ...) {
  tagFunc <- if (type %in% c("textarea", "select")) {
    shiny::tags[[type]]
  } else {
    shiny::tags$input
  }

  tagFunc(
    id = inputId,
    value = value,
    if (type == "textarea") value,
    type = type,
    placeholder = placeholder,
    ...
  )
}

#' Framework7 text input
#'
#' \code{f7Text} creates a text input container.
#'
#' @param inputId Text input id.
#' @param label Text input label.
#' @param value Text input value.
#' @param placeholder Text input placeholder.
#' @param style. Input style. A list with media (image or icon),
#' description (text), floating, outline and clearable (booleans).
#'
#' @rdname text
#'
#' @export
#'
#' @example inst/examples/text/app.R
f7Text <- function(
    inputId, label = NULL, value = "", placeholder = NULL,
    style = list(
      media = NULL,
      description = NULL,
      floating = FALSE,
      outline = FALSE,
      clearable = TRUE
    )) {
  inputTag <- createInputTag(
    inputId = inputId,
    value = value,
    type = "text",
    placeholder = placeholder
  )

  do.call(
    createInputLayout,
    list(
      inputTag,
      label = label,
      style = style
    )
  )
}

#' Update Framework7 text input
#'
#' \code{updateF7Text} changes the value of a text input on the client.
#'
#' @param session The Shiny session object, usually the default value will suffice.
#' @note Updating label does not work yet.
#' @export
#' @rdname text
updateF7Text <- function(
    inputId, label = NULL, value = NULL, placeholder = NULL,
    session = shiny::getDefaultReactiveDomain()) {
  message <- dropNulls(list(label = label, value = value, placeholder = placeholder))
  session$sendInputMessage(inputId, message)
}

#' Framework7 text area input
#'
#' \code{f7TextArea} creates a f7 text area input.
#'
#' @param resize Whether to box can be resized. Default to FALSE.
#'
#' @export
#' @rdname text
f7TextArea <- function(inputId, label, value = "", placeholder = NULL,
                       resize = FALSE, style = list(
                         media = NULL,
                         description = NULL,
                         floating = FALSE,
                         outline = FALSE,
                         clearable = TRUE
                       )) {
  inputTag <- createInputTag(
    inputId = inputId,
    value = value,
    type = "textarea",
    placeholder = placeholder,
    class = if (resize) "resizable" else NULL
  )

  do.call(
    createInputLayout,
    list(
      inputTag,
      label = label,
      style = style
    )
  )
}

#' Update Framework7 text area input
#'
#' \code{updateF7TextArea} changes the value of a text area input on the client.
#'
#' @rdname text
#' @export
updateF7TextArea <- updateF7Text

#' Create an f7 password input
#'
#' \link{f7Password} creates a password input.
#'
#' @export
#' @rdname text
f7Password <- function(
    inputId, label, placeholder = NULL,
    style = list(
      media = NULL,
      description = NULL,
      floating = FALSE,
      outline = FALSE,
      clearable = TRUE
    )) {
  inputTag <- createInputTag(
    inputId = inputId,
    type = "password",
    placeholder = placeholder
  )

  do.call(
    createInputLayout,
    list(
      inputTag,
      label = label,
      style = style
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
#' @param showLabel Allow bubble containing the slider value. Default
#' to TRUE.
#' @param ... Other options to pass to the widget. See
#' \url{https://framework7.io/docs/range-slider#range-slider-parameters}.
#' @param style Allows to style the input. inset, outline and strong are available.
#'
#' @note labels option only works when vertical is FALSE!
#'
#' @rdname slider
#'
#' @export
#'
#' @example inst/examples/slider/app.R
f7Slider <- function(inputId, label, min, max, value, step = 1, scale = FALSE,
                     scaleSteps = 5, scaleSubSteps = 0, vertical = FALSE,
                     verticalReversed = FALSE, labels = NULL, color = NULL,
                     noSwipping = TRUE, showLabel = TRUE, ...,
                     style = list(
                       inset = FALSE,
                       outline = FALSE,
                       strong = FALSE
                     )) {
  if (!is.null(labels)) {
    if (length(labels) < 2) stop("labels must be a tagList with 2 elements.")
  }

  sliderCl <- "range-slider"
  if (!is.null(color)) sliderCl <- paste0(sliderCl, " color-", color)

  if (isTRUE(noSwipping)) {
    sliderCl <- paste(sliderCl, "swiper-no-swiping")
  }

  config <- dropNulls(
    list(
      dual = if (length(value) == 2) TRUE else FALSE,
      min = min,
      max = max,
      vertical = vertical,
      verticalReversed = if (vertical) verticalReversed,
      label = showLabel,
      step = step,
      value = value,
      scale = scale,
      scaleSteps = scaleSteps,
      scaleSubSteps = scaleSubSteps
    )
  )

  # wrap props
  rangeTag <- shiny::tags$div(
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
    buildConfig(inputId, config)
  )

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
  }

  # wrapper
  shiny::tagList(
    # HTML skeleton
    shiny::tags$div(class = "block-title", label),
    if (!is.null(labels)) {
      f7List(
        mode = "simple",
        inset = style$inset,
        outline = style$outline,
        strong = style$strong,
        shiny::tags$li(
          labels[[1]],
          shiny::tags$div(
            style = "width: 100%; margin: 0 16px",
            rangeTag
          ),
          labels[[2]]
        )
      )
    } else {
      f7Block(
        inset = style$inset,
        outline = style$outline,
        strong = style$strong,
        rangeTag
      )
    }
  )
}

#' Update Framework7 range slider
#'
#' \code{updateF7Slider} changes the value of a slider input on the client.
#'
#' @param session The Shiny session object.
#'
#' @export
#' @rdname slider
#'
#' @note Important: you cannot transform a range slider into a simple slider and inversely.
updateF7Slider <- function(inputId, min = NULL, max = NULL, value = NULL,
                           scale = FALSE, scaleSteps = NULL, scaleSubSteps = NULL,
                           step = NULL, color = NULL, ...,
                           session = shiny::getDefaultReactiveDomain()) {
  message <- dropNulls(list(
    value = value,
    min = min,
    max = max,
    scale = scale,
    step = step,
    scaleSteps = scaleSteps,
    scaleSubSteps = scaleSubSteps,
    color = color,
    ...
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
#' @param layout Either "default" or "list" (input is pushed to the right side).
#'
#' @rdname stepper
#' @example inst/examples/stepper/app.R
#' @export
f7Stepper <- function(inputId, label, min, max, value, step = 1,
                      fill = FALSE, rounded = FALSE, raised = FALSE, size = NULL,
                      color = NULL, wraps = FALSE, autorepeat = TRUE, manual = FALSE,
                      decimalPoint = 4, buttonsEndInputMode = TRUE, layout = c("default", "list")) {
  layout <- match.arg(layout)
  stepperCl <- "stepper"
  if (fill) stepperCl <- paste(stepperCl, "stepper-fill")
  if (rounded) stepperCl <- paste(stepperCl, "stepper-round")
  if (!is.null(size)) {
    stepperCl <- paste0(stepperCl, " stepper-", size)
  }
  if (raised) stepperCl <- paste(stepperCl, "stepper-raised")
  if (!is.null(color)) stepperCl <- paste0(stepperCl, " color-", color)

  # stepper props
  config <- dropNulls(
    list(
      min = min,
      max = max,
      step = step,
      value = value,
      decimalPoint = decimalPoint,
      wraps = wraps,
      autorepeat = autorepeat,
      autorepeatDynamic = autorepeat,
      manualInputMode = manual,
      buttonsEndInputMode = buttonsEndInputMode
    )
  )

  # wrap props
  stepperTag <- shiny::tags$div(
    class = stepperCl,
    id = inputId,
    buildConfig(inputId, config)
  )

  stepperTag <- shiny::tagAppendChildren(
    stepperTag,
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
  switch(layout,
    "default" = shiny::div(
      # stepper tag
      style = "display: flex; align-items: center;",
      shiny::tags$small(label, style = "padding: 5px"),
      stepperTag
    ),
    "list" = listify(
      f7ListItem(
        title = label,
        right = stepperTag
      )
    )
  )
}

#' Update Framework7 stepper
#'
#' \code{updateF7Stepper} changes the value of a stepper input on the client.
#'
#' @param session The Shiny session object, usually the default value will suffice.
#'
#' @export
#' @rdname stepper
#'
#' @note While updating, the autorepeat field does not work correctly.
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
#' @example inst/examples/toggle/app.R
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
    position = c("left", "right"), style = list(
      inset = FALSE,
      outline = FALSE, dividers = FALSE, strong = FALSE
    )) {
  position <- match.arg(position)
  f7GroupInput(
    type = "radio",
    inputId = inputId,
    label = label,
    choices = choices,
    selected = selected,
    position = position,
    style = style
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
#' @param style Input style. Inherit from \link{f7List} options
#' such as outline, inset, strong and dividers.
#'
#' @keywords internal
f7GroupInput <- function(
    type, inputId, label, choices, selected, position, style) {
  has_media_list <- inherits(choices[[1]], "custom_choice")

  mainCl <- sprintf("shiny-input-%sgroup", type)

  tmp <- f7List(
    mode = if (has_media_list) "media" else NULL,
    inset = style$inset,
    outline = style$outline,
    dividers = style$dividers,
    strong = style$strong,
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

# createInputsForm <- function(..., id) {
#  inputs <- list(...)
#  # All inputs must have a name + no binding
#  inputs <- lapply(inputs, \(input) {
#    browser()
#    htmltools::tagQuery(input)$
#      find("input") # $
#    # addAttrs()
#    # name = input$attribs$id,
#    # `data-shiny-no-bind-input` = NA
#  })
#  shiny::tags$div(id = id, inputs)
# }
