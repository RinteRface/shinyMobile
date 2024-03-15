#' Framework7 block
#'
#' \code{f7Block} creates a block container.
#'
#' @param ... Block content. Also for \link{f7BlockHeader} and \link{f7BlockFooter}.
#' @param hairlines `r lifecycle::badge("deprecated")`:
#' removed from Framework7.
#' @param strong Add white background so that text is highlighted. FALSE by default.
#' @param inset Whether to set block inset. FALSE by default. Works only if strong is TRUE.
#' @param tablet Whether to make block inset only on large screens. FALSE by default.
#' @param outline Block border. Default to FALSE.
#'
#' @rdname block
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   shinyApp(
#'     ui = f7Page(
#'       title = "Blocks",
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "f7Block"),
#'         f7BlockTitle(title = "A large title", size = "large"),
#'         f7Block(
#'           f7BlockHeader(text = "Header"),
#'           "Here comes paragraph within content block.
#'      Donec et nulla auctor massa pharetra
#'      adipiscing ut sit amet sem. Suspendisse
#'      molestie velit vitae mattis tincidunt.
#'      Ut sit amet quam mollis, vulputate
#'      turpis vel, sagittis felis.",
#'           f7BlockFooter(text = "Footer")
#'         ),
#'         f7BlockTitle(title = "A medium title", size = "medium"),
#'         f7Block(
#'           strong = TRUE,
#'           outline = TRUE,
#'           f7BlockHeader(text = "Header"),
#'           "Here comes paragraph within content block.
#'      Donec et nulla auctor massa pharetra
#'      adipiscing ut sit amet sem. Suspendisse
#'      molestie velit vitae mattis tincidunt.
#'      Ut sit amet quam mollis, vulputate
#'      turpis vel, sagittis felis.",
#'           f7BlockFooter(text = "Footer")
#'         ),
#'         f7BlockTitle(title = "A normal title", size = NULL),
#'         f7Block(
#'           inset = TRUE,
#'           strong = TRUE,
#'           f7BlockHeader(text = "Header"),
#'           "Here comes paragraph within content block.
#'      Donec et nulla auctor massa pharetra
#'      adipiscing ut sit amet sem. Suspendisse
#'      molestie velit vitae mattis tincidunt.
#'      Ut sit amet quam mollis, vulputate
#'      turpis vel, sagittis felis.",
#'           f7BlockFooter(text = "Footer")
#'         ),
#'         f7Block(
#'           inset = TRUE,
#'           tablet = TRUE,
#'           strong = TRUE,
#'           f7BlockHeader(text = "Header"),
#'           "Here comes paragraph within content block.
#'      Donec et nulla auctor massa pharetra
#'      adipiscing ut sit amet sem. Suspendisse
#'      molestie velit vitae mattis tincidunt.
#'      Ut sit amet quam mollis, vulputate
#'      turpis vel, sagittis felis.",
#'           f7BlockFooter(text = "Footer")
#'         ),
#'         f7Block(
#'           inset = TRUE,
#'           strong = TRUE,
#'           outline = TRUE,
#'           f7BlockHeader(text = "Header"),
#'           "Here comes paragraph within content block.
#'      Donec et nulla auctor massa pharetra
#'      adipiscing ut sit amet sem. Suspendisse
#'      molestie velit vitae mattis tincidunt.
#'      Ut sit amet quam mollis, vulputate
#'      turpis vel, sagittis felis.",
#'           f7BlockFooter(text = "Footer")
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
f7Block <- function(..., hairlines = TRUE, strong = FALSE, inset = FALSE,
                    tablet = FALSE, outline = FALSE) {
  blockCl <- "block"

  lifecycle::deprecate_warn(
    when = "1.1.0",
    what = "f7Block(hairlines)",
    details = "hairlines has been
    removed from Framework7 and will be removed from shinyMobile
    in the next release."
  )

  if (!inset && tablet) {
    stop("inset must be TRUE when tablet is TRUE")
  }

  if (!strong && inset) {
    stop("inset requires strong to be TRUE")
  }

  if (strong) {
    blockCl <- paste(blockCl, "block-strong")
    if (inset && !tablet) {
      blockCl <- paste(blockCl, "inset")
    }
  }
  if (tablet) blockCl <- paste(blockCl, "medium-inset")
  if (outline) blockCl <- paste(blockCl, "block-outline")

  shiny::tags$div(
    class = blockCl,
    ...
  )
}

#' Framework7 block title
#'
#' \code{f7BlockTitle} creates a title for \link{f7Block}.
#'
#' @param title Block title.
#' @param size Block title size. NULL by default or "medium", "large".
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
#' @rdname block
f7BlockTitle <- function(title, size = NULL) {
  titleCl <- "block-title"
  if (!is.null(size)) {
    if (size == "large") {
      titleCl <- paste0(titleCl, " block-title-large")
    } else if (size == "medium") {
      titleCl <- paste0(titleCl, " block-title-medium")
    } else {
      stop("Choose either NULL, medium or large!")
    }
  }
  shiny::tags$div(class = titleCl, title)
}

#' Framework7 block header
#'
#' \code{f7BlockHeader} creates a header content for \link{f7Block}.
#'
#' @param text Any text.
#' @export
#' @rdname block
f7BlockHeader <- function(text) {
  shiny::tags$div(class = "block-header", text)
}

#' Framework7 block footer
#'
#' \link{f7BlockFooter} creates a footer content for \link{f7Block}.
#'
#' @param text Any text.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
#' @rdname block
f7BlockFooter <- function(text) {
  shiny::tags$div(class = "block-footer", text)
}
