#' Show preloader
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
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     title = "My app",
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
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     title = "My app",
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
  message <- dropNulls(list(el = target, color = color))
  session$sendCustomMessage('show-preloader', message)
}


#' Hide preloader
#'
#' @param target Element where preloader overlay will be added.
#' @param session Shiny session object.
#' @export
#' @rdname preloader
f7HidePreloader <- function(target = NULL, session = shiny::getDefaultReactiveDomain()) {
  message <- dropNulls(list(el = target))
  session$sendCustomMessage('hide-preloader', message)
}
