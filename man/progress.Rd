% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/f7Progress.R
\name{f7Progress}
\alias{f7Progress}
\alias{updateF7Progress}
\title{Framework7 progress bar}
\usage{
f7Progress(id, value = NULL, color)

updateF7Progress(id, value, session = shiny::getDefaultReactiveDomain())
}
\arguments{
\item{id}{Progress id. Must be unique.}

\item{value}{Progress value. Between 0 and 100.
If NULL the progress bar is infinite.}

\item{color}{Progress color.
See \url{https://framework7.io/docs/progressbar.html}.}

\item{session}{Shiny session object.}
}
\description{
\code{f7Progress} creates a progress bar.

\code{updateF7Progress} update a framework7 progress bar from the server side
}
\examples{
library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Update Progress",
    f7SingleLayout(
      navbar = f7Navbar(title = "f7Progress"),
      f7BlockTitle("Progress with value"),
      f7Block(
        f7Progress(id = "pg1", value = 10, color = "blue")
      ),
      f7Slider(
        inputId = "obs",
        label = "Progress value",
        max = 100,
        min = 0,
        value = 50,
        scale = TRUE
      ),
      f7BlockTitle("Infinite progress"),
      f7Block(
        f7Progress(id = "pg2", value = NULL, color = "red")
      )
    )
  ),
  server = function(input, output, session) {
    observeEvent(input$obs, {
      updateF7Progress(id = "pg1", value = input$obs)
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
}
