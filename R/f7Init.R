#' Custom initialization
#'
#' Use inside \link{f7Page}. Mandatory!
#'
#' @param theme App theme: "ios", "md", "auto".
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Init <- function(theme = c("ios", "md", "auto")) {
  theme <- match.arg(theme)
  shiny::tags$head(
    shiny::tags$script(
      paste0(
        "$(function() {
          var app = new Framework7({
            // App root element
            root: '#app',
            // App Name
            name: 'My App',
            // App id
            id: 'com.myapp.test',
            theme: '", theme, "'
            // ... other parameters
          });
        });
        "
      )
    )
  )
}
