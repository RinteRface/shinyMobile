#' Create a Framework7 container for floating action button (FAB)
#'
#' Build a Framework7 container for floating action button (FAB)
#'
#' @param ... Slot for \link{f7Fab}.
#' @param id Optional: access the current state of the \link{f7Fabs} container.
#' @param position Container position.
#' @param color Container color.
#' @param extended If TRUE, the FAB will be wider. This allows to use a label (see below).
#' @param label Container label. Only if extended is TRUE.
#' @param sideOpen When the container is pressed, indicate where buttons are displayed.
#' @param morph Whether to allow the FAB to transofrm into another UI element.
#' @param morphTarget CSS selector of the morph target: \code{".toolbar"} for instance.
#'
#' @note The background color might be an issue depending on the parent container. Consider
#' it experimental.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shiny::shinyApp(
#'   ui = f7Page(
#'     color = "pink",
#'     title = "Floating action buttons",
#'     f7SingleLayout(
#'      navbar = f7Navbar(title = "f7Fabs"),
#'      f7Fabs(
#'       extended = TRUE,
#'       label = "Menu",
#'       position = "center-top",
#'       color = "yellow",
#'       sideOpen = "right",
#'       lapply(1:4, function(i) f7Fab(paste0("btn", i), i))
#'     ),
#'     lapply(1:4, function(i) verbatimTextOutput(paste0("res", i))),
#'
#'     f7Fabs(
#'       position = "center-center",
#'       color = "purple",
#'       sideOpen = "center",
#'       lapply(5:8, function(i) f7Fab(paste0("btn", i), i))
#'     ),
#'     lapply(5:8, function(i) verbatimTextOutput(paste0("res", i))),
#'
#'     f7Fabs(
#'       position = "left-bottom",
#'       color = "pink",
#'       sideOpen = "top",
#'       lapply(9:12, function(i) f7Fab(paste0("btn", i), i))
#'     )
#'     )
#'
#'   ),
#'   server = function(input, output) {
#'     lapply(1:12, function(i) {
#'       output[[paste0("res", i)]] <- renderPrint(input[[paste0("btn", i)]])
#'     })
#'   }
#'  )
#' }
#'
#' @export
f7Fabs <- function(..., id = NULL, position = c("right-top", "right-center", "right-bottom", "left-top",
  "left-center", "left-bottom", "center-center", "center-top", "center-bottom"),
  color = NULL, extended = FALSE, label = NULL,
  sideOpen = c("left", "right", "top", "bottom", "center"), morph = FALSE, morphTarget = NULL) {

  position <- match.arg(position)
  fabCl <- paste0("fab fab-", position, if(!is.null(color)) " color-", color)
  if (extended) fabCl <- paste0(fabCl, " fab-extended")
  if (morph) fabCl <- paste0(fabCl, " fab-morph")

  sideOpen <- match.arg(sideOpen)

  shiny::tagList(
    f7InputsDeps(),
    shiny::tags$div(
      class = fabCl,
      id = id,
      `data-morph-to` = if (morph) morphTarget else NULL,
      shiny::a(
        href = "#",
        f7Icon("plus"),
        f7Icon("multiply"),
        if (!is.null(label)) {
          shiny::tags$div(class = "fab-text", label)
        }
      ),
      # do not create button wrapper if there are no items inside...
      if (length(list(...)) > 0) {
        shiny::tags$div(class = paste0("fab-buttons fab-buttons-", sideOpen), ...)
      }
    )
  )
}




#' Create a Framework7 floating action button (FAB)
#'
#' Build a Framework7 floating action button (FAB)
#'
#' @inheritParams shiny::actionButton
#' @param flag Additional text displayed next to the button content. Only works
#' if \link{f7Fabs} position parameter is not starting with center-...
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Fab <- function(inputId, label, width = NULL, ..., flag = NULL) {
  value <- shiny::restoreInput(id = inputId, default = NULL)
  shiny::tags$a(
    id = inputId,
    style = if (!is.null(width)) paste0("width: ", shiny::validateCssUnit(width), ";"),
    type = "button",
    class = if (!is.null(flag)) "fab-label-button f7-action-button" else "f7-action-button",
    `data-val` = value,
    list(...),
    shiny::span(label),
    if (!is.null(flag)) {
      shiny::span(class = "fab-label", flag)
    }
  )
}




#' Convert a tag into a target morphing
#'
#' @param tag Target tag.
#' @export
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'      f7SingleLayout(
#'        navbar = f7Navbar(title = "f7Fabs Morph"),
#'        toolbar = f7Toolbar(
#'          position = "bottom",
#'          lapply(1:3, function(i) f7Link(i) %>% f7FabClose())
#'        ) %>% f7FabMorphTarget(),
#'        # put an empty f7Fabs container
#'        f7Fabs(
#'          extended = TRUE,
#'          label = "Open",
#'          position = "center-top",
#'          color = "yellow",
#'          sideOpen = "right",
#'          morph = TRUE,
#'          morphTarget = ".toolbar"
#'        )
#'      )
#'
#'    ),
#'    server = function(input, output) {}
#'  )
#' }
f7FabMorphTarget <- function(tag) {
  tag$attribs$class <- paste(tag$attribs$class, "fab-morph-target")
  return(tag)
}


#' Indicate that the current tag should close the \link{f7Fabs}
#'
#' @param tag Target tag.
#' @export
f7FabClose <- function(tag) {
  shiny::tagAppendAttributes(tag, class = "fab-close")
}
