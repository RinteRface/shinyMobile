#' Create a Framework 7 Treeview layout
#'
#' @param ... Slot for \link{f7TreeviewGroup} or \link{f7TreeviewItem}.
#' @param id Treeview unique id.
#' @param selectable Make treeview items selectable. Default is `FALSE`.
#' @param withCheckbox Add a checkbox to each item. Default is `FALSE`.
#'
#' @example inst/examples/treeview/app.R
#'
#' @export

f7Treeview <- function(..., id, selectable = FALSE, withCheckbox = FALSE) {

  config <- dropNulls(
    list(
      selectable = selectable,
      withCheckbox = withCheckbox
    )
  )

  shiny::tags$div(
    id = id,
    shiny::tags$script(
      type = "application/json",
      `data-for` = id,
      jsonlite::toJSON(
        x = config,
        auto_unbox = TRUE,
        json_verbatim = TRUE
      )
    ),
    class = "treeview",
    ...
  )
}





#' Create a Framework 7 Treeview item
#'
#' @param label Item label
#' @param icon Expect \link{f7Icon}.
#' @param href Item external link.
#'
#' @example inst/examples/treeview/app.R
#'
#' @export
f7TreeviewItem <- function(label, icon = NULL, href = NULL) {

  itemContent <-
    shiny::tags$div(
      class = "treeview-item-content",
      if (!is.null(icon)) icon,
      shiny::tags$div(
        class = "treeview-item-label",
        label
      )
    )

  itemContentWrapper <- if (is.null(href)) {
    shiny::tags$div(
      class = "treeview-item-root",
      itemContent
    )
  } else {
    shiny::tags$a(
      class = "treeview-item-root",
      href = href,
      target = "_blank",
      itemContent
    )
  }

  shiny::tags$div(
    class = "treeview-item",
    itemContentWrapper
  )
}





#' Create a Framework 7 group for treeview items
#'
#' @param ... slot for \link{f7TreeviewItem}.
#' @param title Group title.
#' @param icon Expect \link{f7Icon}.
#' @param toggleButton Whether or not to display a toggle button. Could be set to `FALSE` if `itemToggle` is `TRUE`.
#' @param itemToggle In addition to (or instead of) a toggle button, the whole group can work like a toggle.
#'  By default this behaviour is disabled.
#'
#'  @example inst/examples/treeview/app.R
#'
#' @export
f7TreeviewGroup <- function(..., title, icon, toggleButton = TRUE, itemToggle = FALSE) {

  rootClass <- "treeview-item-root"
  if (itemToggle) {
    rootClass <-paste0(rootClass, " treeview-item-toggle")
  }

  tagList(
    shiny::tags$div(
      class = "treeview-item",
      shiny::tags$div(
        class = rootClass,
        if (toggleButton) shiny::tags$div(class = "treeview-toggle"),
        shiny::tags$div(
          class = "treeview-item-content",
          if (!is.null(icon)) icon,
          shiny::tags$div(
            class = "treeview-item-label",
            title
          )
        )
      ),
      shiny::tags$div(
        class = "treeview-item-children",
        ...
      )
    )
  )
}
