#' Create a Framework 7 Treeview layout
#'
#' @param ... Slot for \link{f7TreeviewItem}.
#'
#' @example inst/examples/treeview/app.R
#'
#' @export

f7Treeview <- function(...) {

  shiny::tags$div(
    class = "treeview",
    ...
  )
}





#' Create a Framework 7 Treeview item
#'
#' @param label Item label
#' @param icon Expect \link{f7Icon}.
#' @param href Item external link.
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





#' Create a Framework 7 group Treeview items
#'
#' @param ... slot for \link{f7TreeviewItem}.
#' @param title Group title.
#' @param icon Expect \link{f7Icon}.
#' @export
f7TreeviewGroup <- function(..., title, icon) {
  tagList(
    shiny::tags$div(
      class = "treeview-item",
      shiny::tags$div(
        class = "treeview-item-root",
        shiny::tags$div(
          class = "treeview-toggle"
        ),
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
