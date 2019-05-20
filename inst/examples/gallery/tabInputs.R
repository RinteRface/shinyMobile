tabInputs <- f7Tab(
  tabName = "tabinputs",
  icon = "data_fill",
  active = TRUE,

  f7Align(
    side = "center",
    h1("miniUI 2.0 brings new inputs for iOs and android")
  ),

  f7Text(
    inputId = "text",
    label = "Your text",
    value = "some text",
    placeholder = "Your text here"
  ),
  verbatimTextOutput("text"),

  br(),
  f7Password(
    inputId = "password",
    label = "Password:",
    placeholder = "Your password here"
  ),
  verbatimTextOutput("password"),

  br(),
  f7Slider(
    inputId = "slider",
    label = "Range values",
    max = 500,
    min = 0,
    value = c(50, 100),
    scale = TRUE
  ),
  verbatimTextOutput("slider"),

  br(),
  f7Stepper(
    inputId = "stepper",
    label = "My stepper",
    min = 0,
    max = 10,
    value = 4
  ),
  verbatimTextOutput("stepper"),

  br(),
  f7checkBox(
    inputId = "check",
    label = "Checkbox",
    value = FALSE
  ),
  verbatimTextOutput("check"),

  br(),
  f7checkBoxGroup(
    inputId = "checkgroup",
    label = "Choose a variable:",
    choices = colnames(mtcars),
    selected = "mpg"
  ),
  verbatimTextOutput("checkgroup"),

  br(),
  f7Radio(
    inputId = "radio",
    label = "Choose a fruit:",
    choices = c("banana", "apple", "peach"),
    selected = "apple"
  ),
  verbatimTextOutput("radio"),

  br(),
  f7Toggle(
    inputId = "toggle",
    label = "My toggle",
    color = "pink",
    checked = TRUE
  ),
  verbatimTextOutput("toggle"),

  br(),
  f7Select(
    inputId = "select",
    label = "Choose a variable:",
    choices = colnames(mtcars)
  ),
  verbatimTextOutput("select")
)
