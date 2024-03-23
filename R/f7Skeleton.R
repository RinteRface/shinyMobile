#' Framework 7 skeleton effect
#'
#' Nice loading overlay for UI elements.
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
#'       f7SingleLayout(
#'         navbar = f7Navbar(title = "f7Skeleton"),
#'         f7Card(
#'           title = "Card header",
#'           "This is a simple card with plain text,
#'       but cards can also contain their own header,
#'       footer, list view, image, or any other element.",
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
#'       observeEvent(TRUE,
#'         {
#'           f7Skeleton(".card", "fade", 2)
#'         },
#'         once = TRUE
#'       )
#'     }
#'   )
#' }
f7Skeleton <- function(
    target = ".card",
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

  sendCustomMessage("add_skeleton", message, session)
}
