#' Framework7 swiper
#'
#' \code{f7Swiper} creates a Framework7 swiper container (like carousel).
#'
#' @param ... Slot for \link{f7Slide}.
#' @param id Swiper unique id.
#' @param options Other options. Expect a list.
#' See \url{https://swiperjs.com/swiper-api} for all available options.
#'
#' @rdname swiper
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyMobile)
#'
#'  timeline <- f7Timeline(
#'   sides = TRUE,
#'   f7TimelineItem(
#'    "Another text",
#'    date = "01 Dec",
#'    card = FALSE,
#'    time = "12:30",
#'    title = "Title",
#'    subtitle = "Subtitle",
#'    side = "left"
#'   ),
#'   f7TimelineItem(
#'    "Another text",
#'    date = "02 Dec",
#'    card = TRUE,
#'    time = "13:00",
#'    title = "Title",
#'    subtitle = "Subtitle"
#'   ),
#'   f7TimelineItem(
#'    "Another text",
#'    date = "03 Dec",
#'    card = FALSE,
#'    time = "14:45",
#'    title = "Title",
#'    subtitle = "Subtitle"
#'   )
#'  )
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'     title = "Swiper",
#'     f7SingleLayout(
#'      navbar = f7Navbar(title = "f7Swiper"),
#'      f7Swiper(
#'       id = "my-swiper",
#'       f7Slide(
#'        timeline
#'       ),
#'       f7Slide(
#'        f7Toggle(
#'         inputId = "toggle",
#'         label = "My toggle",
#'         color = "pink",
#'         checked = TRUE
#'        ),
#'        verbatimTextOutput("test")
#'       ),
#'       f7Slide(
#'        f7Slider(
#'         inputId = "obs",
#'         label = "Number of observations",
#'         max = 1000,
#'         min = 0,
#'         value = 100,
#'         scaleSteps = 5,
#'         scaleSubSteps = 3,
#'         scale = TRUE,
#'         color = "orange",
#'         labels = tagList(
#'           f7Icon("circle"),
#'           f7Icon("circle_fill")
#'         )
#'        ),
#'        plotOutput("distPlot")
#'       )
#'      )
#'     )
#'    ),
#'    server = function(input, output) {
#'     output$test <- renderPrint(input$toggle)
#'     output$distPlot <- renderPlot({
#'     hist(rnorm(input$obs))
#'    })
#'    }
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Swiper <- function(
  ...,
  id,
  options = list(
    speed = 400,
    loop = FALSE,
    spaceBetween = 50,
    slidesPerView = "auto",
    centeredSlides = TRUE,
    navigation = list(
      nextEl = ".swiper-button-next",
      prevEl = ".swiper-button-prev"
    ),
    pagination = list(el = ".swiper-pagination"),
    scrollbar = list(el = ".swiper-scrollbar")
  )
) {
  # swiper class
  swiperCl <- "swiper swiper-container"

  swiper_config <- shiny::tags$script(
    type = "application/json",
    `data-for` = id,
    jsonlite::toJSON(
      x = options,
      auto_unbox = TRUE,
      json_verbatim = TRUE
    )
  )

  # swiper tag
  shiny::tags$div(
    class = swiperCl,
    id = id,
    shiny::tags$div(
      class = "swiper-wrapper",
      ...
    ),
    if (!is.null(options$pagination)) shiny::tags$div(class = "swiper-pagination"),
    if (!is.null(options$navigation)) {
      list(
        shiny::tags$div(class ="swiper-button-prev"),
        shiny::tags$div(class ="swiper-button-next")
      )
    },
    if (!is.null(options$scrollbar)) shiny::tags$div(class = "swiper-scrollbar"),
    swiper_config
  )
}





#' Framework7 slide
#'
#' \code{f7Slide} is an \link{f7Swiper} element.
#'
#' @param ... Slide content. Any element.
#'
#' @export
f7Slide <- function(...) {
  shiny::tags$div(class = "swiper-slide", ...)
}
