% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/f7Toolbar.R
\name{f7Toolbar}
\alias{f7Toolbar}
\title{Framework7 Toolbar}
\usage{
f7Toolbar(
  ...,
  position = c("bottom", "top"),
  hairline = deprecated(),
  shadow = deprecated(),
  icons = FALSE,
  scrollable = FALSE
)
}
\arguments{
\item{...}{Slot for \link{f7Link} or any other element.}

\item{position}{Tabs position: "top" or "bottom". Or use different positions for iOS, MD themes
by using: "top-ios", "top-md", "bottom-ios", or "bottom-md".}

\item{hairline}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}:
removed from Framework7.}

\item{shadow}{\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#deprecated}{\figure{lifecycle-deprecated.svg}{options: alt='[Deprecated]'}}}{\strong{[Deprecated]}}:
removed from Framework7.}

\item{icons}{Whether to use icons instead of text. Either ios or md icons.}

\item{scrollable}{Whether to allow scrolling. FALSE by default.}
}
\description{
\code{f7Toolbar} is a layout element located at the bottom or top. It is
internally used by \link{f7Tabs} and can be used in the toolbar slot of
\link{f7Page}.
}
\examples{
library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Toolbar",
    toolbar = f7Toolbar(
      icons = TRUE,
      f7Link(
        label = "Link 1",
        href = "https://www.google.com",
        icon = f7Icon("link_circle_fill")
      ),
      f7Link(
        label = "Link 2",
        href = "https://maps.google.com",
        icon = f7Icon("location_circle_fill")
      )
    )
  ),
  server = function(input, output, session) {
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
}
\author{
David Granjon, \email{dgranjon@ymail.com}
}
