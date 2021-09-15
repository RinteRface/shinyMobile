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
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  # basic preloader with red color
#'  shinyApp(
#'   ui = f7Page(
#'     title = "Preloader",
#'     f7SingleLayout(
#'       navbar = f7Navbar(
#'         title = "Preloader",
#'         hairline = FALSE,
#'         shadow = TRUE
#'       ),
#'       # main content
#'       f7Button("showLoader", "Show loader"),
#'       f7Shadow(
#'         intensity = 10,
#'         hover = TRUE,
#'         f7Card(
#'           title = "Card header",
#'           f7Slider("obs", "Number of observations", 0, 1000, 500),
#'           plotOutput("distPlot")
#'         )
#'       )
#'     )
#'   ),
#'   server = function(input, output, session) {
#'     output$distPlot <- renderPlot({
#'       dist <- rnorm(input$obs)
#'       hist(dist)
#'     })
#'
#'     observeEvent(input$showLoader, {
#'       showF7Preloader(color = "red")
#'       Sys.sleep(2)
#'       f7HidePreloader()
#'     })
#'   }
#'  )
#'
#'  # preloader in container
#'  shinyApp(
#'   ui = f7Page(
#'     title = "Preloader in container",
#'     f7SingleLayout(
#'       navbar = f7Navbar(
#'         title = "Preloader in container",
#'         hairline = FALSE,
#'         shadow = TRUE
#'       ),
#'       # main content
#'       f7Shadow(
#'         intensity = 10,
#'         hover = TRUE,
#'         f7Card(
#'           title = "Card header",
#'           f7Slider("obs", "Number of observations", 0, 1000, 500),
#'           plotOutput("distPlot")
#'         )
#'       ),
#'       f7Card("This is a simple card with plain text,
#'        but cards can also contain their own header,
#'        footer, list view, image, or any other element.")
#'     )
#'   ),
#'   server = function(input, output, session) {
#'     output$distPlot <- renderPlot({
#'       dist <- rnorm(input$obs)
#'       hist(dist)
#'     })
#'
#'     observeEvent(input$obs, {
#'       showF7Preloader(target = "#distPlot", color = "red")
#'       Sys.sleep(2)
#'       f7HidePreloader()
#'     })
#'   }
#'  )
#' }
showF7Preloader <- function(target = NULL, color = NULL,
                            session = shiny::getDefaultReactiveDomain()) {

  message <- dropNulls(list(el = target, color = color))
  session$sendCustomMessage('show-preloader', message)
}


#' Framework7 preloader
#'
#' \code{f7ShowPreloader} shows a preloader.
#' Use \link{showF7Preloader} instead
#'
#' @inheritParams showF7Preloader
#' @rdname f7-deprecated
#' @keywords internal
#'
#' @export
f7ShowPreloader <- function(target = NULL, color = NULL,
                            session = shiny::getDefaultReactiveDomain()){
  .Deprecated(
    "showF7Preloader",
    package = "shinyMobile",
    "f7ShowPreloader will be removed in future release. Please use
      showF7Preloader instead.",
    old = as.character(sys.call(sys.parent()))[1L]
  )
  showF7Preloader(target = target, color = color, session = session)
}



#' Framework7 preloader
#'
#' \code{f7HidePreloader} hides a preloader.
#'
#' @param target Element where preloader overlay will be added.
#' @param session Shiny session object.
#' @export
#' @rdname preloader
f7HidePreloader <- function(target = NULL,
                            session = shiny::getDefaultReactiveDomain()) {
  .Deprecated(
    "hideF7Preloader",
    package = "shinyMobile",
    "f7HidePreloader will be removed in future release. Please use
      hideF7Preloader instead.",
    old = as.character(sys.call(sys.parent()))[1L])
  hideF7Preloader(target = target, session = session)
}



#' Framework7 preloader
#'
#' \code{hideF7Preloader} hides a preloader.
#' Use \link{f7HidePreloader} instead
#'
#' @inheritParams hideF7Preloader
#' @rdname f7-deprecated
#' @keywords internal
#' @export
hideF7Preloader <- function(target = NULL,
                            session = shiny::getDefaultReactiveDomain()) {
  message <- dropNulls(list(el = target))
  session$sendCustomMessage('hide-preloader', message)
}

