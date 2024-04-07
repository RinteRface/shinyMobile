#' Title
#'
#' @param ...
#' @param id
#' @param title
#' @param backdrop
#' @param closeByBackdropClick
#' @param closeOnEscape
#' @param animate
#' @param swipeToClose
#' @param fullsize
#' @param closeButton
#' @param session
#'
#' @return
#' @export
#'
#' @examples
f7Popup2 <- function(..., id, title = NULL,
                     backdrop = TRUE,
                     closeByBackdropClick = TRUE,
                     closeOnEscape = FALSE,
                     animate = TRUE,
                     swipeToClose = FALSE,
                     fullsize = FALSE,
                     closeButton = TRUE,
                     session = shiny::getDefaultReactiveDomain()) {

  message <- dropNulls(
    list(
      id = session$ns(id),
      backdrop = backdrop,
      closeByBackdropClick = closeByBackdropClick,
      closeOnEscape = closeOnEscape,
      animate = animate,
      swipeToClose = swipeToClose
    )
  )

  content <- shiny::tags$div(
    class = "block",
    if (!is.null(title)) shiny::tags$div(class = "block-title", title),
    ...
  )

  if (closeButton) {
    content <- htmltools::tagAppendChild(
      content,
      shiny::tags$a(
        class = "link popup-close",
        style = "position: absolute; top: -15px; left: 10px;",
        href = "#",
        #f7Icon("multiply")
        f7Icon("arrow_left")
      )
    )
  }

  popup_tag <- shiny::tags$div(
    class = paste0("popup", if (fullsize) "popup-tablet-fullscreen"),
    content
  )

  message$content <- as.character(popup_tag)

  # see my-app.js function
  session$sendCustomMessage(
    type = "popup",
    message = jsonlite::toJSON(
      message,
      auto_unbox = TRUE,
      json_verbatim = TRUE
    )
  )
}
