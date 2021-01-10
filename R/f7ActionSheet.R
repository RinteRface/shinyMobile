#' Framework7 action sheet
#'
#' \link{f7ActionSheet} creates an action sheet may contain multiple buttons. Each of them triggers
#' an action on the server side. It may be updated later by \link{updateF7ActionSheet}.
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
#' @param ... Other options. See \url{https://v5.framework7.io/docs/action-sheet.html#action-sheet-parameters}.
#' @param session Shiny session object.
#'
#' @rdname actionsheet
#'
#' @export
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
#'            id = "test",
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
f7ActionSheet <- function(id, buttons, grid = FALSE, ..., session = shiny::getDefaultReactiveDomain()) {

  buttons <- lapply(buttons, dropNulls)

  for(i in seq_along(buttons)) {
    temp <- as.character(buttons[[i]]$icon)
    buttons[[i]]$icon <- temp
  }

  message <- list(
    buttons = buttons,
    grid = grid,
    id = id,
    ...
  )

  sendCustomMessage("action-sheet", message, session)
}



#' Update Framework7 action sheet
#'
#' \link{updateF7ActionSheet} updates a \link{f7ActionSheet} from the server.
#'
#' @param id Unique id. This gives the state of the action sheet. input$id is TRUE
#' when opened and inversely. Importantly, if the action sheet has never been opened,
#' input$id is NULL.
#' @param options Other options. See \url{https://v5.framework7.io/docs/action-sheet.html#action-sheet-parameters}.
#' @param session Shiny session object.
#' @rdname actionsheet
#' @export
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'    ui = f7Page(
#'      title = "Update Action sheet",
#'      f7SingleLayout(
#'        navbar = f7Navbar("Update Action sheet"),
#'        br(),
#'        f7Segment(
#'          f7Button(inputId = "go", label = "Show action sheet", color = "green"),
#'          f7Button(inputId = "update", label = "Update action sheet", color = "red")
#'        )
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
#'      observeEvent(input$go, {
#'        f7ActionSheet(
#'          grid = TRUE,
#'          id = "action1",
#'          buttons = list(
#'            list(
#'              text = "Notification",
#'              icon = f7Icon("info"),
#'              color = NULL
#'            ),
#'            list(
#'              text = "Dialog",
#'              icon = f7Icon("lightbulb_fill"),
#'              color = NULL
#'            )
#'          )
#'        )
#'      })
#'
#'      observeEvent(input$update, {
#'        updateF7ActionSheet(
#'          id = "action1",
#'          options = list(
#'            grid = TRUE,
#'            buttons = list(
#'              list(
#'                text = "Plop",
#'                icon = f7Icon("info"),
#'                color = "orange"
#'              )
#'            )
#'          )
#'        )
#'      })
#'    }
#'  )
#' }
updateF7ActionSheet <- function(id, options, session = shiny::getDefaultReactiveDomain()) {

  # Convert shiny tags to character
  if (length(options$buttons) > 0) {
    for(i in seq_along(options$buttons)) {
      temp <- as.character(options$buttons[[i]]$icon)
      options$buttons[[i]]$icon <- temp
    }
  }

  options$id <- id

  sendCustomMessage("update-action-sheet", options, session)
}
