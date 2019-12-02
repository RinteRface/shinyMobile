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
#'  library(shinyMobile)
#'
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     title = "Grid",
#'     f7SingleLayout(
#'      navbar = f7Navbar(title = "f7Row, f7Col"),
#'      f7Row(
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
#'         f7Button(color = "blue", label = "My button", src = "https://www.google.com"),
#'         f7Badge("Badge", color = "green")
#'        )
#'       )
#'      )
#'     )
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
f7Col <- function(...) shiny::tags$div(class = "col", ...)




#' Create a Framework7 flex container
#'
#' Build a Framework7 flex container
#'
#' @param ... Items.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'     title = "Align",
#'     f7SingleLayout(
#'      navbar = f7Navbar(title = "f7Flex"),
#'      f7Flex(
#'      f7Block(strong = TRUE),
#'      f7Block(strong = TRUE),
#'      f7Block(strong = TRUE)
#'     )
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





# #' Allow to resize a row or column
# #'
# #' Use with \link{f7Row} and/or \link{f7Col}.
# #'
# #' @param tag Tag to resize.
# #' @param fixed Whether to fix the element size. FALSE by default.
# #' @param minWidth Tag minimum width when resizing. Default to 100px. Ignored
# #' if the tag is a row.
# #' @param minHeight Tag minimum height when resizing. Default to 100px. Ignored
# #' if the tag is a col.
# #' @export
# #' @examples
# #' if (interactive()) {
# #'  library(shiny)
# #'  library(shinyMobile)
# #'
# #'  shiny::shinyApp(
# #'  ui = f7Page(
# #'    title = "Grid",
# #'    f7SingleLayout(
# #'      navbar = f7Navbar(title = "f7Row, f7Col"),
# #'      f7Row(
# #'        f7Col(
# #'          f7Card(
# #'            "This is a simple card with plain text,
# #'         but cards can also contain their own header,
# #'         footer, list view, image, or any other element."
# #'          )
# #'        ) %>% f7Resize(),
# #'        f7Col(
# #'          f7Row(
# #'           f7Col(
# #'            f7Card(
# #'             "This is a simple card with plain text,
# #'             but cards can also contain their own header,
# #'             footer, list view, image, or any other element."
# #'            )
# #'           )
# #'          ) %>% f7Resize(),
# #'          f7Row(
# #'           f7Col(
# #'            f7Card(
# #'             "This is a simple card with plain text,
# #'             but cards can also contain their own header,
# #'             footer, list view, image, or any other element."
# #'            )
# #'           )
# #'          ) %>% f7Resize()
# #'        ) %>% f7Resize(),
# #'        f7Col(
# #'          f7Card(
# #'            title = "Card header",
# #'            "This is a simple card with plain text,
# #'          but cards can also contain their own header,
# #'          footer, list view, image, or any other element.",
# #'            footer = tagList(
# #'              f7Button(color = "blue", label = "My button", src = "https://www.google.com"),
# #'              f7Badge("Badge", color = "green")
# #'            )
# #'          )
# #'        ) %>% f7Resize()
# #'      ) %>% f7Resize()
# #'    )
# #'  ),
# #'  server = function(input, output) {}
# #'  )
# #'
# #' }
# f7Resize <- function(tag, fixed = FALSE, minWidth = "100px", minHeight = "100px") {
#
#   resizeCl <- if (fixed) "resizable-fixed" else "resizable"
#
#   style <- switch(tag$attribs$class,
#     "row" = paste0("min-height: ", minWidth),
#     "col" = paste0("min-width: ", minWidth)
#   )
#   tag %>% shiny::tagAppendAttributes(class = resizeCl, style = style) %>%
#     shiny::tagAppendChild(shiny::tags$span(class = "resize-handler"))
#
# }
#
