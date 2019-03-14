#' Create a Framework7 swiper
#'
#' Build a Framework7 swiper (like carousel)
#'
#' @param ... Slot for \link{f7Slide}.
#' @param pagination Whether to show pagination. TRUE by default.
#' @param space Space between slides. 50 by default. Only if pagination is TRUE.
#' @param n_slides Number of slides at a time. Only if pagination is TRUE. Set to "auto" by default.
#' @param centered Whether to center slides. Only if pagination is TRUE.
#' @param vertical Whether to display slides vertically. FALSE by default. Only if pagination is TRUE.
#' @param speed Slides speed. Numeric.
#'
#' @note Does not work
#'
#' @examples
#' if(interactive()){
#'  library(shiny)
#'  library(shinyF7)
#'
#'  shiny::shinyApp(
#'    ui = f7Page(
#'     title = "My app",
#'     f7Init(theme = "auto"),
#'     actionButton("newplot", "New plot"),
#'     f7Swiper(
#'      f7Slide("Slide 1"),
#'      f7Slide(plotOutput("plot"))
#'     )
#'    ),
#'    server = function(input, output) {
#'      output$plot <- renderPlot({
#'       input$newplot
#'       # Add a little noise to the cars data
#'       cars2 <- cars + rnorm(nrow(cars))
#'       plot(cars2)
#'      })
#'    }
#'  )
#' }
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Swiper <- function(..., pagination = TRUE, space = 50, n_slides = "auto",
                     centered = TRUE, vertical = FALSE, speed = 900) {

  # only generate if pagination is TRUE
  if (pagination) {
    data_swiper <- data.frame(
      pagination = jsonlite::fromJSON('{"el": ".swiper-pagination"}'),
      slidesPerView = paste(n_slides),
      spaceBetween = paste(space),
      centeredSlides = centered,
      direction = vertical,
      speed = paste(speed)
    )
    data_swiper <- jsonlite::toJSON(data_swiper)
  }

  swiperCl <- "swiper-container swiper-init demo-swiper swiper-container-horizontal"
  if (n_slides == "auto") swiperCl <- paste0(swiperCl, " demo-swiper-auto")

 shiny::tags$div(
   class = swiperCl,
   `data-pagination` = "{'el': '.swiper-pagination'}",
   #`data-swiper` = if (pagination) data_swiper else NULL,
   if (pagination) shiny::tags$div(class = "swiper-pagination"),
   shiny::tags$div(
     class = "swiper-wrapper",
     ...
   )
 )
}


#f7Swiper <- function(..., id) {
#
#
#  swiperCl <- "swiper-container demo-swiper"
#
#  swiperTag <- shiny::tags$div(
#    class = swiperCl,
#    id = id,
#    #shiny::tags$div(class = "swiper-pagination"),
#    shiny::tags$div(
#      class = "swiper-wrapper",
#      ...
#    )
#  )
#
#  shiny::tagList(
#    shiny::tags$head(
#      shiny::tags$script(
#        paste0(
#          "var swiper = app.swiper.create('#", id, "', {
#          speed: 400,
#          spaceBetween: 100
#        });
#       "
#        )
#      )
#    ),
#    swiperTag
#  )
#
#}




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
