#' Create a Framework 7 skeleton loading overlay
#'
#' @param tag Tag to be modified.
#' @param effect Choose between "fade", "blink" or "pulse".
#' @param duration Effect duration: 2s by default.
#'
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'      title = "Cards",
#'      f7SingleLayout(
#'        navbar = f7Navbar(title = "f7Card"),
#'        f7Card(
#'          title = "Card header",
#'          "This is a simple card with plain text,
#'       but cards can also contain their own header,
#'       footer, list view, image, or any other element.",
#'          footer = tagList(
#'            f7Button(color = "blue", label = "My button", src = "https://www.google.com"),
#'            f7Badge("Badge", color = "green")
#'          )
#'        ) %>% f7Skeleton(),
#'
#'         f7List(
#'          f7ListItem(
#'            url = "https://www.google.com",
#'            title = "Item 1"
#'          ) %>% f7Skeleton(effect = "pulse", duration = 5) ,
#'          f7ListItem(
#'            url = "https://www.google.com",
#'            title = "Item 2"
#'          ) %>% f7Skeleton(effect = "pulse", duration = 5)
#'         )
#'      )
#'    ),
#'    server = function(input, output) {}
#'  )
#' }
f7Skeleton <- function(tag, effect = "fade", duration = 2) {

  id <- paste0("skeleton_", round(stats::runif(1, min = 0, max = 1e9)))
  # need to add an id to the selected tag to make sure
  # that the effect is not applied to other tags
  tag$attribs$id <- id

  shiny::tagList(
    shiny::singleton(
      shiny::tags$script(
        paste0(
          "$(function() {
            // add skeleton class
            $('#", id, "').children().addClass('skeleton-text skeleton-effect-", effect, "');
            $('#", id, " .badge, #", id, " .button').addClass('skeleton-block');
            // after several seconds, remove it
            setTimeout(function() {
              $('#", id, "').children().removeClass('skeleton-text skeleton-effect-", effect, "');
              $('#", id, " .badge, #", id, " .button').removeClass('skeleton-block');
            }, ", duration * 1000, ");
        });
        "
        )
      )
    ),
    tag
  )
}
