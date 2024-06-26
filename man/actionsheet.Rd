% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/f7ActionSheet.R
\name{f7ActionSheet}
\alias{f7ActionSheet}
\alias{updateF7ActionSheet}
\title{Framework7 action sheet}
\usage{
f7ActionSheet(
  id,
  buttons,
  grid = FALSE,
  ...,
  session = shiny::getDefaultReactiveDomain()
)

updateF7ActionSheet(id, options, session = shiny::getDefaultReactiveDomain())
}
\arguments{
\item{id}{Unique id. This gives the state of the action sheet. input$id is TRUE
when opened and inversely. Importantly, if the action sheet has never been opened,
input$id is NULL.}

\item{buttons}{list of buttons such as
\preformatted{buttons <- list(
  list(
    text = "Notification",
    icon = f7Icon("info"),
    color = NULL
  ),
  list(
    text = "Dialog",
    icon = f7Icon("lightbulb_fill"),
    color = NULL
  )
 )
}
The currently selected button may be accessed via input$<sheet_id>_button. The value is
numeric. When the action sheet is closed, input$<sheet_id>_button is NULL. This is useful
when you want to trigger events after a specific button click.}

\item{grid}{Whether to display buttons on a grid. Default to FALSE.}

\item{...}{Other options. See \url{https://framework7.io/docs/action-sheet#action-sheet-parameters}.}

\item{session}{Shiny session object.}

\item{options}{Other options. See \url{https://framework7.io/docs/action-sheet#action-sheet-parameters}.}
}
\description{
\code{f7ActionSheet} creates an action sheet may contain multiple buttons. Each of them triggers
an action on the server side. It may be updated later by \link{updateF7ActionSheet}.

\code{updateF7ActionSheet} updates an \link{f7ActionSheet} from the server.
}
\examples{
library(shiny)
library(shinyMobile)

sheetModuleUI <- function(id) {
  ns <- NS(id)
  f7Segment(
    f7Button(inputId = ns("go"), label = "Show action sheet", color = "green"),
    f7Button(inputId = ns("update"), label = "Update action sheet", color = "red")
  )
}

sheetModule <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns

      observeEvent(input$action1_button, {
        if (input$action1_button == 1) {
          f7Notif(
            text = "You clicked on the first button",
            icon = f7Icon("bolt_fill"),
            title = "Notification",
            titleRightText = "now"
          )
        } else if (input$action1_button == 2) {
          f7Dialog(
            id = ns("test"),
            title = "Click me to launch a Toast!",
            type = "confirm",
            text = "You clicked on the second button",
          )
        }
      })

      observeEvent(input$test, {
        f7Toast(text = paste("Alert input is:", input$test))
      })

      observeEvent(input$go, {
        f7ActionSheet(
          grid = TRUE,
          id = ns("action1"),
          buttons = list(
            list(
              text = "Notification",
              icon = f7Icon("info"),
              color = NULL
            ),
            list(
              text = "Dialog",
              icon = f7Icon("lightbulb_fill"),
              color = NULL
            )
          )
        )
      })

      observeEvent(input$update, {
        updateF7ActionSheet(
          id = "action1",
          options = list(
            grid = TRUE,
            buttons = list(
              list(
                text = "Plop",
                icon = f7Icon("info"),
                color = "orange"
              )
            )
          )
        )
      })
    }
  )
}

app <- shinyApp(
  ui = f7Page(
    title = "Action sheet",
    f7SingleLayout(
      navbar = f7Navbar("Action sheet"),
      br(),
      sheetModuleUI(id = "sheet1")
    )
  ),
  server = function(input, output, session) {
    sheetModule("sheet1")
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
}
