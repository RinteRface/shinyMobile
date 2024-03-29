% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/f7Swiper.R
\name{f7Swiper}
\alias{f7Swiper}
\title{Framework7 swiper}
\usage{
f7Swiper(
  ...,
  id,
  options = list(speed = 400, loop = FALSE, spaceBetween = 50, slidesPerView = "auto",
    centeredSlides = TRUE, navigation = list(nextEl = ".swiper-button-next", prevEl =
    ".swiper-button-prev"), pagination = list(el = ".swiper-pagination", clickable =
    TRUE), scrollbar = list(el = ".swiper-scrollbar", draggable = TRUE))
)
}
\arguments{
\item{...}{Slot for \link{f7Slide}.}

\item{id}{Swiper unique id.}

\item{options}{Other options. Expect a list.
See \url{https://swiperjs.com/swiper-api} for all available options.}
}
\description{
\code{f7Swiper} creates a Framework7 swiper container (like carousel).
}
\examples{
if(interactive()){
 library(shiny)
 library(shinyMobile)

 timeline <- f7Timeline(
  sides = TRUE,
  f7TimelineItem(
   "Another text",
   date = "01 Dec",
   card = FALSE,
   time = "12:30",
   title = "Title",
   subtitle = "Subtitle",
   side = "left"
  ),
  f7TimelineItem(
   "Another text",
   date = "02 Dec",
   card = TRUE,
   time = "13:00",
   title = "Title",
   subtitle = "Subtitle"
  ),
  f7TimelineItem(
   "Another text",
   date = "03 Dec",
   card = FALSE,
   time = "14:45",
   title = "Title",
   subtitle = "Subtitle"
  )
 )

 shiny::shinyApp(
   ui = f7Page(
    title = "Swiper",
    f7SingleLayout(
     navbar = f7Navbar(title = "f7Swiper"),
     f7Swiper(
      id = "my-swiper",
      f7Slide(
       timeline
      ),
      f7Slide(
       f7Toggle(
        inputId = "toggle",
        label = "My toggle",
        color = "pink",
        checked = TRUE
       ),
       verbatimTextOutput("test")
      ),
      f7Slide(
       f7Slider(
        inputId = "obs",
        label = "Number of observations",
        max = 1000,
        min = 0,
        value = 100,
        scaleSteps = 5,
        scaleSubSteps = 3,
        scale = TRUE,
        color = "orange",
        labels = tagList(
          f7Icon("circle"),
          f7Icon("circle_fill")
        )
       ),
       plotOutput("distPlot")
      )
     )
    )
   ),
   server = function(input, output) {
    output$test <- renderPrint(input$toggle)
    output$distPlot <- renderPlot({
    hist(rnorm(input$obs))
   })
   }
 )
}

}
\author{
David Granjon, \email{dgranjon@ymail.com}
}
