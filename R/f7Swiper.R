#' Framework7 swiper
#'
#' \link{f7Swiper} creates a Framework7 swiper container (like carousel).
#'
#' @param ... Slot for \link{f7Slide}.
#' @param id Swiper unique id.
#' @param options Other options. Expect a list.
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
#'      id = "my-swiper",
#'      f7Slide(
#'       timeline
#'      ),
#'      f7Slide(
#'       f7Toggle(
#'        inputId = "toggle",
#'        label = "My toggle",
#'        color = "pink",
#'        checked = TRUE
#'       ),
#'       verbatimTextOutput("test")
#'      )
#'     )
#'     )
#'    ),
#'    server = function(input, output) {
#'     output$test <- renderPrint(input$toggle)
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
    spaceBetween = 50,
    slidesPerView = "auto",
    centeredSlides = TRUE,
    pagination = TRUE
  )
) {
  # swiper class
  swiperCl <- "swiper-container demo-swiper"
  if (!is.null(options$slidePerView)) {
    if (options$slidePerView == "auto") swiperCl <- paste0(swiperCl, " demo-swiper-auto")
  }

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
    shiny::tags$div(class = paste0("swiper-pagination")),
    shiny::tags$div(
      class = "swiper-wrapper",
      ...
    ),
    swiper_config
  )
}





#' Framework7 slide
#'
#' \link{f7Slide} is a \link{f7Swiper} element.
#'
#' @param ... Slide content. Any element.
#'
#' @export
f7Slide <- function(...) {
  shiny::tags$div(class = "swiper-slide", ...)
}
