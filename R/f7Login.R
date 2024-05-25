#' Framework7 login screen
#'
#' Provide a UI template for authentication
#'
#' @note There is an input associated with the login status, namely `input$login`.
#' It is linked to an action button, `input$submit`, which is 0 when the application starts. As soon
#' as the button is pressed, its value is incremented which may be used to call 
#' \link{updateF7Login}. `input$user` and `input$password` contains values passed 
#' by the user in these respective fields and can be forwarded to \link{updateF7Login}.
#' `input$cancel` is increment whenever the login is closed when cancellable. You can access
#' the value and trigger other actions on the server, as shown in \link{f7LoginServer}.
#'
#' @param ... Slot for inputs like password, text, ...
#' @param id Login unique id.
#' @param title Login page title.
#' @param label Login confirm button label.
#' @param footer Optional footer.
#' @param startOpen Whether to open the login page at start. Default to TRUE. There
#' are some cases where it is interesting to set up to FALSE, for instance when you want
#' to have authentication only in a specific tab of your app (See example 2).
#' @param cancellable Whether to show a cancel button to close the login modal. Default
#' to FALSE.
#'
#' @export
#' @rdname authentication
#' @importFrom jsonlite toJSON
#' @example inst/examples/login/app.R
f7Login <- function(..., id, title, label = "Sign In", footer = NULL, startOpen = TRUE,
cancellable = FALSE) {

  ns <- shiny::NS(id)

  submitBttn <- f7Button(inputId = ns("submit"), label = label, fill = FALSE)

  btnUI <- submitBttn

  if (cancellable) {
    cancelButton <- f7Button(ns("cancel"), label = "Cancel", fill = FALSE)
    btnUI <- f7Grid(
      cols = 2,
      cancelButton,
      submitBttn
    )
  }
  
  items <- list(...)
  if (length(items) > 0) items <- change_id(items, ns)

  shiny::tags$div(
    id = sprintf("%s-login", id),
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
              items
            ),
            btnUI,
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
#' \code{f7LoginServer} is demonstration module to test the
#' \link{f7Login} page. We do not recommend using it in production,
#' since there is absolutely no security over the passed credentials.
#' On the JS side, the login is closed as soon as a user and password
#' are provided but no validity checks are made.
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
          if (!authenticated()) updateF7Login()
        }
      )

      # toggle the login only if not authenticated
      shiny::observeEvent(
        input$submit,
        {
          if (!authenticated()) {
            updateF7Login(
              user = input$user,
              password = input$password
            )
            shiny::req(nchar(input$user) > 0, nchar(input$password) > 0)
            authenticated(TRUE)
          }
        },
        ignoreInit = ignoreInit
      )
      
      # Close on cancel
      shiny::observeEvent(input$cancel, {
        updateF7Login(cancel = TRUE)
      })

      # useful to export the user name outside the module
      return(
        list(
          status = shiny::reactive(input$login),
          user = shiny::reactive(input$user),
          password = shiny::reactive(input$password),
          authenticated = shiny::reactive(authenticated()),
          cancelled = shiny::reactive(input$cancel)
        )
      )
    }
  )
}

#' Activates Framework7 login.
#'
#' \code{updateF7Login} toggles a login page.
#' 
#' @param id `r lifecycle::badge("deprecated")`.
#' @param user Value of the user input.
#' @param password Value of the password input.
#' @param cancel Whether to close the login. Default to FALSE.
#' @param session Shiny session object.
#' @export
#' @rdname authentication
updateF7Login <- function(id = deprecated(), user = NULL, password = NULL, cancel = FALSE, session = shiny::getDefaultReactiveDomain()) {
  
  if (lifecycle::is_present(id)) {
    lifecycle::deprecate_warn(
      when = "2.0.0",
      what = "updateF7Login(id)",
      details = "id has been
      deprecated will be removed from shinyMobile
      in the next release."
    )
  }
  
  message <- dropNulls(
    list(
      user = user,
      password = password,
      cancel = cancel
    )
  )
  session$sendInputMessage("login", message)
}
