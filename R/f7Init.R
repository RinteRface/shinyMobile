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
#' @param tapHold  It triggers (if enabled) after a sustained, complete touch event.
#' By default it is disabled. Note, that Tap Hold is a part of built-in Fast Clicks library,
#' so Fast Clicks should be also enabled.
#' @param tapHoldDelay Determines how long (in ms) the user must hold their tap before the taphold event is fired on the target element.
#' Default to 750 ms.
#' @param pullToRefresh Whether to active the pull to refresh feature. Default to FALSE.
#' @param iosTouchRipple Default to FALSE. Enables touch ripple effect for iOS theme.
#' @param iosCenterTitle Default to TRUE. When enabled then it will try to position
#' title at the center in iOS theme. Sometime (with some custom design) it may not needed.
#' @param iosTranslucentBars Enable translucent effect (blur background) on navigation bars for iOS theme (on iOS devices).
#' FALSE by default.
#' @param hideNavOnPageScroll Default to FALSE. Will hide Navbars on page scroll.
#' @param hideTabsOnPageScroll Default to FALSE. Will hide tabs on page scroll.
#' @param serviceWorker Object with service worker module parameters. (Use for PWA).
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Init <- function(skin = c("ios", "md", "auto", "aurora"), theme = c("dark", "light"),
                   filled = FALSE, color = NULL, tapHold = TRUE, tapHoldDelay = 750, pullToRefresh = FALSE,
                   iosTouchRipple = FALSE, iosCenterTitle = TRUE, iosTranslucentBars = FALSE,
                   hideNavOnPageScroll = FALSE, hideTabsOnPageScroll = FALSE,
                   serviceWorker = NULL) {

  color <- colorToHex(color)
  theme <- match.arg(theme)
  skin <- match.arg(skin)

  if (theme == "dark" && filled == TRUE && color == "white") {
    stop("Wrong theme combination: navbar color cannot be white in a dark theme!")
  }

  shiny::tagList(
    # use global framework7 variable to set the color
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
    # specific css needs to apply if the style is filled
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
    # app initialisation
    shiny::singleton(
      shiny::tags$script(
        paste0(
          "var app = new Framework7({
            // data may be accessed in any other script!
            data: function () {
              return {
                pullToRefresh: ", tolower(pullToRefresh),"
              };
            },
            // App root element
            root: '#app',
            // App Name
            name: '',
            theme: '", skin, "',
            swipeNoFollow: true,
            touch: {
              tapHold: ", tolower(tapHold), ", // enable tap hold events
              tapHoldDelay: ", tapHoldDelay, ",
            },
            iosTouchRipple: ", tolower(iosTouchRipple), ",
            // App id
            id: 'f7App',
            navbar: {
              hideOnPageScroll: ", tolower(hideNavOnPageScroll), ",
              iosCenterTitle: ", tolower(iosCenterTitle), ",
            },
            toolbar: {
              hideOnPageScroll: ", tolower(hideTabsOnPageScroll), ",
            },
            iosTranslucentBars: ", tolower(iosTranslucentBars), ",
            // Register service worker
            //serviceWorker: {
            //  path: './", serviceWorker, "',
            //  scope: '/'
            //},
            methods: {
              setLayoutTheme: function (", theme, ") {
                var self = this;
                var $html = self.$('html');
                globalTheme = ", theme, ";
                $html.removeClass('theme-dark theme-light').addClass('theme-' + globalTheme);
              }
            }
          });

          // create main view
          var mainView = app.views.create('.view-main');
          app.methods.setLayoutTheme('", theme, "');
          // trick to fix the photo browser link issue
          // we set the body class that will contain the color.
          // We then recover this class in a variable in the my-app.js code
          $('body').addClass('", color, "');
          $('body').attr('filled', ", tolower(filled),");
        "
        )
      )
    )
  )
}
