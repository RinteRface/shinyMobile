#' Create a Framework7 row container
#'
#' Build a Framework7 row container
#'
#' @param ... Row content.
#' @param gap Whether to display gap between columns. TRUE by default.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     title = "Grid",
#'     f7Init(theme = "auto"),
#'     f7Row(
#'      f7Col(
#'       f7Card(
#'        "This is a simple card with plain text,
#'        but cards can also contain their own header,
#'        footer, list view, image, or any other element."
#'       )
#'      ),
#'      f7Col(
#'       f7Card(
#'        title = "Card header",
#'        "This is a simple card with plain text,
#'         but cards can also contain their own header,
#'         footer, list view, image, or any other element.",
#'        footer = tagList(
#'         f7Button(color = "blue", "My button", src = "https://www.google.com"),
#'         f7Badge("Badge", color = "green")
#'        )
#'       )
#'      )
#'     )
#'   ),
#'   server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Row <- function(..., gap = TRUE) {
 shiny::tags$div(class = if (gap) "row" else "row no-gap", ...)
}



#' Create a Framework7 column container
#'
#' Build a Framework7 column container
#'
#' @param ... Column content. The width is automatically handled depending
#' on the number of columns.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @note The dark theme does not work for items embedded in a column. Use \link{f7Flex}
#' instead.
#'
#' @export
f7Col <- function(...) {
  shiny::tagList(
    # this CSS is because columns don't have CSS in framework7
    # Yup this is strange, I know...
    shiny::singleton(
      shiny::tags$head(
        shiny::tags$style(
          "div[class*='col'] {
            background-color: 'gainsboro';
            text-align: center;
            color: #000;
            border: 1px solid 'gainsboro';
            padding: 5px;
            margin-bottom: 15px;
            font-size: 12px;
          }
        "
        )
      )
    ),
    shiny::tags$div(class = "col", ...)
  )
}




#' Create a Framework7 flex container
#'
#' Build a Framework7 flex container
#'
#' @param ... Items.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'     title = "Align",
#'     f7Init(theme = "auto"),
#'     f7Flex(
#'      f7Block(strong = TRUE),
#'      f7Block(strong = TRUE),
#'      f7Block(strong = TRUE)
#'     )
#'    ),
#'    server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Flex <- function(...) {
  shiny::tags$div(
    class = "display-flex justify-content-space-between align-items-flex-start",
    ...
  )
}
