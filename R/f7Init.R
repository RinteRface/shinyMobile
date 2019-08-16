#' Custom initialization
#'
#' Use inside \link{f7Page}. Mandatory!
#'
#' @param theme App theme: "ios", "md", "auto" or "aurora".
#' @param filled Whether to fill the \link{f7Navbar} and \link{f7Toolbar} with
#' the current selected color. FALSE by default.
#' @param color Color theme: See \url{http://framework7.io/docs/color-themes.html}.
#' Expect a name like blue or red.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Init <- function(theme = c("ios", "md", "auto", "aurora"), filled = FALSE,
                   color = "blue") {

  color <- colorToHex(color)

  theme <- match.arg(theme)
  shiny::tagList(
    shiny::singleton(
      shiny::tags$style(
        paste0(
          ":root {
            --f7-theme-color: ", color, ";
          }
          "
        )
      )
    ),
    if (filled) {
      shiny::singleton(
        shiny::tags$style(
          "/* Invert navigation bars to fill style */
            :root,
            :root.theme-dark,
            :root .theme-dark {
              --f7-bars-bg-color: var(--f7-theme-color);
              --f7-bars-text-color: #fff;
              --f7-bars-link-color: #fff;
              --f7-navbar-subtitle-text-color: rgba(255,255,255,0.85);
              --f7-bars-border-color: transparent;
              --f7-tabbar-link-active-color: #fff;
              --f7-tabbar-link-inactive-color: rgba(255,255,255,0.54);
              --f7-searchbar-bg-color: var(--f7-bars-bg-color);
              --f7-searchbar-input-bg-color: #fff;
              --f7-searchbar-input-text-color: #000;
              --f7-sheet-border-color: transparent;
              --f7-tabbar-link-active-border-color: #fff;
            }
            .appbar,
            .navbar,
            .toolbar,
            .subnavbar,
            .calendar-header,
            .calendar-footer {
              --f7-touch-ripple-color: var(--f7-touch-ripple-white);
              --f7-link-highlight-color: var(--f7-link-highlight-white);
              --f7-button-text-color: #fff;
              --f7-button-pressed-bg-color: rgba(255,255,255,0.1);
            }
        "
        )
      )
    },
    shiny::singleton(
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
          toolbar: {
            hideOnPageScroll: true,
          },
          // ... other parameters
      });
      var mainView = app.views.create('.view-main');
      "
        )
      )
    )
  )
}
