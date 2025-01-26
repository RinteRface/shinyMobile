#' Framework7 dialog window
#'
#' \code{f7Dialog} generates a modal window.
#'
#' @param id Input associated to the alert. Works when type is one of
#' "confirm", "prompt" or "login".
#' @param title Dialog title
#' @param text Dialog text.
#' @param type Dialog type: \code{c("alert", "confirm", "prompt", "login")}.
#' @param session shiny session.
#'
#' @export
#'
#' @example inst/examples/dialog/app.R
f7Dialog <- function(
  id = NULL,
  title = NULL,
  text,
  type = c("alert", "confirm", "prompt", "login"),
  session = shiny::getDefaultReactiveDomain()
) {
  type <- match.arg(type)

  if (is.null(id) && type %in% c("confirm", "prompt", "login")) {
    stop("Missing id.")
  }

  # force to render shiny.tag and convert it to character
  # since text does not accept anything else
  text <- if (any(class(text) %in% c("shiny.tag", "shiny.tag.list"))) {
    as.character(force(text))
  } else {
    text
  }

  message <- dropNulls(
    list(
      id = id,
      title = title,
      text = text,
      type = type
    )
  )
  # see my-app.js function
  session$sendCustomMessage(
    type = "dialog",
    message = jsonlite::toJSON(
      message,
      auto_unbox = TRUE,
      json_verbatim = TRUE
    )
  )
}
