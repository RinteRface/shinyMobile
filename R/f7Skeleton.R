#' Framework 7 skeleton effect
#'
#' Nice loading overlay for UI elements. You
#' can also set `skeletonsOnLoad` TRUE in the app
#' main options (see example) to show skeletons on load.
#'
#' This function is expected to be called from an observeEvent,
#' you may also have to increase the observer priority (see example).
#'
#' @param target CSS selector on which to apply the effect.
#' In general, you apply the effect on a wrapper such as a card,
#' such that all nested elements receive the skeleton.
#' @param effect Choose between "fade", "blink" or "pulse".
#' @param duration Effect duration. NULL by default. If you know
#' exactly how much time your most time consuming output takes
#' to render, you can pass an explicit duration. In other cases,
#' leave it to NULL.
#' @param session Shiny session object.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(shinyMobile)
#'
#'   shinyApp(
#'     ui = f7Page(
#'       title = "Skeletons",
#'       options = list(skeletonsOnLoad = TRUE),
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "f7Skeleton"),
#'         f7Block(
#'           f7Button("update", "Update card")
#'         ),
#'         f7Card(
#'           title = "Card header",
#'           textOutput("test"),
#'         ),
#'         f7List(
#'           f7ListItem(
#'             href = "https://www.google.com",
#'             title = "Item 1"
#'           ),
#'           f7ListItem(
#'             href = "https://www.google.com",
#'             title = "Item 2"
#'           )
#'         )
#'       )
#'     ),
#'     server = function(input, output, session) {
#'       txt <- eventReactive(input$update,
#'         {
#'           Sys.sleep(3)
#'           "This is a simple card with plain text,
#'         but cards can also contain their own header,
#'         footer, list view, image, or any other element."
#'         },
#'         ignoreNULL = FALSE
#'       )
#'       output$test <- renderText(txt())
#'       observeEvent(input$update,
#'         {
#'           f7Skeleton(".card", "fade")
#'         },
#'         priority = 1000
#'       )
#'     }
#'   )
#' }
f7Skeleton <- function(
    target,
    effect = c("fade", "blink", "pulse"),
    duration = NULL,
    session = shiny::getDefaultReactiveDomain()) {
  effect <- match.arg(effect)
  message <- dropNulls(
    list(
      target = target,
      effect = effect,
      duration = duration
    )
  )

  sendCustomMessage("add-skeleton", message, session)
}
