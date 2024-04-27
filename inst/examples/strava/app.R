library(shiny)
library(shinyMobile)
library(brochure)

e <- environment()
path <- system.file("examples/strava/pages", package = "shinyMobile")
sapply(
  list.files(
    path,
    include.dirs = FALSE,
    pattern = ".R",
    ignore.case = TRUE
  ),
  function(f) {
    source(file.path(path, f), local = e)
  }
)

brochureApp(
  # Pages
  home_page(),
  me_page(),
  profile_page(),
  messages_page(),
  settings_page(),
  # Important: in theory brochure makes
  # each page having its own shiny session/ server function.
  # That's not what we want here so we'll have
  # a global server function.
  server = function(input, output, session) {
    add_post("new")
    new_message("mod1")
  },
  wrapped = f7MultiLayout,
  wrapped_options = list(
    # Common toolbar
    toolbar = f7Toolbar(
      icons = TRUE,
      # Allow to show correct active state
      # since this is not really a tab layout
      tags$script(
        "$(function(){
          $('.tab-link').on('click', function() {
            $(this).addClass('tab-link-active');
            $('.tab-link').not(this).removeClass('tab-link-active');
          });
        });"
      ),
      f7TabLink(
        `data-animate` = "false",
        label = "Home",
        icon = f7Icon("house"),
        href = "/",
        # TO be routable
        class = "link tab-link-active"
      ),
      f7TabLink(
        `data-animate` = "false",
        label = "Maps",
        icon = f7Icon("map_pin_ellipse"),
        href = "/maps",
        # TO be routable
        class = "link"
      ),
      tags$a(
        href = "#",
        class = "link tab-link sheet-open",
        f7Icon("smallcircle_fill_circle
"),
        span(class = "tabbar-label", "Record"),
        `data-sheet` = "#record"
      ),
      f7TabLink(
        `data-animate` = "false",
        label = "Groups",
        icon = f7Icon("person_2_fill"),
        href = "/groups",
        # TO be routable
        class = "link"
      ),
      f7TabLink(
        `data-animate` = "false",
        label = "You",
        icon = f7Icon("graph_circle"),
        href = "/me",
        # TO be routable
        class = "link"
      )
    ),
    options = list(
      dark = FALSE,
      theme = "ios",
      color = "deeporange",
      routes = list(
        list(
          path = "/",
          url = "/",
          name = "home"
        ),
        list(
          path = "/me",
          url = "/me",
          name = "me",
          keepAlive = TRUE
        ),
        list(
          path = "/profile",
          url = "/profile",
          name = "profile",
          keepAlive = TRUE
        ),
        list(
          path = "/messages",
          url = "/messages",
          name = "messages",
          keepAlive = TRUE
        ),
        list(
          path = "/settings",
          url = "/settings",
          name = "settings", keepAlive = TRUE
        )
      )
    )
  )
)
