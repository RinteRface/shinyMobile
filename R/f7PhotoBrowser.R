#' Create a fremework7 photo browser
#'
#' @param id Unique id.
#' @param label Trigger label
#' @param photos List of photos
#' @param theme Browser theme: choose either light or dark.
#' @param type Browser type: choose among \code{c("popup", "standalone", "page")}.
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
#'      title = "f7PhotoBrowser",
#'      f7SingleLayout(
#'        navbar = f7Navbar(title = "f7PhotoBrowser"),
#'        f7PhotoBrowser(
#'          id = "photobrowser1",
#'          label = "Open",
#'          theme = "light",
#'          type = "standalone",
#'          photos = c(
#'            "https://cdn.framework7.io/placeholder/sports-1024x1024-1.jpg",
#'            "https://cdn.framework7.io/placeholder/sports-1024x1024-2.jpg",
#'            "https://cdn.framework7.io/placeholder/sports-1024x1024-3.jpg"
#'          )
#'        )
#'      )
#'    ),
#'    server = function(input, output, session) {}
#'  )
#' }
f7PhotoBrowser <- function(id, label, photos, theme = c("light", "dark"),
                           type = c("popup", "standalone", "page")) {

  theme <- match.arg(theme)
  type <- match.arg(type)

  photoBrowserTrigger <- f7Button(inputId = id, label = label)

  photos <- jsonlite::toJSON(photos)
  pageBackLinkText <- if (type == "page") "back" else NULL

  photoBrowserJS <-shiny::singleton(
    shiny::tags$head(
      shiny::tags$script(
        paste0(
          "$(function() {
            var photoBrowser = app.photoBrowser.create({
              photos: ", photos, ",
              theme: '", theme, "',
              type: '", type, "',
              pageBackLinkText: '", pageBackLinkText, "'
            });

            // open the photo browser
            $('#", id,"').on('click', function() {
              photoBrowser.open();
            });
          });
          "
        )
      )
    )
  )

  shiny::tagList(photoBrowserJS, photoBrowserTrigger)

}
