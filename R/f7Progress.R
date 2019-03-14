#' Create a Framework7 progress bar
#'
#' Build a Framework7 progress bar
#'
#' @param value Progress value. Between 0 and 100.
#' @param status Progress color. See \url{http://framework7.io/docs/progressbar.html}.
#'
#' @note Buggy display when status is not NULL.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'     title = "Progress",
#'     f7Init(theme = "auto"),
#'     f7Card(
#'      f7Progress(value = 10)
#'     )
#'    ),
#'    server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Progress <- function(value, status = NULL) {

  progressCl <- "progressbar"
  if (!is.null(status)) progressCl <- paste0(progressCl, " color-", status)

  initProgress <- shiny::tags$script(
    shiny::HTML(
      paste0(
        "determinateLoading = true;
         app.progressbar.show('.progressbar', ", value, " ,", status, ");
        "
      )
    )
  )

  progressTag <- shiny::tags$div(
    class = progressCl,
    `data-progress` = paste(value)
  )

  shiny::tagList(
    shiny::singleton(shiny::tags$head(initProgress)),
    progressTag
  )

}



#' Create a Framework7 infinite progress bar
#'
#' Build a Framework7 infinite progress bar
#'
#' @param status Progress color. See \url{http://framework7.io/docs/progressbar.html}.
#'
#' @note Buggy display when status is not NULL.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'     title = "Progress Infinite",
#'     f7Init(theme = "auto"),
#'     f7Card(
#'      f7ProgressInf()
#'     )
#'    ),
#'    server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7ProgressInf <- function(status = NULL) {

  progressCl <- "progressbar-infinite"
  if (!is.null(status)) progressCl <- paste0(progressCl, " color-", status)

  initProgress <- shiny::tags$script(
    shiny::HTML(
      paste0(
        "determinateLoading = false;
         app.progressbar.show('.progressbar-infinite', ", status, ");
        "
      )
    )
  )

  progressTag <- shiny::tags$div(class = progressCl)

  shiny::tagList(
    shiny::singleton(shiny::tags$head(initProgress)),
    progressTag
  )
}
