% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/f7Navbar.R
\name{f7Navbar}
\alias{f7Navbar}
\alias{f7HideNavbar}
\alias{updateF7Navbar}
\title{Framework7 Navbar}
\usage{
f7Navbar(
  ...,
  subNavbar = NULL,
  title = NULL,
  subtitle = NULL,
  hairline = TRUE,
  shadow = TRUE,
  bigger = FALSE,
  transparent = FALSE,
  leftPanel = FALSE,
  rightPanel = FALSE
)

f7HideNavbar(
  animate = TRUE,
  hideStatusbar = FALSE,
  session = shiny::getDefaultReactiveDomain()
)

updateF7Navbar(
  animate = TRUE,
  hideStatusbar = FALSE,
  session = shiny::getDefaultReactiveDomain()
)
}
\arguments{
\item{...}{Slot for \link{f7SearchbarTrigger}. Not compatible with \link{f7Panel}.}

\item{subNavbar}{\link{f7SubNavbar} slot, if any.}

\item{title}{Navbar title.}

\item{subtitle}{Navbar subtitle. Not compatible with bigger.}

\item{hairline}{Whether to display a thin border on the top of the navbar. TRUE by default.}

\item{shadow}{Whether to display a shadow. TRUE by default.}

\item{bigger}{Whether to display bigger title. FALSE by default. Not
compatible with subtitle.}

\item{transparent}{Whether the navbar should be transparent. FALSE by default.
Only works if bigger is TRUE.}

\item{leftPanel}{Whether to enable the left panel. FALSE by default.}

\item{rightPanel}{Whether to enable the right panel. FALSE by default.}

\item{animate}{Whether it should be hidden with animation or not. By default is TRUE.}

\item{hideStatusbar}{When FALSE (default) it hides navbar partially keeping space
required to cover statusbar area. Otherwise, navbar will be fully hidden.}

\item{session}{Shiny session object.}
}
\description{
Build a navbar layout element to insert in \link{f7SingleLayout},
\link{f7TabLayout} or \link{f7SplitLayout}.

\link{f7HideNavbar} hides a \link{f7Navbar} component from the
server. Deprecated, use \link{updateF7Navbar} instead.

\link{updateF7Navbar} toggles a \link{f7Navbar} component from the
server.
}
\note{
Currently, bigger parameters does mess with the CSS.
}
\examples{
if (interactive()) {
 library(shiny)
 library(shinyMobile)

 shinyApp(
    ui = f7Page(
       title = "Hide navbar",
       f7SingleLayout(
          navbar = f7Navbar("Hide/Show navbar"),
          f7Segment(
             f7Button(inputId = "hide", "Hide navbar", color = "red"),
             f7Button(inputId = "show", "Show navbar", color = "green"),
          )
       )
    ),
    server = function(input, output, session) {

       observeEvent(input$hide, {
          f7HideNavbar()
       })

       observeEvent(input$show, {
          f7ShowNavbar()
       })
    }
 )
}
# Toggle f7Navbar
if (interactive()) {
 library(shiny)
 library(shinyMobile)

 shinyApp(
    ui = f7Page(
       title = "Show navbar",
       f7SingleLayout(
          navbar = f7Navbar("Hide/Show navbar"),
          f7Button(inputId = "toggle", "Toggle navbar", color = "red")
       )
    ),
    server = function(input, output, session) {

       observeEvent(input$toggle, {
          updateF7Navbar()
       })
    }
 )
}
}
\author{
David Granjon, \email{dgranjon@ymail.com}
}