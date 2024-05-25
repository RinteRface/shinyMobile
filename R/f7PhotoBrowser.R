#' Framework7 photo browser
#'
#' A nice photo browser.
#'
#' @param photos List of photos
#' @param theme Browser theme: choose either light or dark.
#' @param type Browser type: choose among \code{c("popup", "standalone", "page")}.
#' @param ... Other options to pass to the photo browser. See
#' \url{https://framework7.io/docs/photo-browser#photo-browser-parameters} for more details.
#' @param id Unique id. Useful to
#' leverage \link{updateF7Entity} on the server.
#' @param session Shiny session object.
#'
#' @example inst/examples/photobrowser/app.R
#'
#' @export
f7PhotoBrowser <- function(photos, theme = c("light", "dark"),
                           type = c("popup", "standalone", "page"), ...,
                           id = NULL, session = shiny::getDefaultReactiveDomain()) {
  theme <- match.arg(theme)
  type <- match.arg(type)

  options <- dropNulls(
    list(
      id = id,
      theme = theme,
      photos = I(photos),
      type = type,
      ...
    )
  )

  session$sendCustomMessage(
    "photoBrowser",
    message = jsonlite::toJSON(
      x = options,
      auto_unbox = TRUE,
      json_verbatim = TRUE
    )
  )
}
