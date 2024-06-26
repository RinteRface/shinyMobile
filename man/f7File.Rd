% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/f7-upload.R
\name{f7File}
\alias{f7File}
\title{File Upload Control}
\usage{
f7File(
  inputId,
  label,
  multiple = FALSE,
  accept = NULL,
  width = NULL,
  buttonLabel = "Browse...",
  placeholder = "No file selected"
)
}
\arguments{
\item{inputId}{The input slot that will be used to access the value.}

\item{label}{Display label for the control, or NULL for no label.}

\item{multiple}{Whether the user should be allowed to select and
upload multiple files at once. Does not work on older browsers, including Internet Explorer 9 and earlier.}

\item{accept}{A character vector of MIME types; gives the browser a hint of what kind of files the server is expecting.}

\item{width}{The width of the input, e.g. 400px.}

\item{buttonLabel}{The label used on the button. Can be text or an HTML tag object.}

\item{placeholder}{The text to show before a file has been uploaded.}
}
\description{
Create a file upload control that can be used
to upload one or more files.
}
\examples{
if (interactive()) {
  library(shiny)
  library(shinyMobile)

  ui <- f7Page(
    f7SingleLayout(
      navbar = f7Navbar(title = "File handling"),
      f7Block(f7File("up", "Upload!"))
    )
  )

  server <- function(input, output) {
    data <- reactive(input$up)
    observe(print(data()))
  }

  shinyApp(ui, server)
}
}
