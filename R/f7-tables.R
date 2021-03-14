#' Framework7 table
#'
#' Creates a table container.
#'
#' @param data A data.frame.
#' @param colnames Column names to use, if \code{NULL} uses \code{data} column names.
#' @param card Whether to use as card.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     title = "My app",
#'     f7SingleLayout(
#'        navbar = f7Navbar(
#'          title = "Single Layout",
#'        ),
#'       uiOutput("table")
#'     )
#'   ),
#'   server = function(input, output) {
#'     output$table <- renderUI({
#'       f7Table(cars)
#'     })
#'   }
#'  )
#' }
#'
#' @export
f7Table <- function(data, colnames = NULL, card = FALSE){
  classes <- lapply(data, class2f7)

  if(is.null(colnames))
    colnames <- names(classes)

  if(length(colnames) != length(classes))
    stop("The number of `colnames` must match the number of columns of `data`", call. = FALSE)

  headers <- list()
  for(i in 1:length(colnames)){
    headers[[i]] <- list(
      class = classes[[i]],
      colname = colnames[[i]]
    )
  }

  headers <- lapply(headers, function(x){
    shiny::tags$th(class = x$class, x$colname)
  })

  data_list <- apply(data, 1, as.list)

  table <- lapply(data_list, function(row){
    r <- lapply(row, function(cell){
      shiny::tags$th(class = class2f7(cell), cell)
    })
    shiny::tags$tr(r)
  })

  cl <- "data-table"

  if(card)
    cl <- paste(cl, "card")

  shiny::div(
    class = cl,
    shiny::tags$table(
      shiny::tags$thead(
        shiny::tags$tr(headers)
      ),
      shiny::tags$tbody(table)
    )
  )
}

#' Get CSS class based on cell class
#'
#' @param x Value.
#'
#' @keywords internal
class2f7 <- function(x){
  if(inherits(x, "numeric"))
    return("numeric-cell")

  return("label-cell")
}
