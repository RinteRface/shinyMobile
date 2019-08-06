#' Create an f7 sheet modal
#'
#' @param ... Sheet content.
#' @param id Sheet unique id.
#' @param label Trigger label.
#' @param orientation "top" or "bottom".
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyF7)
#'   shiny::shinyApp(
#'     ui = f7Page(
#'       color = "pink",
#'       title = "My app",
#'       f7Init("ios"),
#'       f7Sheet(
#'         id = "sheet1",
#'         label = "More",
#'         orientation = "bottom",
#'         "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
#'         Quisque ac diam ac quam euismod porta vel a nunc. Quisque sodales
#'         scelerisque est, at porta justo cursus ac"
#'       )
#'     ),
#'     server = function(input, output) {}
#'   )
#' }
f7Sheet <- function(..., id, label = "Open", orientation = c("top", "bottom")) {

  orientation <- match.arg(orientation)

  sheetCl <- "sheet-modal "
  if (orientation == "top") sheetCl <- paste0(sheetCl, " sheet-modal-top")


 shiny::tagList(
   # javascript initialization
   shiny::singleton(
     shiny::tags$head(
       shiny::tags$script(
         paste(
            "$(function() {
               var sheet = app.sheet.create({
                  el: '#", id, "'
                });
            });
            "
         )
       )
     )
   ),
   # sheet tag
   shiny::a(class = "button button-fill sheet-open", href="#", `data-sheet` = paste0("#", id), label),
   shiny::tags$div(
     class = sheetCl,
     id = id,
     shiny::tags$div(
       class = "toolbar",
       shiny::tags$div(
         class = "toolbar-inner",
         shiny::tags$div(class = "left"),
         shiny::tags$div(
           class = "right",
           shiny::a(class = "link sheet-close", href = "#", "Done")
          )
       )
     ),
     shiny::tags$div(
       class = "sheet-modal-inner",
       shiny::tags$div(
         class = "block",
         ...
       )
     )
   )
 )
}
