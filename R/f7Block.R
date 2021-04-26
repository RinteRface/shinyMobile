#' Framework7 block
#'
#' \code{f7Block} creates a block container.
#'
#' @param ... Block content. Also for \link{f7BlockHeader} and \link{f7BlockFooter}.
#' @param hairlines Whether to allow hairlines. TRUE by default.
#' @param strong Whether to put the text in bold. FALSE by default.
#' @param inset Whether to set block inset. FALSE by default. Works only if strong is TRUE.
#' @param tablet Whether to make block inset only on large screens. FALSE by default.
#'
#' @rdname block
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  shinyApp(
#'   ui = f7Page(
#'     title = "Blocks",
#'     f7SingleLayout(
#'      navbar = f7Navbar(title = "f7Block"),
#'      f7BlockTitle(title = "A large title", size = "large"),
#'     f7Block(
#'      f7BlockHeader(text = "Header"),
#'      "Here comes paragraph within content block.
#'      Donec et nulla auctor massa pharetra
#'      adipiscing ut sit amet sem. Suspendisse
#'      molestie velit vitae mattis tincidunt.
#'      Ut sit amet quam mollis, vulputate
#'      turpis vel, sagittis felis.",
#'      f7BlockFooter(text = "Footer")
#'     ),
#'
#'     f7BlockTitle(title = "A medium title", size = "medium"),
#'     f7Block(
#'      strong = TRUE,
#'      f7BlockHeader(text = "Header"),
#'      "Here comes paragraph within content block.
#'      Donec et nulla auctor massa pharetra
#'      adipiscing ut sit amet sem. Suspendisse
#'      molestie velit vitae mattis tincidunt.
#'      Ut sit amet quam mollis, vulputate
#'      turpis vel, sagittis felis.",
#'      f7BlockFooter(text = "Footer")
#'     ),
#'
#'     f7BlockTitle(title = "A normal title", size = NULL),
#'     f7Block(
#'      inset = TRUE,
#'      strong = TRUE,
#'      f7BlockHeader(text = "Header"),
#'      "Here comes paragraph within content block.
#'      Donec et nulla auctor massa pharetra
#'      adipiscing ut sit amet sem. Suspendisse
#'      molestie velit vitae mattis tincidunt.
#'      Ut sit amet quam mollis, vulputate
#'      turpis vel, sagittis felis.",
#'      f7BlockFooter(text = "Footer")
#'     ),
#'     f7Block(
#'      tablet = TRUE,
#'      strong = TRUE,
#'      f7BlockHeader(text = "Header"),
#'      "Here comes paragraph within content block.
#'      Donec et nulla auctor massa pharetra
#'      adipiscing ut sit amet sem. Suspendisse
#'      molestie velit vitae mattis tincidunt.
#'      Ut sit amet quam mollis, vulputate
#'      turpis vel, sagittis felis.",
#'      f7BlockFooter(text = "Footer")
#'     ),
#'     f7Block(
#'      inset = TRUE,
#'      strong = TRUE,
#'      hairlines = FALSE,
#'      f7BlockHeader(text = "Header"),
#'      "Here comes paragraph within content block.
#'      Donec et nulla auctor massa pharetra
#'      adipiscing ut sit amet sem. Suspendisse
#'      molestie velit vitae mattis tincidunt.
#'      Ut sit amet quam mollis, vulputate
#'      turpis vel, sagittis felis.",
#'      f7BlockFooter(text = "Footer")
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
f7Block <- function(..., hairlines = TRUE, strong = FALSE, inset = FALSE,
                    tablet = FALSE) {

  blockCl <- "block"
  if (!hairlines) blockCl <- paste0(blockCl, " no-hairlines")
  if (strong) {
    if (inset) {
      blockCl <- paste0(blockCl, " block-strong inset")
    } else {
      blockCl <- paste0(blockCl, " block-strong")
    }
  }
  if (tablet) blockCl <- paste0(blockCl, " tablet-inset")

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
f7BlockTitle <- function(title = NULL, size = NULL) {
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
#' @rdname block
#'
#' @export
f7BlockHeader <- function(text = NULL) {
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
f7BlockFooter <- function(text = NULL) {
  shiny::tags$div(class = "block-footer", text)
}
