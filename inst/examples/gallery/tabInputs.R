tabInputs <- f7Tab(
  tabName = "Inputs",
  icon = "filter",
  active = TRUE,

  f7Align(
    side = "center",
    h1("miniUI 2.0 brings new inputs for iOs and android")
  ),

  f7BlockTitle(title = "f7Text input") %>% f7Align(side = "center"),
  f7Text(
    inputId = "text",
    label = "Your text",
    value = "some text",
    placeholder = "Your text here"
  ),
  verbatimTextOutput("text"),
  br(),

  f7BlockTitle(title = "f7Password input") %>% f7Align(side = "center"),
  f7Password(
    inputId = "password",
    label = "Password:",
    placeholder = "Your password here"
  ),
  verbatimTextOutput("password"),
  br(),

  f7BlockTitle(title = "f7Slider input") %>% f7Align(side = "center"),
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

  f7BlockTitle(title = "f7Stepper input") %>% f7Align(side = "center"),
  f7Stepper(
    inputId = "stepper",
    label = "My stepper",
    min = 0,
    max = 10,
    value = 4
  ),
  verbatimTextOutput("stepper"),
  br(),

  f7BlockTitle(title = "f7checkBox input") %>% f7Align(side = "center"),
  f7checkBox(
    inputId = "check",
    label = "Checkbox",
    value = FALSE
  ),
  verbatimTextOutput("check"),
  br(),

  f7BlockTitle(title = "f7checkBoxGroup input") %>% f7Align(side = "center"),
  f7checkBoxGroup(
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
  f7Toggle(
    inputId = "toggle",
    label = "My toggle",
    color = "pink",
    checked = TRUE
  ),
  verbatimTextOutput("toggle"),
  br(),

  f7BlockTitle(title = "f7Select input") %>% f7Align(side = "center"),
  f7Select(
    inputId = "select",
    label = "Choose a variable:",
    choices = colnames(mtcars)
  ),
  verbatimTextOutput("select")
)
