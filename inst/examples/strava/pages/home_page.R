add_post_ui <- function(id) {
  ns <- shiny::NS(id)
  tagList(
    tags$a(
      href = "#",
      class = "link sheet-open",
      f7Icon("splus_circle"),
      `data-sheet` = sprintf("#%s", ns("sheet"))
    ),
    f7Sheet(
      id = ns("sheet"),
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
        tagAppendAttributes(
          f7Link(
            href = "#",
            icon = f7Icon("pencil"),
            label = "Manual"
          ),
          id = ns("manual_post"),
          class = "action-button"
        )
      )
    )
  )
}

add_post <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns

      observeEvent(input$manual_post, {
        # Close sheet
        updateF7Sheet("sheet")
        # Open popup
        f7Popup(
          id = "manual_pos_popup",
          title = "Add Activity",
          f7Text(
            inputId = ns("activity_name"),
            label = "Name",
            placeholder = "My activity",
            style = list(
              media = NULL,
              description = NULL,
              floating = FALSE,
              outline = TRUE,
              clearable = TRUE
            )
          ),
          f7TextArea(
            inputId = ns("activity_descr"),
            label = "Description",
            placeholder = "How'd it go? Share more
          about your activity and use @ to tag someone.",
            style = list(
              media = NULL,
              description = NULL,
              floating = FALSE,
              outline = TRUE,
              clearable = TRUE
            )
          ),
          f7Select(
            inputId = ns("activity_type"),
            "Type",
            choices = c("Walk", "Ride")
          )
        )
      })

      observe({
        print(input$activity_type)
      })
    }
  )
}

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
            add_post_ui("new")[[1]],
            f7Link(icon = f7Icon("search"), href = "#")
          ),
          rightPanel = tagList(
            f7Link(
              icon = f7Icon("chat_bubble_text"),
              href = "/messages",
              routable = TRUE
            ),
            f7Link(icon = f7Icon("bell"), href = "#")
          )
        ),
        tags$div(
          class = "page-content",
          add_post_ui("new")[[2]]
        )
      )
    }
  )
}
