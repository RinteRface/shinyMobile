settings_page <- function() {
  page(
    href = "/settings",
    ui = function(request) {
      tags$div(
        class = "page",
        f7Navbar(
          title = "Settings",
          leftPanel = tagList(
            tags$a(
              href = "/me",
              class = "link back",
              tags$i(class = "icon icon-back"),
              tags$span("You")
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
