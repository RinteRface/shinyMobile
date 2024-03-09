#' Framework7 accordion container
#'
#' \code{f7Accordion} creates an interactive accordion container.
#'
#' @param ... Slot for \link{f7AccordionItem}.
#' @param id Optional id to recover the state of the accordion.
#' @param multiCollapse `r lifecycle::badge("deprecated")`:
#' removed from Framework7.
#' @param side Accordion collapse toggle side. Default to right.
#'
#' @rdname accordion
#'
#' @example inst/examples/accordion/app.R
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Accordion <- function(..., id = NULL, multiCollapse = deprecated(), side = c("right", "left")) {
  lifecycle::deprecate_warn(
    when = "1.1.0",
    what = "f7Accordion(multiCollapse)",
    details = "multiCollapse has been
    removed from Framework7 and will be removed from shinyMobile
    in the next release."
  )

  side <- match.arg(side)
  cl <- "list list-strong list-outline-ios list-dividers-ios inset-md accordion-list"
  if (side == "left") cl <- sprintf("%s accordion-opposite", cl)
  accordionTag <- shiny::tags$div(
    class = cl,
    shiny::tags$ul(...)
  )

  tagAppendAttributes(
    accordionTag,
    id = id,
    class = "collapsible"
  )
}

#' Framework7 accordion item
#'
#' \code{f7AccordionItem} is to be inserted in \link{f7Accordion}.
#'
#' @param ... Item content such as \link{f7Block} or any f7 element.
#' @param title Item title.
#' @param open Whether the item is open at start. FALSE by default.
#'
#' @export
#' @rdname accordion
f7AccordionItem <- function(..., title = NULL, open = FALSE) {
  accordionCl <- "accordion-item"
  if (open) accordionCl <- paste0(accordionCl, " accordion-item-opened")

  # item tag
  shiny::tags$li(
    class = accordionCl,
    shiny::tags$a(
      class = "item-content item-link",
      shiny::tags$div(
        class = "item-inner",
        shiny::tags$div(class = "item-title", title)
      )
    ),
    shiny::tags$div(
      class = "accordion-item-content",
      ...
    )
  )
}

#' Update Framework 7 accordion
#'
#' \link{updateF7Accordion} toggles an \link{f7Accordion} on the client.
#'
#' @param id Accordion instance.
#' @param selected Index of item to select.
#' @param session Shiny session object
#'
#' @export
#' @rdname accordion
updateF7Accordion <- function(id, selected = NULL, session = shiny::getDefaultReactiveDomain()) {
  message <- list(selected = selected)
  session$sendInputMessage(id, message)
}
