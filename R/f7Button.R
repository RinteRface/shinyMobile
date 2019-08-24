#' Create a Framework7 button
#'
#' Build a Framework7 button
#'
#' @param inputId The input slot that will be used to access the value.
#' @param label The contents of the button or link–usually a text label,
#' but you could also use any other HTML, like an image or \link{f7Icon}.
#' @param src Button link.
#' @param color Button color. Not compatible with outline.
#' See here for valid colors \url{https://framework7.io/docs/badge.html}.
#' @param fill Fill style. TRUE by default. Not compatible with outline
#' @param outline Outline style. FALSE by default. Not compatible with fill.
#' @param shadow Button shadow. FALSE by default. Only for material design.
#' @param rounded Round style. FALSE by default.
#' @param size Button size. NULL by default but also "large" or "small".
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Button <- function(inputId = NULL, label = NULL, src = NULL,
                     color = NULL, fill = TRUE, outline = FALSE,
                     shadow = FALSE, rounded = FALSE, size = NULL) {

  if (!is.null(inputId) & !is.null(src)) stop("Cannot set inputId and src at the same time.")

  # outline and fill are incompatible by definition as well as color and outline
  if (outline) {
    fill <- FALSE
    color <- NULL
  }

  # need to add external to handle external url
  buttonCl <- "button"
  if (!is.null(src)) buttonCl <- paste0(buttonCl, " external")
  if (!is.null(inputId)) buttonCl <- paste0(buttonCl, " action-button")
  if (!is.null(color)) buttonCl <- paste0(buttonCl, " color-", color)
  if (fill) buttonCl <- paste0(buttonCl, " button-fill")
  if (outline) buttonCl <- paste0(buttonCl, " button-outline")
  if (shadow) buttonCl <- paste0(buttonCl, " button-raised")
  if (rounded) buttonCl <- paste0(buttonCl, " button-round")
  if (!is.null(size)) buttonCl <- paste0(buttonCl, " button-", size)

  value <- if (!is.null(inputId)) shiny::restoreInput(id = inputId, default = NULL)

  shiny::tags$a(
    id = inputId,
    type = "button",
    class = buttonCl,
    href = if (!is.null(src)) src else NULL,
    `data-val` = if (!is.null(inputId)) value else NULL,
    target = "_blank",
    label
  )
}





#' Create a Framework7 segmented button container
#'
#' Build a Framework7 segmented button container
#'
#' @param ... Slot for \link{f7Button}.
#' @param container Either "row" or "segment".
#' @param shadow Button shadow. FALSE by default. Only for material design and if the container is segment.
#' @param rounded Round style. FALSE by default. Only if the container is segment.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     title = "Button Segments",
#'     f7SingleLayout(
#'      navbar = f7Navbar(title = "f7Segment, f7Button"),
#'      f7BlockTitle(title = "Simple Buttons in a row container"),
#'     f7Segment(
#'      container = "row",
#'      f7Button(color = "blue", label = "My button", fill = FALSE),
#'      f7Button(color = "green", label = "My button", src = "http://www.google.com", fill = FALSE),
#'      f7Button(color = "yellow", label = "My button", fill = FALSE)
#'     ),
#'     f7BlockTitle(title = "Filled Buttons in a segment/rounded container"),
#'     f7Segment(
#'      rounded = TRUE,
#'      container = "segment",
#'      f7Button(color = "black", label = "Action Button", inputId = "button2"),
#'      f7Button(color = "green", label = "My button", src = "http://www.google.com"),
#'      f7Button(color = "yellow", label = "My button")
#'     ),
#'     f7BlockTitle(title = "Outline Buttons in a segment/shadow container"),
#'     f7Segment(
#'      shadow = TRUE,
#'      container = "segment",
#'      f7Button(label = "My button", outline = TRUE),
#'      f7Button(label = "My button", outline = TRUE),
#'      f7Button(label = "My button", outline = TRUE)
#'     ),
#'     f7BlockTitle(title = "Rounded Buttons in a segment container"),
#'     f7Segment(
#'      container = "segment",
#'      f7Button(color = "blue", label = "My button", rounded = TRUE),
#'      f7Button(color = "green", label = "My button", rounded = TRUE),
#'      f7Button(color = "yellow", label = "My button", rounded = TRUE)
#'     ),
#'     f7BlockTitle(title = "Buttons of different size in a row container"),
#'     f7Segment(
#'      container = "row",
#'      f7Button(color = "pink", label = "My button", shadow = TRUE),
#'      f7Button(color = "purple", label = "My button", size = "large", shadow = TRUE),
#'      f7Button(color = "orange", label = "My button", size = "small", shadow = TRUE)
#'     ),
#'
#'     br(), br(),
#'     f7BlockTitle(title = "Click on the black action button to update the value"),
#'     verbatimTextOutput("val")
#'     )
#'   ),
#'   server = function(input, output) {
#'    output$val <- renderPrint(input$button2)
#'   }
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Segment <- function(..., container = c("segment", "row"), shadow = FALSE, rounded = FALSE) {

  container <- match.arg(container)

  containerCl <- if (container == "segment") {
    "segmented"
  }
  else {
    "row"
  }

  if (shadow & container == "segment") containerCl <- paste0(containerCl, " segmented-raised")
  if (rounded & container == "segment") containerCl <- paste0(containerCl, " segmented-round")

  wrapperBlock <- function(...) shiny::tags$div(class = "block", shiny::tags$p(...))
  wrapper <- wrapperBlock()
  wrapper$children[[1]]$attribs$class <- containerCl

  btns <- wrapper$children[[1]]$children
  if (container == "row") {
    lapply(seq_along(btns), function(i) {
      wrapper$children[[1]]$children[[i]]$attribs$class <- paste(
        wrapper$children[[1]]$children[[i]]$attribs$class,
        class = "col"
      )
    })
  }

  items <- shiny::tagList(...)
  wrapper$children[[1]] <- shiny::tagAppendChild(wrapper$children[[1]], items)
  return(wrapper)
}





