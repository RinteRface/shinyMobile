#' Framework7 preloader
#'
#' \code{showF7Preloader} shows a preloader.
#'
#' @param target Element where preloader overlay will be added.
#' @param color Preloader color.
#' @param session Shiny session object.
#' @export
#' @rdname preloader
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   # basic preloader with red color
#'   shinyApp(
#'     ui = f7Page(
#'       title = "Preloader",
#'       f7SingleLayout(
#'         navbar = f7Navbar(
#'           title = "Preloader"
#'         ),
#'         # main content
#'         f7Button("showLoader", "Show loader"),
#'         f7Card(
#'           title = "Card header",
#'           f7Slider("obs", "Number of observations", 0, 1000, 500),
#'           plotOutput("distPlot")
#'         )
#'       )
#'     ),
#'     server = function(input, output, session) {
#'       output$distPlot <- renderPlot({
#'         dist <- rnorm(input$obs)
#'         hist(dist)
#'       })
#'
#'       observeEvent(input$showLoader, {
#'         showF7Preloader(color = "red")
#'         Sys.sleep(2)
#'         f7HidePreloader()
#'       })
#'     }
#'   )
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
#'       output$distPlot <- renderPlot({
#'         dist <- rnorm(input$obs)
#'         hist(dist)
#'       })
#'
#'       observeEvent(input$obs, {
#'         showF7Preloader(target = "#distPlot", color = "red")
#'         Sys.sleep(2)
#'         hideF7Preloader()
#'       })
#'     }
#'   )
#' }
showF7Preloader <- function(target = NULL, color = NULL,
                            session = shiny::getDefaultReactiveDomain()) {
  message <- dropNulls(list(el = target, color = color))
  session$sendCustomMessage("show-preloader", message)
}

#' Framework7 preloader
#'
#' \code{hideF7Preloader} hides a preloader.
#'
#' @rdname preloader
#' @export
hideF7Preloader <- function(target = NULL,
                            session = shiny::getDefaultReactiveDomain()) {
  message <- dropNulls(list(el = target))
  session$sendCustomMessage("hide-preloader", message)
}
