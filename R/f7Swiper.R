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
#' @example inst/examples/swiper/app.R
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
      pagination = list(el = ".swiper-pagination", clickable = TRUE),
      scrollbar = list(el = ".swiper-scrollbar", draggable = TRUE)
    )) {
  # swiper tag
  shiny::tags$div(
    class = "swiper",
    id = id,
    shiny::tags$div(
      class = "swiper-wrapper",
      ...
    ),
    if (!is.null(options$pagination)) shiny::tags$div(class = "swiper-pagination"),
    if (!is.null(options$navigation)) {
      shiny::tagList(
        shiny::tags$div(class = "swiper-button-prev"),
        shiny::tags$div(class = "swiper-button-next")
      )
    },
    if (!is.null(options$scrollbar)) shiny::tags$div(class = "swiper-scrollbar"),
    buildConfig(id, options)
  )
}

#' Framework7 slide
#'
#' \code{f7Slide} is an \link{f7Swiper} element.
#'
#' @param ... Slide content. Any element.
#' @rdname swiper
#' @export
f7Slide <- function(...) {
  shiny::tags$div(class = "swiper-slide", ...)
}
