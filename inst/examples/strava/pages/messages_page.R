user_choices <- f7CheckboxGroup(
  "message-user",
  "New Messages",
  position = "right",
  choices = colnames(mtcars)[c(1, 3)],
  style = list(
    inset = FALSE,
    outline = FALSE,
    dividers = TRUE,
    strong = TRUE
  )
)
user_choices[[2]] <- f7Found(user_choices[[2]])

messages_page <- function() {
  page(
    href = "/messages",
    ui = function(request) {
      tags$div(
        class = "page",
        f7Navbar(
          title = "Messages",
          leftPanel = tagList(
            tags$a(
              href = "/",
              class = "link",
              tags$i(class = "icon icon-back"),
              tags$span("Home")
            )
          ),
          rightPanel = tagList(
            tags$a(
              href = "#",
              class = "link sheet-open",
              f7Icon("square_pencil"),
              `data-sheet` = "#new-message"
            ),
            # Messaging options
            f7Link(
              icon = f7Icon("gear_alt"),
              href = "#"
            )
          )
        ),
        tags$div(
          class = "page-content",
          f7Sheet(
            id = "new-message",
            orientation = "bottom",
            swipeToClose = TRUE,
            options = list(
              push = TRUE
            ),
            f7Searchbar(
              id = NULL,
              placeholder = "Search people who follow you"
            ),
            # TO DO: fix broken search
            user_choices,
            f7Block(
              p("No result found for your search")
            ) %>% f7NotFound()
          )
        )
      )
    }
  )
}
