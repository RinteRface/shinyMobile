#' Provide a template for authentication
#'
#' This function does not provide the backend features. You would
#' need to store credentials in a database for instance.
#'
#' @param ... Slot for inputs like password, text, ...
#' @param id Login unique id.
#' @param title Login page title.
#' @param label Login confirm button label.
#' @param footer Optional footer.
#' @export
#' @examples
#' if (interactive()) {
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
#'        f7Login(
#'          id = "loginPage",
#'          title = "Welcome",
#'          f7Text(
#'            inputId = "caption",
#'            label = "Caption",
#'            value = "Data Summary",
#'            placeholder = "Your text here"
#'          )
#'        ),
#'        # main content
#'        f7BlockTitle(
#'          title = HTML(paste0("Welcome ", textOutput("userName"))),
#'          size = "large"
#'        ) %>% f7Align("center")
#'      )
#'    ),
#'    server = function(input, output, session) {
#'
#'      observeEvent(input$login, {
#'        updateF7Login(id = "loginPage")
#'      })
#'
#'      output$userName <- renderText({
#'        req(input$login > 0)
#'        input$caption
#'      })
#'    }
#'  )
#' }
f7Login <- function(..., id, title, label = "Sign In", footer = NULL) {

  shiny::tagList(
    f7InputsDeps(),
    shiny::tags$div(
      id = id,
      class = "login-screen",
      shiny::tags$div(
        class = "view",
        shiny::tags$div(
          class = "page",
          shiny::tags$div(
            class = "page-content login-screen-content",
            shiny::tags$div(class = "login-screen-title", title),
            shiny::tags$form(
              shiny::tags$div(class = "list", shiny::tags$ul(...)),
              shiny::tags$div(
                class = "list",
                shiny::tags$ul(shiny::tags$li(f7Button(inputId = "login", label = label))),
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


#' Toggle login page
#'
#' @param id \link{f7Login} unique id.
#' @param session Shiny session object.
#' @export
updateF7Login <- function(id, session = shiny::getDefaultReactiveDomain()) {
  session$sendInputMessage(id, message = NULL)
}

