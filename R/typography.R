#' Create a Framework7 align
#'
#' Build a Framework7 align
#'
#' @param tag Tag to align.
#' @param side Side to align: "left", "center", "right" or "justify".
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'     title = "Align",
#'     f7Row(
#'      f7Align(h1("Left"), side = "left"),
#'      f7Align(h1("Center"), side = "center"),
#'      f7Align(h1("Right"), side = "right")
#'     )
#'    ),
#'    server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Align <- function(tag, side = c("left", "center", "right", "justify")) {

  side <- match.arg(side)
  alignCl <- paste0("text-align-", side)

  tag$attribs$class <- paste(tag$attribs$class, alignCl)
  return(tag)
}




#' Create a Framework7 float
#'
#' Build a Framework7 float
#'
#' @param tag Tag to float.
#' @param side Side to float: "left" or "right".
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'     title = "Float",
#'     f7Float(h1("Left"), side = "left"),
#'     f7Float(h1("Right"), side = "right")
#'    ),
#'    server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Float <- function(tag, side = c("left", "right")) {

  side <- match.arg(side)
  floatCl <- paste0("float-", side)

  tag$attribs$class <- paste(tag$attribs$class, floatCl)
  return(tag)
}




#' Create a Framework7 margin
#'
#' Build a Framework7 margin
#'
#' @param tag Tag to apply the margin.
#' @param side margin side: "left", "right", "top", "bottom",
#' "vertical" (top and bottom), "horizontal" (left and right).
#' Leave NULL to apply on all sides.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  cardTag <- f7Card(
#'   title = "Card header",
#'   "This is a simple card with plain text,
#'   but cards can also contain their own header,
#'   footer, list view, image, or any other element.",
#'   footer = tagList(
#'     f7Button(color = "blue", label = "My button", src = "https://www.google.com"),
#'     f7Badge("Badge", color = "green")
#'   )
#'  )
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'     title = "Margins",
#'     f7Margin(cardTag),
#'     cardTag
#'    ),
#'    server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Margin <- function(tag, side = NULL) {

  marginCl <- if (!is.null(side)) paste0("margin-", side) else "margin"

  tag$attribs$class <- paste(tag$attribs$class, marginCl)
  return(tag)
}




#' Create a Framework7 padding
#'
#' Build a Framework7 padding
#'
#' @param tag Tag to apply the padding.
#' @param side padding side: "left", "right", "top", "bottom",
#' "vertical" (top and bottom), "horizontal" (left and right).
#' Leave NULL to apply on all sides.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  cardTag <- f7Card(
#'   title = "Card header",
#'   f7Padding(
#'    p("The padding is applied here.")
#'   ),
#'   footer = tagList(
#'     f7Button(color = "blue", label = "My button", src = "https://www.google.com"),
#'     f7Badge("Badge", color = "green")
#'   )
#'  )
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'     title = "Padding",
#'     cardTag
#'    ),
#'    server = function(input, output) {}
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Padding <- function(tag, side = NULL) {

  paddingCl <- if (!is.null(side)) paste0("padding-", side) else "padding"

  tag$attribs$class <- paste(tag$attribs$class, paddingCl)
  return(tag)
}
