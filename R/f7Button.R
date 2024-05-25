#' Framework7 action button
#'
#' \code{f7Button} generates a Framework7 action button.
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
#' @param tonal Button tonal style. Default to FALSE
#' @param icon Button icon. Expect \link{f7Icon}.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @rdname button
#'
#' @export
f7Button <- function(inputId = NULL, label = NULL, href = NULL,
                     color = NULL, fill = TRUE, outline = FALSE,
                     shadow = FALSE, rounded = FALSE, size = NULL,
                     active = FALSE, tonal = FALSE, icon = NULL) {
  if (!is.null(inputId) && !is.null(href)) stop("Cannot set inputId and src at the same time.")

  # outline and fill are incompatible by definition
  # as well as color and outline
  if (outline && fill) stop("outline and fill cannot be used at the same time")
  if (outline && !is.null(color)) stop("outline buttons cannot have color!")

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
  if (tonal) buttonCl <- paste0(buttonCl, " button-tonal")

  value <- if (!is.null(inputId)) shiny::restoreInput(id = inputId, default = NULL)

  func <- if (!is.null(href)) shiny::tags$a else shiny::tags$button

  func(
    id = inputId,
    type = "button",
    class = buttonCl,
    href = if (!is.null(href)) href else NULL,
    `data-val` = if (!is.null(inputId)) value else NULL,
    icon,
    shiny::tags$span(
      class = "f7-button-label",
      label
    )
  )
}

#' Update action button
#'
#' \code{updateF7Button} updates an \link{f7Button}.
#'
#' @inheritParams f7Button
#' @param session The Shiny session object, usually the default value will suffice.
#'
#' @rdname button
#' @export
#'
#' @example inst/examples/button/app.R
updateF7Button <- function(inputId, label = NULL, color = NULL,
                           fill = NULL, outline = NULL, shadow = NULL,
                           rounded = NULL, size = NULL, tonal = NULL,
                           icon = NULL,
                           session = shiny::getDefaultReactiveDomain()) {
  message <- dropNulls(
    list(
      label = as.character(
        shiny::tags$span(
          class = "f7-button-label",
          label
        )
      ),
      color = color,
      fill = fill,
      outline = outline,
      raised = shadow,
      round = rounded,
      size = size,
      tonal = tonal,
      icon = as.character(icon)
    )
  )
  session$sendInputMessage(inputId, message)
}

#' Framework7 segmented button container
#'
#' A Framework7 segmented button container for \link{f7Button}.
#'
#' @param ... Slot for \link{f7Button}.
#' @param container `r lifecycle::badge("deprecated")`:
#' removed from Framework7.
#' @inheritParams f7Button
#' @inheritParams f7Block
#'
#' @rdname button
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   shinyApp(
#'     ui = f7Page(
#'       options = list(dark = FALSE),
#'       title = "Button Segments",
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "f7Segment, f7Button"),
#'         f7BlockTitle(title = "Simple Buttons in a segment"),
#'         f7Segment(
#'           f7Button(color = "blue", label = "My button", fill = FALSE),
#'           f7Button(color = "green", label = "My button", fill = FALSE),
#'           f7Button(color = "yellow", label = "My button", fill = FALSE)
#'         ),
#'         f7BlockTitle(title = "Tonal buttons"),
#'         f7Segment(
#'           f7Button(color = "blue", label = "My button", tonal = TRUE),
#'           f7Button(color = "green", label = "My button", tonal = TRUE),
#'           f7Button(color = "yellow", label = "My button", tonal = TRUE)
#'         ),
#'         f7BlockTitle(title = "Filled Buttons in a segment/rounded container"),
#'         f7Segment(
#'           rounded = TRUE,
#'           f7Button(color = "black", label = "My button"),
#'           f7Button(color = "green", label = "My button"),
#'           f7Button(color = "yellow", label = "My button")
#'         ),
#'         f7BlockTitle(title = "Outline Buttons in a segment/shadow container"),
#'         f7Segment(
#'           shadow = TRUE,
#'           f7Button(label = "My button", outline = TRUE, fill = FALSE),
#'           f7Button(label = "My button", outline = TRUE, fill = FALSE),
#'           f7Button(label = "My button", outline = TRUE, fill = FALSE)
#'         ),
#'         f7BlockTitle(title = "Buttons in a segment/strong container"),
#'         f7Segment(
#'           strong = TRUE,
#'           f7Button(label = "My button", fill = FALSE),
#'           f7Button(label = "My button", fill = FALSE),
#'           f7Button(label = "My button", fill = FALSE, active = TRUE)
#'         )
#'       )
#'     ),
#'     server = function(input, output) {}
#'   )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Segment <- function(
    ..., container = deprecated(),
    shadow = FALSE, rounded = FALSE, strong = FALSE) {
  if (lifecycle::is_present(container)) {
    lifecycle::deprecate_warn(
      when = "2.0.0",
      what = "f7Segment(container)",
      details = "container has been
      removed from Framework7 and will be removed from shinyMobile
      in the next release."
    )
  }

  containerCl <- "segmented"

  if (shadow) containerCl <- paste0(containerCl, " segmented-raised")
  if (rounded) containerCl <- paste0(containerCl, " segmented-round")
  if (strong) containerCl <- paste0(containerCl, " segmented-strong")

  # Note: there's a inconsistency in the Framework7 API where the segment can
  # have the segmented-round class. This actually does not change the button
  # appearance (only the container).
  # Instead, we'll apply the button-round class to all buttons within
  # the segment, if not already done.
  btns <- list(...)
  if (rounded) {
    btns <- lapply(btns, \(btn) {
      is_rounded <- grepl("button-round", btn$attribs$class)
      if (!is_rounded) {
        btn <- tagAppendAttributes(btn, class = "button-round")
      }
      btn
    })
  }

  shiny::tags$div(
    class = "block",
    shiny::tags$p(
      class = containerCl,
      btns,
      if (strong) shiny::span(class = "segmented-highlight")
    )
  )
}
