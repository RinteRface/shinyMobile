#' Create a Framework7 button
#'
#' Build a Framework7 button
#'
#' @param inputId The input slot that will be used to access the value.
#' @param label The contents of the button or link–usually a text label,
#' but you could also use any other HTML, like an image or \link{f7Icon}.
#' @param href Button link.
#' @param color Button color. Not compatible with outline.
#' See here for valid colors \url{https://framework7.io/docs/badge.html}.
#' @param fill Fill style. TRUE by default. Not compatible with outline
#' @param outline Outline style. FALSE by default. Not compatible with fill.
#' @param shadow Button shadow. FALSE by default. Only for material design.
#' @param rounded Round style. FALSE by default.
#' @param size Button size. NULL by default but also "large" or "small".
#' @param active Button active state. Default to FALSE. This is useful when
#' used in \link{f7Segment} with the strong parameter set to TRUE.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Button <- function(inputId = NULL, label = NULL, href = NULL,
                     color = NULL, fill = TRUE, outline = FALSE,
                     shadow = FALSE, rounded = FALSE, size = NULL,
                     active = FALSE) {

  if (!is.null(inputId) & !is.null(href)) stop("Cannot set inputId and src at the same time.")

  # outline and fill are incompatible by definition
  # as well as color and outline

  if (outline & fill) stop("outline and fill cannot be used at the same time")
  if (outline & !is.null(color)) stop("outline buttons cannot have color!")

  # need to add external to handle external url
  buttonCl <- "button"
  if (!is.null(href)) buttonCl <- paste0(buttonCl, " external")
  if (!is.null(inputId)) buttonCl <- paste0(buttonCl, " f7-action-button")
  if (!is.null(color)) buttonCl <- paste0(buttonCl, " color-", color)
  if (fill) buttonCl <- paste0(buttonCl, " button-fill")
  if (outline) buttonCl <- paste0(buttonCl, " button-outline")
  if (shadow) buttonCl <- paste0(buttonCl, " button-raised")
  if (rounded) buttonCl <- paste0(buttonCl, " button-round")
  if (!is.null(size)) buttonCl <- paste0(buttonCl, " button-", size)
  if (active) buttonCl <- paste0(buttonCl, " button-active")

  value <- if (!is.null(inputId)) shiny::restoreInput(id = inputId, default = NULL)

  shiny::tags$button(
    id = inputId,
    type = "button",
    class = buttonCl,
    href = if (!is.null(href)) href else NULL,
    `data-val` = if (!is.null(inputId)) value else NULL,
    label
  )
}





#' Create a Framework7 segmented button container
#'
#' Build a Framework7 segmented button container
#'
#' @param ... Slot for \link{f7Button}.
#' @param container Either "row" or "segment".
#' @param shadow Button shadow. FALSE by default. Only if the container is segment.
#' @param rounded Round style. FALSE by default. Only if the container is segment.
#' @param strong Strong style. FALSE by default.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'   ui = f7Page(
#'     title = "Button Segments",
#'     f7SingleLayout(
#'      navbar = f7Navbar(title = "f7Segment, f7Button"),
#'      f7BlockTitle(title = "Simple Buttons in a row container"),
#'     f7Segment(
#'      container = "row",
#'      f7Button(color = "blue", label = "My button", fill = FALSE),
#'      f7Button(color = "green", label = "My button", href = "http://www.google.com", fill = FALSE),
#'      f7Button(color = "yellow", label = "My button", fill = FALSE)
#'     ),
#'     f7BlockTitle(title = "Filled Buttons in a segment/rounded container"),
#'     f7Segment(
#'      rounded = TRUE,
#'      container = "segment",
#'      f7Button(color = "black", label = "Action Button", inputId = "button2"),
#'      f7Button(color = "green", label = "My button", href = "http://www.google.com"),
#'      f7Button(color = "yellow", label = "My button")
#'     ),
#'     f7BlockTitle(title = "Outline Buttons in a segment/shadow container"),
#'     f7Segment(
#'      shadow = TRUE,
#'      container = "segment",
#'      f7Button(label = "My button", outline = TRUE, fill = FALSE),
#'      f7Button(label = "My button", outline = TRUE, fill = FALSE),
#'      f7Button(label = "My button", outline = TRUE, fill = FALSE)
#'     ),
#'     f7BlockTitle(title = "Buttons in a segment/strong container"),
#'     f7Segment(
#'      strong = TRUE,
#'      container = "segment",
#'      f7Button(label = "My button", fill = FALSE),
#'      f7Button(label = "My button", fill = FALSE),
#'      f7Button(label = "My button", fill = FALSE, active = TRUE)
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
f7Segment <- function(..., container = c("segment", "row"), shadow = FALSE,
                      rounded = FALSE, strong = FALSE) {

  container <- match.arg(container)

  containerCl <- if (container == "segment") {
    "segmented"
  }
  else {
    "row"
  }

  if (container == "row" & (shadow | rounded | strong)) {
    stop("shadow and/or rounded only apply when the container
         is a segment!")
  }

  if (shadow) containerCl <- paste0(containerCl, " segmented-raised")
  if (rounded) containerCl <- paste0(containerCl, " segmented-round")
  if (strong) containerCl <- paste0(containerCl, " segmented-strong")

  wrapperBlock <- function(...) shiny::tags$div(class = "block", shiny::tags$p(...))
  wrapper <- wrapperBlock()
  wrapper$children[[1]]$attribs$class <- containerCl

  btns <- list(...)
  if (container == "row") {
    for (i in seq_along(btns)) {
      btns[[i]]$attribs$class <- paste(
        btns[[i]]$attribs$class,
        class = "col"
      )
    }
  }
  wrapper$children[[1]] <- shiny::tagAppendChildren(
    wrapper$children[[1]],
    btns,
    if (strong) shiny::span(class = "segmented-highlight")
  )
  return(wrapper)
}





