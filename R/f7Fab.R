#' Framework7 container for floating action button (FAB)
#'
#' \code{f7Fabs} hosts multiple \link{f7Fab}.
#'
#' @param ... Slot for \link{f7Fab}.
#' @param id Optional: access the current state of the \link{f7Fabs} container.
#' @param position Container position.
#' @param color Container color.
#' @param extended If TRUE, the FAB will be wider. This allows to use a label (see below).
#' @param label Container label. Only if extended is TRUE.
#' @param sideOpen When the container is pressed, indicate where buttons are displayed.
#' @param morph `r lifecycle::badge("deprecated")`:
#' removed from Framework7.
#' @param morphTarget CSS selector of the morph target: \code{".toolbar"} for instance.
#'
#' @note The background color might be an issue depending on the parent container. Consider
#' it experimental.
#'
#' @rdname fabs
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @example inst/examples/fabs/app.R
#' @export
f7Fabs <- function(
    ..., id = NULL, position = c(
      "right-top", "right-center", "right-bottom", "left-top",
      "left-center", "left-bottom", "center-center", "center-top", "center-bottom"
    ),
    color = NULL, extended = FALSE, label = NULL,
    sideOpen = c("left", "right", "top", "bottom", "center"), morph = deprecated(), morphTarget = NULL) {
  if (lifecycle::is_present(morph)) {
    lifecycle::deprecate_warn(
      when = "2.0.0",
      what = "f7Fabs(morph)",
      details = "morph has been
      removed from Framework7 and will be removed from shinyMobile
      in the next release. Only morphTarget is necessary."
    )
  }

  position <- match.arg(position)
  fabCl <- paste0("fab fab-", position, if (!is.null(color)) " color-", color)
  if (extended) fabCl <- paste0(fabCl, " fab-extended")
  if (!is.null(morphTarget)) fabCl <- paste0(fabCl, " fab-morph")

  sideOpen <- match.arg(sideOpen)

  shiny::tags$div(
    class = fabCl,
    id = id,
    `data-morph-to` = morphTarget,
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
}

#' Update Framework 7 FAB container
#'
#' \code{updateF7Fabs} toggles \link{f7Fabs} on the server side.
#'
#' @param session The Shiny session object, usually the default value will suffice.
#'
#' @rdname fabs
#' @export
updateF7Fabs <- function(id, session = shiny::getDefaultReactiveDomain()) {
  session$sendInputMessage(inputId = id, NULL)
}

#' Framework7 floating action button (FAB)
#'
#' \code{f7Fab} generates a nice button to be put in \link{f7Fabs}.
#'
#' @inheritParams shiny::actionButton
#' @param flag Additional text displayed next to the button content. Only works
#' if \link{f7Fabs} position parameter is not starting with center-...
#'
#' @rdname fab
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Fab <- function(inputId, label, width = NULL, ..., flag = NULL) {
  value <- shiny::restoreInput(id = inputId, default = NULL)
  shiny::tags$a(
    id = inputId,
    style = if (!is.null(width)) {
      paste0("width: ", shiny::validateCssUnit(width), ";")
    },
    type = "button",
    class = if (!is.null(flag)) {
      "fab-label-button f7-action-button"
    } else {
      "f7-action-button"
    },
    `data-val` = value,
    list(...),
    shiny::span(label),
    if (!is.null(flag)) {
      shiny::span(class = "fab-label", flag)
    }
  )
}

#' Update FAB
#'
#' \code{updateF7Fab} changes the label of an \link{f7Fab} input on the client.
#'
#' @param session The Shiny session object, usually the default value will suffice.
#'
#' @export
#'
#' @rdname fab
updateF7Fab <- function(inputId, label = NULL,
                        session = shiny::getDefaultReactiveDomain()) {
  message <- dropNulls(list(label = label))
  session$sendInputMessage(inputId, message)
}

#' Framework7 FAB morphing
#'
#' \code{f7FabMorphTarget} convert a tag into a target morphing.
#' See \url{https://framework7.io/docs/floating-action-button#fab-morph}.
#'
#' @rdname fabs
#'
#' @param tag Target tag.
#' @export
f7FabMorphTarget <- function(tag) {
  shiny::tagAppendAttributes(tag, class = "fab-morph-target")
}

#' Framework7 FAB close
#'
#' \code{f7FabClose} indicates that the current tag should close the \link{f7Fabs}.
#'
#' @param tag Target tag.
#' @export
f7FabClose <- function(tag) {
  shiny::tagAppendAttributes(tag, class = "fab-close")
}
