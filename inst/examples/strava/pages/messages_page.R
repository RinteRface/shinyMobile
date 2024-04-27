new_message_ui <- function(id) {
  ns <- shiny::NS(id)
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
      ns <- session$ns

      observeEvent(input$new_message, {
        f7Popup(
          id = "new-message-popup",
          title = "New Message",
          # TO DO: fix broken search
          f7SmartSelect(
            ns("message_user"),
            "Contacts",
            choices = colnames(mtcars)[c(1, 3)],
            openIn = "popup",
            multiple = TRUE
          )
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
