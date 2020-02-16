#' Create a framework 7 popover
#'
#' \link{f7Popover} has to be used in an oberve
#' or observeEvent context. Only works for input elements!
#'
#' @param targetId Target to put the popover on.
#' @param content Popover content.
#' @param session shiny session.
#'
#' @export
#'
#' @importFrom shiny getDefaultReactiveDomain
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shinyApp(
#'    ui = f7Page(
#'      title = "f7Popover",
#'      f7SingleLayout(
#'        navbar = f7Navbar(title = "f7Popover"),
#'        f7PopoverTarget(
#'          f7Button(
#'            inputId = "goButton",
#'            "Go!"
#'          ),
#'          targetId = "test"
#'        ),
#'        br(),
#'        br(),
#'        f7PopoverTarget(
#'          f7Slider(
#'            inputId = "slider",
#'            label = "Value",
#'            value = 10,
#'            min = 0,
#'            max = 20
#'          ),
#'          targetId = "test2"
#'        )
#'      )
#'    ),
#'    server = function(input, output, session) {
#'      observe({
#'        f7Popover(
#'          targetId = "test",
#'          content = "This is a f7Button",
#'          session
#'        )
#'      })
#'
#'      observe({
#'        f7Popover(
#'          targetId = "test2",
#'          content = "This is a f7Slider",
#'          session
#'        )
#'      })
#'    }
#'  )
#' }
f7Popover <- function(targetId, content, session = shiny::getDefaultReactiveDomain()) {
  message <- dropNulls(
    list(
      content = content
    )
  )
  # see my-app.js function
  session$sendCustomMessage(type = targetId, message = message)
}



#' Define a popover target
#'
#' This must be used in combination of \link{f7Popover}.
#' Only works for input elements!
#'
#' @param tag Tag that will be targeted. Must be a f7Input element.
#' @param targetId Popover id. Must correspond to the \link{f7Popover}targetId.
#'
#' @export
f7PopoverTarget <- function(tag, targetId) {
  # handle the case of tagList
  # We must make sure that the tag is really a tag
  if (inherits(tag, "shiny.tag.list")) {
    temp <- NULL
    for (i in seq_along(tag)) {
      if (inherits(tag[[i]], "shiny.tag")) {
        tag[[i]]$attribs$`data-popover` <- targetId
        temp <- tag[[i]]
      }
    }
    if (is.null(temp)) stop("No valid shiny tag found.")
    tag
  } else {
    if (!inherits(tag, "shiny.tag")) stop("Please provide a tag.")
    tag$attribs$`data-popover` <- targetId
    tag
  }
}
