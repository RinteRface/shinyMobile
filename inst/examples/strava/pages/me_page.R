me_page <- function() {
  page(
    href = "/me",
    ui = function(request) {
      tags$div(
        class = "page",
        f7Navbar(
          title = "You",
          leftPanel = tagList(
            f7Link(
              icon = f7Icon("person_circle"),
              href = "/profile",
              routable = TRUE
            )
          ),
          rightPanel = tagList(
            f7Link(
              icon = f7Icon("gear_alt"),
              href = "/settings",
              routable = TRUE
            )
          )
        ),
        tags$div(
          class = "page-content",
          f7Tabs(
            style = "strong",
            animated = TRUE,
            swipeable = FALSE,
            f7Tab(
              title = "Progress",
              tabName = "progress",
              "Progress tab"
            ),
            f7Tab(
              title = "Activities",
              tabName = "activities",
              "Activities tab"
            )
          )
        )
      )
    }
  )
}
