#' Update Framework7 configuration
#'
#' \link{updateF7App} allows to update a shinyMobile app at run time by
#' injecting any configuration inside the current running instance. Useful it you want
#' to share the same behavior across multiple elements.
#'
#' @note This function may be not work with all options and is intended
#' for advanced/expert usage.
#'
#' @param options List of options.
#' @param session Shiny session object.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shinyApp(
#'    ui = f7Page(
#'      title = "Simple Dialog",
#'      f7SingleLayout(
#'        navbar = f7Navbar(title = "f7Dialog"),
#'        f7Button(inputId = "goButton", "Go!"),
#'        f7Button(inputId = "update", "Update config")
#'      )
#'    ),
#'    server = function(input, output, session) {
#'      observeEvent(input$goButton,{
#'        f7Dialog(
#'          title = "Dialog title",
#'          text = "This is an alert dialog"
#'        )
#'      })
#'
#'      observeEvent(input$update,{
#'        updateF7App(
#'         options = list(
#'          dialog = list(
#'           buttonOk =  "Yeaaaah!",
#'           buttonCancel = "Ouuups!"
#'          )
#'         )
#'        )
#'
#'        f7Dialog(
#'          id = "test",
#'          title = "Warning",
#'          type = "confirm",
#'          text = "Look at me, I have a new buttons!"
#'        )
#'      })
#'    }
#'  )
#' }
updateF7App <- function(options, session = shiny::getDefaultReactiveDomain()) {
  sendCustomMessage("update-app", options, session)
}




#' Update Framework7 entity
#'
#' \link{updateF7Entity} allows to update any Framework7 instance from the server.
#' For each entity, the list of updatable properties may significantly vary. Please
#' refer to the Framework7 documentation at \url{https://v5.framework7.io/docs/}.
#'
#' @param id Element id.
#' @param options Configuration list. Tightly depends on the entity.
#' See \url{https://v5.framework7.io/docs/}.
#' @param session Shiny session object.
#' @export
#'
#' @examples
#' # Update action sheet instance
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  shinyApp(
#'    ui = f7Page(
#'      title = "Simple Dialog",
#'      f7SingleLayout(
#'        navbar = f7Navbar(title = "Update action sheet instance"),
#'        f7Button(inputId = "goButton", "Go!"),
#'        f7Button(inputId = "update", "Update config")
#'      )
#'    ),
#'    server = function(input, output, session) {
#'      observeEvent(input$goButton, {
#'        f7ActionSheet(
#'         grid = TRUE,
#'         id = "action1",
#'         buttons = list(
#'           list(
#'             text = "Notification",
#'             icon = f7Icon("info"),
#'             color = NULL
#'           ),
#'           list(
#'             text = "Dialog",
#'             icon = f7Icon("lightbulb_fill"),
#'             color = NULL
#'           )
#'         )
#'        )
#'      })
#'
#'      observeEvent(input$update,{
#'        updateF7Entity(
#'        id = "action1",
#'         options = list(
#'          buttons = list(
#'           list(
#'             text = "Notification",
#'             icon = f7Icon("info"),
#'             color = NULL
#'           )
#'          )
#'         )
#'        )
#'      })
#'    }
#'  )
#' }
updateF7Entity <- function(id, options, session = shiny::getDefaultReactiveDomain()) {

  # Convert any shiny tag into character so that toJSON does not cry
  listRenderTags <- function(l) {
    lapply(
      X = l,
      function(x) {
        if (inherits(x, c("shiny.tag", "shiny.tag.list"))) {
          as.character(x)
        } else if (inherits(x, "list")) {
          listRenderTags(x)
        } else {
          x
        }
      }
    )
  }
  options <- listRenderTags(options)

  message <- list(id = id, options = options)
  sendCustomMessage("update-entity", message, session)
}
