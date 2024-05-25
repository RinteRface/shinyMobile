#' Framework7 toast
#'
#' \code{f7Toast} creates a small toast notification from the server side.
#'
#' @param text Toast content.
#' @param position Toast position \code{c("bottom", "top", "center")}.
#' @param closeButton Whether to close the toast with a button.
#' TRUE by default.
#' @param closeButtonText Close button text.
#' @param closeButtonColor Close button color.
#' @param closeTimeout Time before toast closes.
#' @param icon Optional. Expect \link{f7Icon}. Warning:
#' Adding icon will hide the close button.
#' @param ... Other options. See \url{https://framework7.io/docs/toast.html#toast-parameters}.
#' @param session Shiny session.
#'
#' @example inst/examples/toast/app.R
#'
#' @export
f7Toast <- function(text, position = c("bottom", "top", "center"),
                    closeButton = TRUE, closeButtonText = "close",
                    closeButtonColor = "red", closeTimeout = 3000, icon = NULL,
                    ..., session = shiny::getDefaultReactiveDomain()) {

  if(!is.null(icon)) icon <- as.character(icon)

  position <- match.arg(position)

  message <- dropNulls(
    list(
      text = text,
      position = position,
      closeTimeout = closeTimeout,
      icon = icon,
      closeButton = closeButton,
      closeButtonText = closeButtonText,
      closeButtonColor = closeButtonColor,
      ...
    )
  )
  # see components/init.js
  session$sendCustomMessage(
    type = "toast",
    message = jsonlite::toJSON(
      message,
      auto_unbox = TRUE,
      json_verbatim = TRUE
    )
  )
}
