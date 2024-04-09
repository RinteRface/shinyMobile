library(shiny)
library(shiny.router)
library(shinyMobile)

root_page <- shiny::tags$div(
    class = "page",
    # top navbar goes here
    f7Navbar("Main page"),
    f7Toolbar(
        position = "bottom",
        a(href = route_link("other"), "Another page")
        # tags$a(
        #  href = "/other/",
        #  `data-animate` = "true",
        #  `data-reload-current` = "true",
        #  "Other page"
        #  )
    ),
    shiny::tags$div(
        class = "page-content",
        # page content
        f7Block("Page 1")
    )
)
other_page <- shiny::tags$div(
    class = "page",
    # top navbar goes here
    f7Navbar("Other page"),
    f7Toolbar(
        position = "bottom",
        tags$a(
            href = route_link("/"),
            `data-animate` = "true",
            `data-reload-current` = "true",
            "Main page",
            class = "back"
        )
    ),
    shiny::tags$div(
        class = "page-content",
        # page content
        f7Block("Other page")
    )
)

f7Route <- function(page, path, main = TRUE, name) {
    tmp <- route(path, root_page)
    if (main) {
        tmp[[path]]$ui$attribs$class <- paste(
            tmp[[path]]$ui$attribs$class,
            "view view-main tab tab-active"
        )
    } else {
        tmp[[path]]$ui$attribs$class <- paste(
            tmp[[path]]$ui$attribs$class,
            sprintf("view view-%s tab", name)
        )
    }
    tmp[[path]]$ui$attribs$`data-url` <- path
    tmp[[path]]$ui$attribs$`data-path` <- path
    tmp[[path]]$ui$attribs$`data-name` <- name
    tmp
}

router <- router_ui(
    f7Route(root_page, "/", name = "main"),
    f7Route(other_page, "/other", main = FALSE, name = "other")
)
router[[2]][[2]]$attribs$class <- paste(
    router[[2]][[2]]$attribs$class,
    "views tabs"
)

ui <- f7Page(
    title = "My app",
    options = list(
        dark = TRUE,
        routes = list(
            list(path = "/", url = "/"),
            list(path = "/other", url = "/other")
        )
    ),
    router
)

server <- function(input, output, session) {
    router_server()
}

shinyApp(ui, server)
