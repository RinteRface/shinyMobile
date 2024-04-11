library(shiny)
library(brochure)
library(shinyMobile)

links <- lapply(2:3, function(i) {
  tags$li(
    f7Link(
      routable = TRUE,
      label = sprintf("Link to page %s", i),
      href = sprintf("/%s", i)
    )
  )
})

page_1 <- function() {
  page(
    href = "/",
    ui = function(request) {
      shiny::tags$div(
        class = "page",
        # top navbar goes here
        f7Navbar("Home page"),
        tags$div(
          class = "page-content",
          f7List(
            inset = TRUE,
            strong = TRUE,
            outline = TRUE,
            dividers = TRUE,
            mode = "links",
            links
          )
        )
      )
    },
    # Important: in theory brochure makes
    # each page having its own shiny session.
    # That's not what we want here so only the first
    # page has the entire server function.
    # Other pages only provide the UI which is
    # included by Framework7 router.
    server = function(input, output, session) {
      output$res <- renderText(input$text)
      output$test <- renderPrint(input$stepper)

      observeEvent(input$update, {
        updateF7Stepper(
          inputId = "stepper",
          value = 0.1,
          step = 0.01,
          size = "large",
          min = 0,
          max = 1,
          wraps = FALSE,
          autorepeat = FALSE,
          rounded = TRUE,
          raised = TRUE,
          color = "pink",
          manual = TRUE,
          decimalPoint = 2
        )
      })
    }
  )
}

page_2 <- function() {
  page(
    href = "/2",
    ui = function(request) {
      shiny::tags$div(
        class = "page",
        # top navbar goes here
        f7Navbar(
          "Second page",
          # Allows to go back to main
          leftPanel = tags$a(
            href = "/",
            class = "link",
            tags$i(class = "icon icon-back"),
            tags$span(
              class = "if-not-md",
              "Back"
            )
          )
        ),
        f7Toolbar(
          position = "bottom",
          tags$a(
            href = "/",
            "Main page",
            class = "link"
          )
        ),
        shiny::tags$div(
          class = "page-content", f7Block(
            strong = TRUE,
            inset = TRUE,
            outline = TRUE,
            f7Block(f7Button(inputId = "update", label = "Update stepper")),
            f7Block(
              strong = TRUE,
              inset = TRUE,
              outline = TRUE,
              f7Stepper(
                inputId = "stepper",
                label = "My stepper",
                min = 0,
                max = 10,
                size = "small",
                value = 4,
                wraps = TRUE,
                autorepeat = TRUE,
                rounded = FALSE,
                raised = FALSE,
                manual = FALSE,
                layout = "list"
              ),
              verbatimTextOutput("test")
            )
          )
        )
      )
    }
  )
}

page_3 <- function() {
  page(
    href = "/3",
    ui = function(request) {
      shiny::tags$div(
        class = "page",
        # top navbar goes here
        f7Navbar(
          "Third page",
          # Allows to go back to main
          leftPanel = tags$a(
            href = "/",
            class = "link",
            tags$i(class = "icon icon-back"),
            tags$span(
              class = "if-not-md",
              "Back"
            )
          )
        ),
        f7Toolbar(
          position = "bottom",
          tags$a(
            href = "/2",
            "Second page",
            class = "link"
          )
        ),
        shiny::tags$div(
          class = "page-content",
          f7Block("Nothing to show yet ...")
        )
      )
    }
  )
}

brochureApp(
  # Pages
  page_1(),
  page_2(),
  page_3(),
  wrapped = f7Page,
  wrapped_options = list(
    allowRouter = TRUE,
    options = list(
      dark = TRUE,
      # Note: ios seems to have issue
      # with the sidebar title
      theme = "md",
      routes = list(
        list(path = "/", url = "/", name = "home"),
        # Important: don't remove keepalive
        # for child pages as this allows
        # to save the input state when switching
        # between pages. If FALSE, each time a page is
        # changed, inputs are reset (except on the first page).
        list(path = "/2", url = "/2", name = "2", keepAlive = TRUE),
        list(path = "/3", url = "/3", name = "3", keepAlive = TRUE)
      )
    )
  )
)
