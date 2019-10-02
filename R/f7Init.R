#' Custom initialization
#'
#' Use inside \link{f7Page}. Mandatory!
#'
#' @param skin App skin: "ios", "md", "auto" or "aurora".
#' @param theme App theme: "light" or "dark".
#' @param filled Whether to fill the \link{f7Navbar} and \link{f7Toolbar} with
#' the current selected color. FALSE by default.
#' @param color Color theme: See \url{http://framework7.io/docs/color-themes.html}.
#' Expect a name like blue or red. If NULL, use the default color.
#' @param fastClicks Default to TRUE. Fast clicks is a built-in library that removes
#' 300ms delay from links and form elements in mobile browser while you click them.
#' Modern browsers are smart enough to eliminate that click delay. You can enable
#' this built-in library if you target old devices or experience click delays.
#' @param tapHold  It triggers (if enabled) after a sustained, complete touch event.
#' By default it is disabled. Note, that Tap Hold is a part of built-in Fast Clicks library,
#' so Fast Clicks should be also enabled.
#' @param iosTouchRipple Default to FALSE. Enables touch ripple effect for iOS theme.
#' @param panelSwipeSide NULL by default. Other choices are c("left", "right", "both").
#' If you want to enable ability to open/close side panels with swipe you can pass here left (for left panel) or
#' right (for right panel) or both (for both panels).
#' @param iosCenterTitle Default to TRUE. When enabled then it will try to position
#' title at the center in iOS theme. Sometime (with some custom design) it may not needed.
#' @param hideNavOnPageScroll Default to TRUE. Will hide Navbars on page scroll.
#' @param hideTabsOnPageScroll Default to FALSE. Will hide tabs on page scroll.
#' @param serviceWorker Object with service worker module parameters. (Use for PWA).
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Init <- function(skin = c("ios", "md", "auto", "aurora"), theme = c("dark", "light"),
                   filled = FALSE, color = NULL, fastClicks = TRUE, tapHold = TRUE,
                   iosTouchRipple = FALSE, panelSwipeSide = NULL,
                   iosCenterTitle = TRUE, hideNavOnPageScroll = TRUE,
                   hideTabsOnPageScroll = FALSE, serviceWorker = NULL) {

  color <- colorToHex(color)

  theme <- match.arg(theme)
  skin <- match.arg(skin)

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
    if (tapHold) {
      shiny::singleton(
        shiny::tags$style(
          "-moz-user-select: none;
           -webkit-user-select: none;
           user-select: none;
          "
        )
      )
    },
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
          name: '',
          theme: '", skin, "',
          fastClicks: ", tolower(fastClicks), ",
          swipeNoFollow: true,
          touch: {
            tapHold: ", tolower(tapHold), " //enable tap hold events
          },
          iosTouchRipple: ", tolower(iosTouchRipple), ",
          // allow both panels to swipe
          panel: {
            swipe: '", panelSwipeSide, "',
          },
          // App id
          id: 'f7App',
          navbar: {
            hideOnPageScroll: ", tolower(hideNavOnPageScroll), ",
            iosCenterTitle: ", tolower(iosCenterTitle), ",
          },
          toolbar: {
            hideOnPageScroll: ", tolower(hideTabsOnPageScroll), ",
          },
          // Register service worker
          serviceWorker: {
            path: './", serviceWorker, "',
            scope: '/'
          },
          methods: {
            setLayoutTheme: function (", theme, ") {
              var self = this;
              var $html = self.$('html');
              globalTheme = ", theme, ";
              $html.removeClass('theme-dark theme-light').addClass('theme-' + globalTheme);
            }
          }
        });
        var mainView = app.views.create('.view-main');
        app.methods.setLayoutTheme('", theme, "');
      "
        )
      )
    )
  )
}
