tabInputs <- f7Tab(
  title = "Inputs",
  tabName = "Inputs",
  icon = f7Icon("rocket_fill"),
  active = TRUE,

  f7BlockTitle(title = "f7Text input with validation") %>% f7Align(side = "center"),
  f7Text(
    inputId = "text",
    label = "Your text",
    value = "some text",
    placeholder = "Don't leave me empty!"
  ),
  verbatimTextOutput("text"),
  br(),

  f7BlockTitle(title = "f7TextArea input") %>% f7Align(side = "center"),
  f7TextArea(
    inputId = "textarea",
    label = "Text Area",
    value = "Lorem ipsum dolor sit amet, consectetur
       adipiscing elit, sed do eiusmod tempor incididunt ut
       labore et dolore magna aliqua",
    placeholder = "Your text here",
    resize = TRUE
  ),
  textOutput("textarea"),

  f7BlockTitle(title = "f7Password input with validation") %>% f7Align(side = "center"),
  f7Password(
    inputId = "password",
    label = "Password:",
    placeholder = "Expect a number"
  ),
  verbatimTextOutput("password"),
  br(),

  f7BlockTitle(title = "f7Slider input") %>% f7Align(side = "center"),
  f7Block(
    strong = TRUE,
    f7Slider(
      inputId = "slider",
      label = "Unique value",
      max = 20,
      min = 0,
      value = 10,
      scale = FALSE
    ),
    verbatimTextOutput("slider")
  ),
  br(),
  f7Slider(
    inputId = "sliderRange",
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
  verbatimTextOutput("sliderRange"),

  br(),

  f7BlockTitle(title = "f7Stepper input") %>% f7Align(side = "center"),
  f7Block(
    strong = TRUE,
    f7Stepper(
      inputId = "stepper",
      label = "My stepper",
      min = 0,
      color = "default",
      max = 10,
      value = 4
    ),
    verbatimTextOutput("stepper")
  ),
  br(),

  f7BlockTitle(title = "f7Checkbox input") %>% f7Align(side = "center"),
  f7Block(
    strong = TRUE,
    f7Checkbox(
      inputId = "check",
      label = "Checkbox",
      value = FALSE
    ),
    verbatimTextOutput("check")
  ),
  br(),

  f7BlockTitle(title = "f7CheckboxGroup input") %>% f7Align(side = "center"),
  f7CheckboxGroup(
    inputId = "checkgroup",
    label = "Choose a variable:",
    choices = colnames(mtcars)[1:3],
    selected = "mpg"
  ),
  verbatimTextOutput("checkgroup"),
  br(),

  f7BlockTitle(title = "f7Radio input") %>% f7Align(side = "center"),
  f7Radio(
    inputId = "radio",
    label = "Choose a fruit:",
    choices = c("banana", "apple", "peach"),
    selected = "apple"
  ),
  verbatimTextOutput("radio"),
  br(),

  f7BlockTitle(title = "f7Toggle input") %>% f7Align(side = "center"),
  f7Block(
    strong = TRUE,
    f7Toggle(
      inputId = "toggle",
      label = "My toggle",
      color = "default",
      checked = TRUE
    ),
    verbatimTextOutput("toggle")
  ),
  br(),

  f7BlockTitle(title = "f7Select input") %>% f7Align(side = "center"),
  f7Select(
    inputId = "select",
    label = "Choose a variable:",
    choices = colnames(mtcars)
  ),
  verbatimTextOutput("select"),
  br(),

  f7BlockTitle(title = "f7SmartSelect input") %>% f7Align(side = "center"),
  f7SmartSelect(
    inputId = "smartsel",
    label = "Choose a variable:",
    selected = "drat",
    choices = colnames(mtcars)[-1],
    openIn = "popup"
  ),
  tableOutput("smartdata"),
  br(),

  f7BlockTitle(title = "f7AutoComplete input") %>% f7Align(side = "center"),
  f7AutoComplete(
    inputId = "myautocomplete",
    placeholder = "Select a fruit!",
    openIn = "dropdown",
    label = "Type a fruit name",
    choices = c('Apple', 'Apricot', 'Avocado', 'Banana', 'Melon',
                'Orange', 'Peach', 'Pear', 'Pineapple')
  ),
  verbatimTextOutput("autocompleteval"),
  br(),

  f7BlockTitle(title = "f7Date input") %>% f7Align(side = "center"),
  f7DatePicker(
    inputId = "date",
    label = "Choose a date",
    value = "2019-08-24"
  ),
  "The selected date is",
  verbatimTextOutput("selectDate"),
  br(),

  f7BlockTitle(title = "f7Picker input") %>% f7Align(side = "center"),
  f7Picker(
    inputId = "mypicker",
    placeholder = "Some text here!",
    label = "Picker Input",
    choices = c('a', 'b', 'c')
  ),
  textOutput("pickerval"),
  br(),


  f7BlockTitle(title = "f7ColorPicker input") %>% f7Align(side = "center"),
  f7ColorPicker(
    inputId = "mycolorpicker",
    placeholder = "Some text here!",
    label = "Select a color"
  ),
  "The picker value is:",
  textOutput("colorPickerVal")
)
