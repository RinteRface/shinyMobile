#' Framework7 login screen
#'
#' Provide a template for authentication
#'
#' This function does not provide any security check.
#'
#' @note There is an input associated with the login status, namely input$login.
#' It is linked to an action button, which is 0 when the application starts. As soon
#' as the button is pressed, its value is incremented which might fire a
#' \code{observeEvent} listening to it (See example below). Importantly,
#' the login page is closed only if the text and password inputs are filled. The
#' \code{f7LoginServer} contains a piece of server logic that does this work for you.
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
#' @example inst/examples/login/app.R
f7Login <- function(..., id, title, label = "Sign In", footer = NULL,
                    startOpen = TRUE) {
  ns <- shiny::NS(id)

  submitBttn <- f7Button(inputId = ns("submit"), label = label)
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
            f7List(
              f7Text(
                inputId = ns("user"),
                label = "Username",
                placeholder = "Your name here"
              ),
              f7Password(
                inputId = ns("password"),
                label = "Password",
                placeholder = "Your password here"
              ),
              ...
            ),
            f7List(
              submitBttn
            ),
            if (!is.null(footer)) {
              shiny::tags$div(class = "block-footer", footer)
            }
          )
        )
      )
    )
  )
}

#' Framework7 login server module
#'
#' \code{f7LoginServer} is a useful server elements to fine tune the
#' \link{f7Login} page.
#'
#' @param ignoreInit If TRUE, then, when this observeEvent is first
#' created/initialized, ignore the handlerExpr (the second argument),
#' whether it is otherwise supposed to run or not. The default is FALSE.
#' @param trigger Reactive trigger to toggle the login page state. Useful, when
#' one wants to set up local authentication (for a specific section). See example 2.
#'
#' @export
#' @rdname authentication
f7LoginServer <- function(id, ignoreInit = FALSE, trigger = NULL) {
  shiny::moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns
      # module id
      modId <- strsplit(ns(""), "-")[[1]][1]

      # this is needed if we have local authentication (not on all pages)
      # and the login page is not visible at start.
      # This reactiveVal ensures that we run authentication only once.
      authenticated <- shiny::reactiveVal(FALSE)
      # open the page if not already (in case of local authentication)
      shiny::observeEvent(
        {
          shiny::req(!is.null(trigger))
          trigger()
        },
        {
          if (!authenticated()) {
            if (!input[[modId]]) updateF7Login(id = modId)
          }
        },
        once = TRUE
      )

      # toggle the login only if not authenticated
      shiny::observeEvent(input$submit,
                          {
                            if (!authenticated()) {
                              updateF7Login(
                                id = modId,
                                user = input$user,
                                password = input$password
                              )
                              authenticated(TRUE)
                            }
                          },
                          ignoreInit = ignoreInit
      )

      # useful to export the user name outside the module
      return(
        list(
          user = shiny::reactive(input$user),
          password = shiny::reactive(input$password)
        )
      )
    }
  )
}

#' Activates Framework7 login.
#'
#' \code{updateF7Login} toggles a login page.
#'
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
