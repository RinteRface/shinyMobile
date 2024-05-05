tabInputs <- f7Tab(
  title = "Inputs",
  tabName = "Inputs",
  icon = f7Icon("rocket_fill"),
  active = TRUE,
  f7BlockTitle(title = "Inputs in list") %>% f7Align(side = "center"),
  f7List(
    inset = FALSE,
    dividers = TRUE,
    strong = TRUE,
    outline = TRUE,
    f7Text(
      inputId = "text",
      label = "f7Text()",
      value = "some text",
      placeholder = "Don't leave me empty!",
      style = list(
        media = f7Icon("pencil")
      )
    ),
    f7TextArea(
      inputId = "textarea",
      label = "f7TextArea()",
      value = "Lorem ipsum dolor sit amet, consectetur
       adipiscing elit, sed do eiusmod tempor incididunt ut
       labore et dolore magna aliqua",
      placeholder = "Your text here",
      resize = TRUE,
      style = list(
        media = f7Icon("pencil")
      )
    ),
    f7Password(
      inputId = "password",
      label = "f7Password()",
      placeholder = "Expect a number",
      style = list(
        media = f7Icon("lock_fill")
      )
    ),
    f7AutoComplete(
      inputId = "myautocomplete",
      placeholder = "Type a fruit name",
      openIn = "dropdown",
      label = "f7AutoComplete()",
      choices = c(
        "Apple", "Apricot", "Avocado", "Banana", "Melon",
        "Orange", "Peach", "Pear", "Pineapple"
      ),
      style = list(
        media = f7Icon("logo_apple"),
        description = "Fruits"
      )
    ),
    f7Select(
      inputId = "select",
      label = "f7Select()",
      choices = colnames(mtcars),
      style = list(
        media = f7Icon("bars")
      )
    ),
    f7Picker(
      inputId = "mypicker",
      placeholder = "Some text here!",
      label = "f7Picker()",
      choices = c("a", "b", "c")
    ),
    f7DatePicker(
      inputId = "mydatepicker",
      label = "f7DatePicker()",
      value = as.POSIXct("2024-03-24 09:00:00 UTC"),
      openIn = "auto",
      direction = "horizontal",
      timePicker = TRUE,
      dateFormat = "yyyy-mm-dd, HH::mm"
    ),
    f7ColorPicker(
      inputId = "mycolorpicker",
      placeholder = "Some text here!",
      label = "f7ColorPicker()",
    ),
    f7SmartSelect(
      inputId = "smartsel",
      label = "f7SmartSelect()",
      selected = "drat",
      choices = colnames(mtcars)[-1],
      openIn = "popup"
    ),
    f7Toggle(
      inputId = "toggle",
      label = "f7Toggle()",
      color = "default",
      checked = TRUE
    ),
    f7Stepper(
      inputId = "stepper",
      label = "f7Stepper()",
      min = 0,
      color = "default",
      max = 10,
      value = 4
    )
  ),
  f7BlockTitle(title = "Outputs") %>% f7Align(side = "center"),
  f7Block(
    strong = TRUE,
    p("Change the inputs and see the outputs below!"),
    f7BlockTitle(title = "f7TextInput()"),
    verbatimTextOutput("text"),
    f7BlockTitle(title = "f7TextArea()"),
    textOutput("textarea"),
    f7BlockTitle(title = "f7Password()"),
    verbatimTextOutput("password"),
    f7BlockTitle(title = "f7AutoComplete()"),
    verbatimTextOutput("autocompleteval"),
    f7BlockTitle(title = "f7Select()"),
    verbatimTextOutput("select"),
    f7BlockTitle(title = "f7Picker()"),
    textOutput("pickerval"),
    f7BlockTitle(title = "f7DatePicker()"),
    verbatimTextOutput("dateval"),
    f7BlockTitle(title = "f7ColorPicker()"),
    verbatimTextOutput("colorPickerVal"),
    f7BlockTitle(title = "f7SmartSelect()"),
    tableOutput("smartdata"),
    f7BlockTitle(title = "f7Toggle()"),
    verbatimTextOutput("toggle"),
    f7BlockTitle(title = "f7Stepper()"),
    verbatimTextOutput("stepper"),
  ),
  br(),
  f7BlockTitle(title = "f7Slider input") %>% f7Align(side = "center"),
  f7Block(
    strong = TRUE,
    p("Slide away!"),
    f7Slider(
      inputId = "sliderInput",
      label = "Unique value",
      max = 20,
      min = 0,
      value = 10,
      scale = FALSE
    ),
    verbatimTextOutput("slider"),
    br(),
    f7Slider(
      inputId = "sliderRangeInput",
      label = "Range values",
      max = 500,
      min = 0,
      value = c(50, 100),
      scale = TRUE,
      labels = tagList(
        f7Icon("bolt_slash_fill"),
        f7Icon("bolt_fill")
      )
    ),
    verbatimTextOutput("sliderRange")
  ),
  f7BlockTitle(title = "f7Checkbox & f7CheckboxGroup input") %>% f7Align(side = "center"),
  f7Block(
    strong = TRUE,
    p("Check it out!"),
    f7BlockTitle(title = "f7Checkbox()"),
    f7Checkbox(
      inputId = "check",
      label = "Check me",
      value = FALSE
    ),
    verbatimTextOutput("check"),
    br(),
    f7CheckboxGroup(
      inputId = "checkgroup",
      label = "f7CheckboxGroup() right - choose variable:",
      choices = colnames(mtcars)[1:3],
      selected = "mpg",
      position = "right"
    ),
    verbatimTextOutput("checkgroup"),
    br(),
    f7CheckboxGroup(
      inputId = "checkgroup2",
      label = "f7CheckboxGroup() left - choose variable:",
      choices = colnames(mtcars)[1:3],
      selected = "cyl",
      position = "left"
    ),
    verbatimTextOutput("checkgroup2")
  ),
  f7BlockTitle(title = "f7Radio input") %>% f7Align(side = "center"),
  f7Block(
    strong = TRUE,
    p("Choose wisely!"),
    f7Radio(
      inputId = "radio",
      label = "f7Radio() - pick fruit:",
      choices = c("banana", "apple", "peach"),
      selected = "apple",
      position = "right",
      style = list(
        outline = FALSE,
        strong = TRUE,
        inset = TRUE,
        dividers = FALSE
      )
    ),
    verbatimTextOutput("radio"),
    br(),
    f7Radio(
      inputId = "radio2",
      label = "Custom choices with f7RadioChoice() - pick one:",
      choices = list(
        f7RadioChoice(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
            Nulla sagittis tellus ut turpis condimentum,
            ut dignissim lacus tincidunt",
          title = "Choice 1",
          subtitle = "David",
          after = "March 16, 2024"
        ),
        f7RadioChoice(
          "Cras dolor metus, ultrices condimentum sodales sit
            amet, pharetra sodales eros. Phasellus vel felis tellus.
            Mauris rutrum ligula nec dapibus feugiat",
          title = "Choice 2",
          subtitle = "Veerle",
          after = "March 17, 2024"
        )
      ),
      selected = 2,
      style = list(
        outline = FALSE,
        strong = TRUE,
        inset = TRUE,
        dividers = TRUE
      )
    ),
    verbatimTextOutput("radio2")
  )
)
