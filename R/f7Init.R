#' Custom initialization
#'
#' Use inside \link{f7Page}. Mandatory!
#'
#' @param theme App theme: "ios", "md", "auto" or "aurora".
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Init <- function(theme = c("ios", "md", "auto", "aurora")) {
  theme <- match.arg(theme)
  shiny::tags$script(
    paste0(
      "var app = new Framework7({
          // App root element
          root: '#app',
          // App Name
          name: 'My App',
          theme: '", theme, "',
          fastClicks: true,
          iosTouchRipple: true,
          // allow both panels to swipe
          panel: {
            swipe: 'both',
          },
          // App id
          id: 'f7App',
          navbar: {
            hideOnPageScroll: true,
            iosCenterTitle: true,
          },
          // ... other parameters
      });
      var mainView = app.views.create('.view-main');
      "
    )
  )
}
