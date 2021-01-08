#' Create a framework7 action sheet
#'
#' @param id Unique id. This gives the state of the action sheet. input$id is TRUE
#' when opened and inversely. Importantly, if the action sheet has never been opened,
#' input$id is NULL.
#' @param grid Whether to display buttons on a grid. Default to FALSE.
#' @param buttons list of buttons such as
#' \preformatted{buttons <- list(
#'   list(
#'     text = "Notification",
#'     icon = f7Icon("info"),
#'     color = NULL
#'   ),
#'   list(
#'     text = "Dialog",
#'     icon = f7Icon("lightbulb_fill"),
#'     color = NULL
#'   )
#'  )
#' }
#' The currently selected button may be accessed via input$<sheet_id>_button. The value is
#' numeric. When the action sheet is closed, input$<sheet_id>_button is NULL. This is useful
#' when you want to trigger events after a specific button click.
#' @param session Shiny session object.
#'
#' @export
#'
#' @importFrom shiny getDefaultReactiveDomain
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'    ui = f7Page(
#'      title = "Action sheet",
#'      f7SingleLayout(
#'        navbar = f7Navbar("Action sheet"),
#'        br(),
#'        f7Button(inputId = "go", label = "Show action sheet", color = "red")
#'      )
#'    ),
#'    server = function(input, output, session) {
#'
#'      observe({
#'        print(list(
#'          sheetOpen = input$action1,
#'          button = input$action1_button
#'        ))
#'      })
#'
#'      observeEvent(input$action1_button, {
#'        if (input$action1_button == 1) {
#'          f7Notif(
#'            text = "You clicked on the first button",
#'            icon = f7Icon("bolt_fill"),
#'            title = "Notification",
#'            titleRightText = "now"
#'          )
#'        } else if (input$action1_button == 2) {
#'          f7Dialog(
#'            inputId = "test",
#'            title = "Click me to launch a Toast!",
#'            type = "confirm",
#'            text = "You clicked on the second button"
#'          )
#'        }
#'      })
#'
#'      observeEvent(input$test, {
#'        f7Toast(text = paste("Alert input is:", input$test))
#'      })
#'
#'      observeEvent(input$go, {
#'        f7ActionSheet(
#'          grid = TRUE,
#'          id = "action1",
#'          buttons = list(
#'           list(
#'             text = "Notification",
#'             icon = f7Icon("info"),
#'             color = NULL
#'           ),
#'           list(
#'             text = "Dialog",
#'             icon = f7Icon("lightbulb_fill"),
#'             color = NULL
#'           )
#'          )
#'        )
#'      })
#'    }
#'  )
#'
#'  ### in shiny module
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  sheetModuleUI <- function(id) {
#'    ns <- NS(id)
#'    f7Button(inputId = ns("go"), label = "Show action sheet", color = "red")
#'  }
#'
#'  sheetModule <- function(input, output, session) {
#'
#'    ns <- session$ns
#'
#'    observe({
#'      print(list(
#'        sheetOpen = input$action1,
#'        button = input$action1_button
#'      ))
#'    })
#'
#'    observeEvent(input$action1_button, {
#'      if (input$action1_button == 1) {
#'        f7Notif(
#'          text = "You clicked on the first button",
#'          icon = f7Icon("bolt_fill"),
#'          title = "Notification",
#'          titleRightText = "now"
#'        )
#'      } else if (input$action1_button == 2) {
#'        f7Dialog(
#'          id = ns("test"),
#'          title = "Click me to launch a Toast!",
#'          type = "confirm",
#'          text = "You clicked on the second button",
#'        )
#'      }
#'    })
#'
#'    observeEvent(input$test, {
#'      f7Toast(text = paste("Alert input is:", input$test))
#'    })
#'
#'    observeEvent(input$go, {
#'      f7ActionSheet(
#'        grid = TRUE,
#'        id = ns("action1"),
#'        buttons = list(
#'          list(
#'            text = "Notification",
#'            icon = f7Icon("info"),
#'            color = NULL
#'          ),
#'          list(
#'            text = "Dialog",
#'            icon = f7Icon("lightbulb_fill"),
#'            color = NULL
#'          )
#'        )
#'      )
#'    })
#'  }
#'
#'  shinyApp(
#'    ui = f7Page(
#'      title = "Action sheet",
#'      f7SingleLayout(
#'        navbar = f7Navbar("Action sheet"),
#'        br(),
#'        sheetModuleUI(id = "sheet1")
#'      )
#'    ),
#'    server = function(input, output, session) {
#'      callModule(sheetModule, "sheet1")
#'    }
#'  )
#' }
f7ActionSheet <- function(id, buttons, grid = FALSE, session = shiny::getDefaultReactiveDomain()) {

  buttons <- lapply(buttons, dropNulls)

  for(i in seq_along(buttons)) {
    temp <- as.character(buttons[[i]]$icon)
    buttons[[i]]$icon <- temp
  }

  message <- list(
    buttons = jsonlite::toJSON(buttons, pretty = TRUE, auto_unbox = TRUE),
    grid = tolower(grid),
    id = id
  )

  session$sendCustomMessage(type = "action-sheet", message)
}
