#' Create an f7 sheet modal
#'
#' @param ... Sheet content.
#' @param id Sheet unique id.
#' @param label Trigger label.
#' @param orientation "top" or "bottom".
#' @param swipeToClose If TRUE, it can be closed by swiping down.
#' @param swipeToStep If TRUE then sheet will be opened partially,
#' and with swipe it can be further expanded.
#' @param backdrop Enables Sheet backdrop (dark semi transparent layer
#' behind). By default it is TRUE for MD and Aurora themes and
#' FALSE for iOS theme.
#' @param closeByOutsideClick When enabled, sheet will be closed on
#' when click outside of it.
#' @param swipeHandler Whether to display a swipe handler. TRUE by default.
#' Need either swipeToClose or swipeToStep set to TRUE to work.
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
f7Sheet <- function(..., id, label = "Open", orientation = c("top", "bottom"),
                    swipeToClose = FALSE, swipeToStep = FALSE, backdrop = FALSE,
                    closeByOutsideClick = TRUE, swipeHandler = TRUE) {

  orientation <- match.arg(orientation)

  # min to make JS happy
  swipeToCloseJS <- tolower(swipeToClose)
  swipeToStepJS <- tolower(swipeToStep)
  backdropJS <- tolower(backdrop)
  closeByOutsideClick <- tolower(closeByOutsideClick)

  sheetCl <- "sheet-modal"
  if (orientation == "top") sheetCl <- paste0(sheetCl, " sheet-modal-top")


 shiny::tagList(
   # javascript initialization
   shiny::singleton(
     shiny::tags$head(
       shiny::tags$script(
          paste0(
             "$(function() {
               var sheet = app.sheet.create({
                  el: '#", id, "',
                  swipeToClose: ", swipeToCloseJS, ",
                  swipeToStep: ", swipeToStepJS, ",
                  backdrop: ", backdropJS, ",
                  closeByOutsideClick : ", closeByOutsideClick, "
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
     style = if (swipeToStep | swipeToClose) "height: auto;",
     id = id,
     if (!(swipeToStep | swipeToClose)) {
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
        )
     },
     shiny::tags$div(
       class = "sheet-modal-inner",
       if ((swipeToStep | swipeToClose) & swipeHandler) shiny::tags$div(class = "swipe-handler"),
       shiny::tags$div(
         class = if (swipeToStep) {
            "block sheet-modal-swipe-step"
         } else {
            "block"
         },
         ...
       )
     )
   )
 )
}
