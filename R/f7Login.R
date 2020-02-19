#' Provide a template for authentication
#'
#' This function does not provide the backend features. You would
#' need to store credentials in a database for instance.
#'
#' @note There is an input associated with the login status, namely input$login.
#' It is linked to an action button, which is 0 when the application starts. As soon
#' as the button is pressed, its value is incremented which might fire a
#' \link[shiny]{observeEvent} listening to it (See example below). Importantly,
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
#'  shiny::shinyApp(
#'    ui = f7Page(
#'      title = "My app",
#'      f7SingleLayout(
#'        navbar = f7Navbar(
#'          title = "Login Example",
#'          hairline = FALSE,
#'          shadow = TRUE
#'        ),
#'        toolbar = f7Toolbar(
#'          position = "bottom",
#'          f7Link(label = "Link 1", src = "https://www.google.com"),
#'          f7Link(label = "Link 2", src = "https://www.google.com", external = TRUE)
#'        ),
#'        f7Login(id = "loginPage", title = "Welcome"),
#'        # main content
#'        f7BlockTitle(
#'          title = HTML(paste0("Welcome ", textOutput("userName"))),
#'          size = "large"
#'        ) %>% f7Align("center")
#'      )
#'    ),
#'    server = function(input, output, session) {
#'
#'      f7LoginServer(input, output, session)
#'
#'      output$userName <- renderText({
#'        req(input$login > 0)
#'        input$login_user
#'      })
#'    }
#'  )
#'
#'  # section specific authentication
#'  library(shiny)
#'  library(shinyMobile)
#'  shiny::shinyApp(
#'    ui = f7Page(
#'      title = "My app",
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
#'              title = HTML(paste0("Welcome ", textOutput("userName"))),
#'              size = "large"
#'            ) %>% f7Align("center")
#'          )
#'        ),
#'        f7Login(id = "loginPage", title = "Welcome", startOpen = FALSE)
#'      )
#'    ),
#'    server = function(input, output, session) {
#'
#'      # Authorization on the second tab
#'      # only run once to open the login page
#'      observeEvent(input$tabs, {
#'        if (input$tabs == "Restricted") {
#'          updateF7Login(id = "loginPage")
#'        }
#'      }, once = TRUE)
#'
#'      # do not run first since the login page is not yet visible
#'      f7LoginServer(input, output, session, ignoreInit = TRUE)
#'
#'      output$userName <- renderText({
#'        req(input$login > 0)
#'        input$login_user
#'      })
#'    }
#'  )
#' }
f7Login <- function(..., id, title, label = "Sign In", footer = NULL,
                    startOpen = TRUE) {

  submitBttn <- f7Button(inputId = "login", label = label)
  submitBttn[[2]]$attribs$class <- "item-link list-button f7-action-button"
  submitBttn[[2]]$name <- "a"

  shiny::tagList(
    f7InputsDeps(),
    shiny::tags$div(
      id = id,
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
                    inputId = "login_user",
                    label = "",
                    placeholder = "Your name here"
                  ),
                  f7Password(
                    inputId = "login_password",
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
#'
#' @export
#' @rdname authentication
f7LoginServer <- function(input, output, session, ignoreInit = FALSE) {

  # this is needed if we have local authentication (not on all pages)
  # and the login page is not visible at start.
  # This reactiveVal ensures that we run authentication only once.
  authenticated <- shiny::reactiveVal(FALSE)

  # toggle the login only if not authenticated
  shiny::observeEvent(input$login, {
    if (!authenticated()) {
      updateF7Login(
        id = "loginPage",
        user = input$login_user,
        password = input$login_password
      )
      authenticated(TRUE)
    }
  }, ignoreInit = ignoreInit)
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

