#' Framework7 action sheet
#'
#' \code{f7ActionSheet} creates an action sheet may contain multiple buttons. Each of them triggers
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
#' @example inst/examples/actionsheet/app.R
f7ActionSheet <- function(id, buttons, grid = FALSE, ..., session = shiny::getDefaultReactiveDomain()) {
  buttons <- lapply(buttons, dropNulls)

  for (i in seq_along(buttons)) {
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
#' \code{updateF7ActionSheet} updates an \link{f7ActionSheet} from the server.
#'
#' @param id Unique id. This gives the state of the action sheet. input$id is TRUE
#' when opened and inversely. Importantly, if the action sheet has never been opened,
#' input$id is NULL.
#' @param options Other options. See \url{https://v5.framework7.io/docs/action-sheet.html#action-sheet-parameters}.
#' @param session Shiny session object.
#' @rdname actionsheet
#' @export
updateF7ActionSheet <- function(id, options, session = shiny::getDefaultReactiveDomain()) {
  # Convert shiny tags to character
  if (length(options$buttons) > 0) {
    for (i in seq_along(options$buttons)) {
      temp <- as.character(options$buttons[[i]]$icon)
      options$buttons[[i]]$icon <- temp
    }
  }

  options$id <- session$ns(id)

  sendCustomMessage("update-action-sheet", options, session)
}
