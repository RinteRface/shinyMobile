#' Framework7 preloader
#'
#' Deprecated. \link{f7ShowPreloader} shows a preloader.
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
#'       f7ShowPreloader(color = "red")
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
#'       f7ShowPreloader(target = "#distPlot", color = "red")
#'       Sys.sleep(2)
#'       f7HidePreloader()
#'     })
#'   }
#'  )
#' }
f7ShowPreloader <- function(target = NULL, color = NULL,
                            session = shiny::getDefaultReactiveDomain()) {

  .Deprecated(
    "showF7Preloader",
    package = "shinyMobile",
    "f7ShowPreloader will be removed in future release. Please use
    showF7Preloader instead.",
    old = as.character(sys.call(sys.parent()))[1L]
  )

  message <- dropNulls(list(el = target, color = color))
  session$sendCustomMessage('show-preloader', message)
}


#' Framework7 preloader
#'
#' \link{showF7Preloader} shows a preloader.
#'
#' @param target Element where preloader overlay will be added.
#' @param color Preloader color.
#' @param session Shiny session object.
#' @export
#' @rdname preloader
showF7Preloader <- f7ShowPreloader


#' Framework7 preloader
#'
#' Deprecated. \link{f7HidePreloader} hides a preloader.
#'
#' @param target Element where preloader overlay will be added.
#' @param session Shiny session object.
#' @export
#' @rdname preloader
f7HidePreloader <- function(target = NULL, session = shiny::getDefaultReactiveDomain()) {

  .Deprecated(
    "hideF7Preloader",
    package = "shinyMobile",
    "f7HidePreloader will be removed in future release. Please use
    hideF7Preloader instead.",
    old = as.character(sys.call(sys.parent()))[1L]
  )

  message <- dropNulls(list(el = target))
  session$sendCustomMessage('hide-preloader', message)
}



#' Framework7 preloader
#'
#' \link{hideF7Preloader} hides a preloader.
#'
#' @param target Element where preloader overlay will be added.
#' @param session Shiny session object.
#' @export
#' @rdname preloader
hideF7Preloader <- f7HidePreloader
