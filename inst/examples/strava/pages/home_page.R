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
