#' Provide a template for authentication
#'
#' This function does not provide the backend features. You would
#' need to store credentials in a database for instance.
#'
#' @note There is an input associated with the login status, namely input$login.
#' It is linked to an action button, which is 0 when the application starts. As soon
#' as the button is pressed, its value is incremented which might fire a
#' \code{observeEvent} listening to it (See example below). Importantly,
#' the login page is closed only if the text and password inputs are filled. The
#' \link{f7LoginServer} contains a piece of server logic that does this work for you.
#'
#' @param ... Slot for inputs like password, text, ...
#' @param id Login unique id. input$<id> gives the status of the login page (
#' either opened or closed).
#' @param title Login page title.
#' @param label Login confirm button label.
#' @param footer Optional footer.
#' @param startOpen Whether to open the login page at start. Default to TRUE. There
#' are some cases where it is interesting to set up to FALSE, for instance when you want
#' to have authentication only in a specific tab of your app (See example 2).
#'
#' @export
#' @rdname authentication
#' @importFrom jsonlite toJSON
#' @examples
#' if (interactive()) {
#'  # global authentication
#'  library(shiny)
#'  library(shinyMobile)
#'  shinyApp(
#'    ui = f7Page(
#'      title = "Login module",
#'      f7SingleLayout(
#'        navbar = f7Navbar(
#'          title = "Login Example",
#'          hairline = FALSE,
#'          shadow = TRUE
#'        ),
#'        toolbar = f7Toolbar(
#'          position = "bottom",
#'          f7Link(label = "Link 1", href = "https://www.google.com"),
#'          f7Link(label = "Link 2", href = "https://www.google.com")
#'        ),
#'        f7Login(id = "loginPage", title = "Welcome"),
#'        # main content
#'        f7BlockTitle(
#'          title = HTML(paste("Welcome", textOutput("user"))),
#'          size = "large"
#'        ) %>% f7Align("center")
#'      )
#'    ),
#'    server = function(input, output, session) {
#'
#'      loginData <- callModule(f7LoginServer, id = "loginPage")
#'
#'      output$user <- renderText({
#'       req(loginData$user)
#'       loginData$user()
#'      })
#'    }
#'  )
#'
#'  # section specific authentication
#'  library(shiny)
#'  library(shinyMobile)
#'  shinyApp(
#'    ui = f7Page(
#'      title = "Local access restriction",
#'      f7TabLayout(
#'        navbar = f7Navbar(
#'          title = "Login Example for Specific Section",
#'          hairline = FALSE,
#'          shadow = TRUE
#'        ),
#'        f7Tabs(
#'          id = "tabs",
#'          f7Tab(
#'            tabName = "Tab 1",
#'            "Without authentication"
#'          ),
#'          f7Tab(
#'            tabName = "Restricted",
#'            # main content
#'            f7BlockTitle(
#'              title = HTML(paste("Welcome", textOutput("user"))),
#'              size = "large"
#'            ) %>% f7Align("center")
#'          )
#'        ),
#'        f7Login(id = "loginPage", title = "Welcome", startOpen = FALSE)
#'      )
#'    ),
#'    server = function(input, output, session) {
#'
#'      # trigger
#'      trigger <- reactive({
#'       req(input$tabs)
#'      })
#'
#'      # do not run first since the login page is not yet visible
#'      loginData <- callModule(
#'       f7LoginServer,
#'       id = "loginPage",
#'       ignoreInit = TRUE,
#'       trigger = trigger
#'      )
#'
#'      output$user <- renderText({
#'       req(loginData$user)
#'       loginData$user()
#'      })
#'
#'    }
#'  )
#'
#'  # with 2 different protected sections
#'  library(shiny)
#'  library(shinyMobile)
#'  shinyApp(
#'    ui = f7Page(
#'      title = "Multiple restricted areas",
#'      f7TabLayout(
#'        navbar = f7Navbar(
#'          title = "Login Example for 2 Specific Section",
#'          hairline = FALSE,
#'          shadow = TRUE
#'        ),
#'        f7Tabs(
#'          id = "tabs",
#'          f7Tab(
#'            tabName = "Tab 1",
#'            "Without authentication"
#'          ),
#'          f7Tab(
#'            tabName = "Restricted",
#'            # main content
#'            f7BlockTitle(
#'              title = "1st restricted area",
#'              size = "large"
#'            ) %>% f7Align("center")
#'          ),
#'          f7Tab(
#'            tabName = "Restricted 2",
#'            # main content
#'            f7BlockTitle(
#'              title = "2nd restricted area",
#'              size = "large"
#'            ) %>% f7Align("center")
#'          )
#'        ),
#'        f7Login(id = "loginPage", title = "Welcome", startOpen = FALSE),
#'        f7Login(id = "loginPage2", title = "Welcome", startOpen = FALSE)
#'      )
#'    ),
#'    server = function(input, output, session) {
#'
#'      trigger1 <- reactive({
#'        req(input$tabs == "Restricted")
#'      })
#'
#'      trigger2 <- reactive({
#'        req(input$tabs == "Restricted 2")
#'      })
#'
#'      # do not run first since the login page is not yet visible
#'      callModule(
#'        f7LoginServer,
#'        id = "loginPage",
#'        ignoreInit = TRUE,
#'        trigger = trigger1
#'      )
#'
#'      callModule(
#'        f7LoginServer,
#'        id = "loginPage2",
#'        ignoreInit = TRUE,
#'        trigger = trigger2
#'      )
#'
#'    }
#'  )
#' }
f7Login <- function(..., id, title, label = "Sign In", footer = NULL,
                    startOpen = TRUE) {

  ns <- shiny::NS(id)

  submitBttn <- f7Button(inputId = ns("login"), label = label)
  submitBttn[[2]]$attribs$class <- "item-link list-button f7-action-button"
  submitBttn[[2]]$name <- "a"

  shiny::tags$div(
    id = ns(id),
    `data-start-open` = jsonlite::toJSON(startOpen),
    class = "login-screen",
    shiny::tags$div(
      class = "view",
      shiny::tags$div(
        class = "page",
        shiny::tags$div(
          class = "page-content login-screen-content",
          shiny::tags$div(class = "login-screen-title", title),

          # inputs
          shiny::tags$form(
            shiny::tags$div(
              class = "list", shiny::tags$ul(
                f7Text(
                  inputId = ns("login_user"),
                  label = "",
                  placeholder = "Your name here"
                ),
                f7Password(
                  inputId = ns("login_password"),
                  label = "",
                  placeholder = "Your password here"
                ),
                ...
              )
            ),
            shiny::tags$div(
              class = "list",
              shiny::tags$ul(shiny::tags$li(submitBttn)),
              if (!is.null(footer)) {
                shiny::tags$div(class = "block-footer", footer)
              }
            )
          )
        )
      )
    )
  )
}


