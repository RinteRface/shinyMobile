#' Framework7 preloader
#'
#' \code{showF7Preloader} shows a preloader.
#' When \code{target} is NULL, the overlay applies
#' to the entire view, preventing to perform any actions.
#' When type is not NULL, \code{target} is ignored.
#'
#' @param target Element where preloader overlay will be added.
#' @param color Preloader color.
#' @param type Leave NULL to use the default preloader
#' or use either "dialog" or "progress".
#' @param id When type isn't NULL, an id is required
#' to be able to use \link{updateF7Preloader}.
#' @param session Shiny session object.
#' @export
#' @rdname preloader
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   # preloader in container
#'   shinyApp(
#'     ui = f7Page(
#'       title = "Preloader in container",
#'       f7SingleLayout(
#'         navbar = f7Navbar(
#'           title = "Preloader in container"
#'         ),
#'         # main content
#'         f7Card(
#'           title = "Card header",
#'           f7Slider("obs", "Number of observations", 0, 1000, 500),
#'           plotOutput("distPlot")
#'         ),
#'         f7Card("This is a simple card with plain text,
#'        but cards can also contain their own header,
#'        footer, list view, image, or any other element.")
#'       )
#'     ),
#'     server = function(input, output, session) {
#'       long_task <- eventReactive(input$obs, {
#'         Sys.sleep(4)
#'         input$obs
#'       })
#'
#'       observeEvent(input$obs, {
#'         showF7Preloader(color = "red", type = "dialog", id = "loader")
#'         updateF7Preloader(
#'           id = "loader",
#'           title = "Computing ...",
#'           text = "This may take some time"
#'         )
#'       })
#'
#'       output$distPlot <- renderPlot({
#'         dist <- rnorm(long_task())
#'         hist(dist)
#'       })
#'
#'       observeEvent(long_task(), {
#'         hideF7Preloader(id = "loader")
#'       })
#'     }
#'   )
#' }
showF7Preloader <- function(target = NULL, color = NULL,
                            type = NULL, id = NULL,
                            session = shiny::getDefaultReactiveDomain()) {
  if (is.null(id) && !is.null(type)) {
    stop("When type is not NULL, id must have a value.")
  }
  message <- dropNulls(
    list(
      el = target,
      color = color,
      type = type,
      id = session$ns(id)
    )
  )
  session$sendCustomMessage("show-preloader", message)
}

#' Framework7 preloader
#'
#' \code{updateF7Preloader} updates a preloader.
#'
#' @param title Dialog title.
#' @param text Dialog text.
#' @param progress Progress bar content.
#' @export
#' @rdname preloader
updateF7Preloader <- function(
    id, title = NULL,
    text = NULL, progress = NULL, session = shiny::getDefaultReactiveDomain()) {
  message <- dropNulls(
    list(
      id = session$ns(id),
      title = title,
      text = text,
      progress = progress
    )
  )
  session$sendCustomMessage("update-preloader", message)
}

#' Framework7 preloader
#'
#' \code{hideF7Preloader} hides a preloader.
#'
#' @rdname preloader
#' @export
hideF7Preloader <- function(target = NULL, id = NULL,
                            session = shiny::getDefaultReactiveDomain()) {
  message <- dropNulls(list(el = target, id = id))
  session$sendCustomMessage("hide-preloader", message)
}
