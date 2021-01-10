#' Framework7 popover
#'
#' \link{f7Popover} is deprecated. It has to be used in an oberve
#' or observeEvent context. Only works for input elements!
#'
#' @param targetId Target to put the popover on.
#' @param content Popover content.
#' @param session shiny session.
#'
#' @export
#' @rdname popover
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
#'          content = "This is a f7Button"
#'        )
#'      })
#'
#'      observe({
#'        f7Popover(
#'          targetId = "test2",
#'          content = "This is a f7Slider"
#'        )
#'      })
#'    }
#'  )
#' }
f7Popover <- function(targetId, content, session = shiny::getDefaultReactiveDomain()) {

  .Deprecated(
    "addF7Popover",
    package = "shinyMobile",
    "f7Popover will be removed in future release. Please use
    addF7Popover instead.",
    old = as.character(sys.call(sys.parent()))[1L]
  )

  message <- dropNulls(
    list(
      content = content
    )
  )
  # see my-app.js function
  session$sendCustomMessage(type = targetId, message = message)
}



#' Framework7 popover target
#'
#' \link{f7PopoverTarget} is deprecated. This must be used in combination of \link{f7Popover}.
#' Only works for input elements!
#'
#' @param tag Tag that will be targeted. Must be a f7Input element.
#' @param targetId Popover id. Must correspond to the \link{f7Popover} targetId.
#'
#' @rdname popover
#'
#' @export
f7PopoverTarget <- function(tag, targetId) {

  .Deprecated(
    "addF7Popover",
    package = "shinyMobile",
    "f7PopoverTarget will be removed in future release. Please use
    addF7Popover instead.",
    old = as.character(sys.call(sys.parent()))[1L]
  )


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




#' Add Framework7 popover
#'
#' \link{addF7Popover} adds a popover to the given target and show it if enabled
#' by \link{toggleF7Popover}.
#'
#' @param id Popover target id.
#' @param selector jQuery selector. Allow more customization for the target (nested tags).
#' @param options List of options to pass to the popover. See \url{https://framework7.io/docs/popover.html#popover-parameters}.
#' @param session Shiny session object.
#' @export
#' @rdname popover
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  lorem_ipsum <- "Lorem ipsum dolor sit amet,
#'            consectetur adipiscing elit. Quisque ac diam ac quam euismod
#'            porta vel a nunc. Quisque sodales scelerisque est, at porta
#'            justo cursus ac."
#'
#'  popovers <- data.frame(
#'    id = paste0("target_", 1:10),
#'    content = paste("Popover content", 1:10, lorem_ipsum),
#'    stringsAsFactors = FALSE
#'  )
#'
#'
#'  shinyApp(
#'    ui = f7Page(
#'      options = list(theme = "ios"),
#'      title = "f7Popover",
#'      f7SingleLayout(
#'        navbar = f7Navbar(
#'          title = "f7Popover",
#'          subNavbar = f7SubNavbar(
#'            f7Toggle(
#'              inputId = "toggle",
#'              "Enable popover",
#'              color = "green",
#'              checked = TRUE
#'            )
#'          )
#'        ),
#'        f7Segment(
#'          lapply(seq_len(nrow(popovers)), function(i) {
#'            f7Button(
#'              inputId = sprintf("target_%s", i),
#'              sprintf("Target %s", i)
#'            )
#'          })
#'        )
#'      )
#'    ),
#'    server = function(input, output, session) {
#'      # Enable/disable (don't run first)
#'      observeEvent(input$toggle, {
#'        lapply(seq_len(nrow(popovers)), function(i) toggleF7Popover(id = popovers[i, "id"]) )
#'      }, ignoreInit = TRUE)
#'
#'      # show
#'      lapply(seq_len(nrow(popovers)), function(i) {
#'        observeEvent(input[[popovers[i, "id"]]], {
#'          addF7Popover(
#'            id = popovers[i, "id"],
#'            options = list(
#'              content = popovers[i, "content"]
#'            )
#'          )
#'        })
#'      })
#'    }
#'  )
#' }
addF7Popover <- function(id = NULL, selector = NULL, options, session = shiny::getDefaultReactiveDomain()) {
  validateSelector(id, selector)
  if (!is.null(id)) id <- paste0("#", session$ns(id))
  options$targetEl <- id %OR% selector
  sendCustomMessage("add_popover", options, session)
}



#' Toggle Framework7 popover
#'
#' \link{toggleF7Popover} toggles the visibility of popover. See example for use case.
#'
#' @param id Popover target id.
#' @param selector jQuery selector. Allow more customization for the target (nested tags).
#' @param session Shiny session object.
#' @export
#' @rdname popover
toggleF7Popover <- function(id = NULL, selector = NULL, session = shiny::getDefaultReactiveDomain()) {
  validateSelector(id, selector)
  if (!is.null(id)) id <- paste0("#", session$ns(id))
  targetEl <- id %OR% selector
  sendCustomMessage("toggle_popover", targetEl, session)
}
