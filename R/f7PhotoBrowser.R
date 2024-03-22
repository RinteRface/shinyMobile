#' Framework7 photo browser
#'
#' A nice photo browser.
#'
#' @param photos List of photos
#' @param theme Browser theme: choose either light or dark.
#' @param type Browser type: choose among \code{c("popup", "standalone", "page")}.
#' @param ... Other options.
#' @param session Shiny session object.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   shinyApp(
#'     ui = f7Page(
#'       title = "f7PhotoBrowser",
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "f7PhotoBrowser"),
#'         f7Button(inputId = "togglePhoto", "Open photo")
#'       )
#'     ),
#'     server = function(input, output, session) {
#'       observeEvent(input$togglePhoto, {
#'         f7PhotoBrowser(
#'           id = "photobrowser1",
#'           theme = "dark",
#'           type = "standalone",
#'           photos = c(
#'             "https://cdn.framework7.io/placeholder/sports-1024x1024-1.jpg",
#'             "https://cdn.framework7.io/placeholder/sports-1024x1024-2.jpg",
#'             "https://cdn.framework7.io/placeholder/sports-1024x1024-3.jpg"
#'           )
#'         )
#'       })
#'     }
#'   )
#' }
f7PhotoBrowser <- function(photos, theme = c("light", "dark"),
                           type = c("popup", "standalone", "page"), ..., session = shiny::getDefaultReactiveDomain()) {
  theme <- match.arg(theme)
  type <- match.arg(type)
  pageBackLinkText <- if (type == "page") "back" else NULL


  options <- dropNulls(
    list(
      theme = theme,
      photos = I(photos),
      pageBackLinkText = pageBackLinkText,
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
