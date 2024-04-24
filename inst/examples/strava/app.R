library(shiny)
library(shinyMobile)
library(brochure)

home_page <- function() {
  page(
    href = "/",
    ui = function(request) {
      shiny::tags$div(
        class = "page",
        # top navbar goes here
        f7Navbar(
          title = "Home",
          leftPanel = tagList(
            tags$a(
              href = "#",
              class = "link sheet-open",
              f7Icon("splus_circle"),
              `data-sheet` = "#new"
            ),
            f7Link(icon = f7Icon("search"), href = "#")
          ),
          rightPanel = tagList(
            f7Link(icon = f7Icon("chat_bubble_text_fill"), href = "#"),
            f7Link(icon = f7Icon("bell"), href = "#")
          )
        ),
        tags$div(
          class = "page-content",
          f7Sheet(
            id = "new",
            orientation = "top",
            swipeHandler = FALSE,
            f7Segment(
              tags$a(
                href = "#",
                class = "link sheet-open",
                f7Icon("text_alignleft"),
                `data-sheet` = "#post",
                "Post"
              ),
              tags$a(
                href = "#",
                class = "link sheet-open",
                f7Icon("photo"),
                `data-sheet` = "#photo-post",
                "Photos"
              ),
              tags$a(
                href = "#",
                class = "link sheet-open",
                f7Icon("pencil"),
                `data-sheet` = "#manual-post",
                "Manual"
              )
            )
          )
        )
      )
    }
  )
}

page_2 <- function() {
  page(
    href = "/2"
  )
}

brochureApp(
  # Pages
  home_page(),
  page_2(),
  # Important: in theory brochure makes
  # each page having its own shiny session/ server function.
  # That's not what we want here so we'll have
  # a global server function.
  server = function(input, output, session) {

  },
  wrapped = f7MultiLayout,
  wrapped_options = list(
    # Common toolbar
    toolbar = f7Toolbar(
      icons = TRUE,
      f7Link(
        "Home",
        icon = f7Icon("house"),
        href = "/",
        routable = TRUE
      ),
      f7Link(
        "Maps",
        icon = f7Icon("map_pin_ellipse"),
        href = "/maps",
        routable = TRUE
      ),
      tags$a(
        href = "#",
        class = "link sheet-open",
        f7Icon("smallcircle_fill_circle
"),
        "Record",
        `data-sheet` = "#record"
      ),
      f7Link(
        "Groups",
        icon = f7Icon("person_2_fill"),
        href = "/groups",
        routable = TRUE
      ),
      f7Link(
        "You",
        icon = f7Icon("graph_circle"),
        href = "/you",
        routable = TRUE
      )
    ),
    options = list(
      dark = FALSE,
      theme = "ios",
      color = "deeporange",
      routes = list(
        list(path = "/", url = "/", name = "home")
        # Important: don't remove keepalive
        # for child pages as this allows
        # to save the input state when switching
        # between pages. If FALSE, each time a page is
        # changed, inputs are reset (except on the first page).
      )
    )
  )
)
