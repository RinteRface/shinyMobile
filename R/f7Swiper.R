#' Create a Framework7 swiper
#'
#' Build a Framework7 swiper (like carousel)
#'
#' @param ... Slot for \link{f7Slide}.
#' @param id Swiper unique id.
#' @param spaceBetween Space between slides. 50 by default. Only if pagination is TRUE.
#' @param slidePerView Number of slides at a time. Only if pagination is TRUE. Set to "auto" by default.
#' @param centered Whether to center slides. Only if pagination is TRUE.
#' @param speed Slides speed. Numeric.
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
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
#'     title = "My app",
#'     f7Init(theme = "auto"),
#'     f7Swiper(
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
f7Swiper <- function(..., id, spaceBetween = 50, slidePerView = "auto",
                     centered = TRUE, speed = 400) {


  # javascript init + options
  swiperJS <- shiny::singleton(
    shiny::tags$head(
      shiny::tags$script(
        paste0(
          "$(function() {
            var swiper = app.swiper.create('#", id, "', {
              speed: ", speed, ",
              spaceBetween: ", spaceBetween,",
              slidesPerView: '", slidePerView,"',
              centeredSlides: ",  tolower(centered),",
              pagination: {'el': '.swiper-pagination'}
            });
          });
        "
        )
      )
    )
  )

  # swiper class
  swiperCl <- "swiper-container demo-swiper"
  if (slidePerView == "auto") swiperCl <- paste0(swiperCl, " demo-swiper-auto")

  # swiper tag
  swiperTag <- shiny::tags$div(
    class = swiperCl,
    id = id,
    shiny::tags$div(class = paste0("swiper-pagination")),
    shiny::tags$div(
      class = "swiper-wrapper",
      ...
    )
  )


  shiny::tagList(swiperJS, swiperTag)

}





#' Create a Framework7 slide
#'
#' Build a Framework7 slide
#'
#' @param ... Any element.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Slide <- function(...) {
  shiny::tags$div(class = "swiper-slide", ...)
}
