new_message_ui <- function(id) {
  ns <- shiny::NS(id)

  user_choices <- f7CheckboxGroup(
    ns("message_user"),
    "Contacts",
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

  tagAppendAttributes(
    f7Link(
      href = "#",
      icon = f7Icon("square_pencil")
    ),
    id = ns("new_message"),
    class = "action-button"
  )
}

new_message <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      observeEvent(input$new_message, {
        f7Popup(
          id = "new-message-popup",
          title = "New Message",
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
      })
    }
  )
}

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
              class = "link back",
              tags$i(class = "icon icon-back"),
              tags$span("Home")
            )
          ),
          rightPanel = tagList(
            new_message_ui("mod1"),
            # Messaging options
            f7Link(
              icon = f7Icon("gear_alt"),
              href = "#"
            )
          )
        ),
        tags$div(
          class = "page-content"
        )
      )
    }
  )
}