#' Useful server elements to fine tune the \link{f7Login} page
#'
#' @param input Shiny input object.
#' @param output Shiny output object.
#' @param session Shiny session object.
#' @param ignoreInit If TRUE, then, when this observeEvent is first
#' created/initialized, ignore the handlerExpr (the second argument),
#' whether it is otherwise supposed to run or not. The default is FALSE.
#' @param trigger Reactive trigger to toggle the login page state. Useful, when
#' one wants to set up local authentication (for a specific section). See example 2.
#'
#' @export
#' @rdname authentication
f7LoginServer <- function(input, output, session, ignoreInit = FALSE,
                          trigger = NULL) {

  ns <- session$ns
  # module id
  modId <- strsplit(ns(""), "-")[[1]][1]

  # this is needed if we have local authentication (not on all pages)
  # and the login page is not visible at start.
  # This reactiveVal ensures that we run authentication only once.
  authenticated <- shiny::reactiveVal(FALSE)
  # open the page if not already (in case of local authentication)
  shiny::observeEvent({
    shiny::req(!is.null(trigger))
    trigger()
  }, {
    if (!authenticated()) {
      if (!input[[modId]]) updateF7Login(id = modId)
    }
  }, once = TRUE)

  # toggle the login only if not authenticated
  shiny::observeEvent(input$login, {
    if (!authenticated()) {
      updateF7Login(
        id = modId,
        user = input$login_user,
        password = input$login_password
      )
      authenticated(TRUE)
    }
  }, ignoreInit = ignoreInit)

  # useful to export the user name outside the module
  return(
    list(
      user = shiny::reactive(input$login_user),
      password = shiny::reactive(input$login_password)
    )
  )

}


#' Toggle login page
#'
#' @param id \link{f7Login} unique id.
#' @param user Value of the user input.
#' @param password Value of the password input.
#' @param session Shiny session object.
#' @export
#' @rdname authentication
updateF7Login <- function(id, user = NULL, password = NULL, session = shiny::getDefaultReactiveDomain()) {
  message <- dropNulls(
    list(
      user = user,
      password = password
    )
  )
  session$sendInputMessage(id, message)
}

