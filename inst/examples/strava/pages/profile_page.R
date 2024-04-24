profile_page <- function() {
  page(
    href = "/profile",
    ui = function(request) {
      tags$div(
        class = "page",
        f7Navbar(
          title = "Profile",
          leftPanel = tagList(
            tags$a(
              href = "/me",
              class = "link",
              tags$i(class = "icon icon-back"),
              tags$span("You")
            )
          ),
          rightPanel = tagList(
            f7Link(icon = f7Icon("search"), href = "#"),
            f7Link(
              icon = f7Icon("gear_alt"),
              href = "/settings",
              routable = TRUE
            )
          )
        ),
        tags$div(
          class = "page-content",
          "TBD"
        )
      )
    }
  )
}
