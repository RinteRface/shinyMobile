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
              class = "link back",
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
          f7List(
            mode = "media",
            strong = TRUE,
            f7ListItem(
              title = tags$strong(
                paste(
                  me$firstname,
                  me$lastname
                )
              ),
              subtitle = paste(
                me$city,
                me$state,
                sep = ", "
              ),
              media = img(
                src = me$profile,
                style = "border-radius: 50%;",
                width = "100%"
              ),
              # p(me$bio),
              f7Grid(
                cols = 4,
                f7Chip(
                  label = paste("Following:", me$friend),
                  icon = f7Icon("person_3_fill")
                ),
                f7Chip(
                  label = paste("Followers:", me$follower),
                  icon = f7Icon("person_3_fill")
                ),
                f7Button(
                  "share",
                  "Share",
                  icon = f7Icon("square_arrow_up", style = "font-size: 18px;"),
                  tonal = TRUE,
                  fill = FALSE,
                  size = "small"
                ),
                f7Button(
                  "edit",
                  "Edit",
                  icon = f7Icon("pencil", style = "font-size: 18px;"),
                  tonal = TRUE,
                  fill = FALSE,
                  size = "small"
                )
              )
            )
          )
        )
      )
    }
  )
}
