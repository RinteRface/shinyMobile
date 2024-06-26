% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/f7-inputs.R
\name{f7SmartSelect}
\alias{f7SmartSelect}
\alias{updateF7SmartSelect}
\title{Framework7 smart select}
\usage{
f7SmartSelect(
  inputId,
  label,
  choices,
  selected = NULL,
  openIn = c("page", "sheet", "popup", "popover"),
  searchbar = TRUE,
  multiple = FALSE,
  maxLength = NULL,
  virtualList = FALSE,
  ...
)

updateF7SmartSelect(
  inputId,
  selected = NULL,
  choices = NULL,
  multiple = NULL,
  maxLength = NULL,
  ...,
  session = shiny::getDefaultReactiveDomain()
)
}
\arguments{
\item{inputId}{Select input id.}

\item{label}{Select input label.}

\item{choices}{Select input choices.}

\item{selected}{Default selected item. If NULL, the first item is selected.}

\item{openIn}{Smart select type: either \code{c("sheet", "popup", "popover")}.
Note that the search bar is only available when the type is popup.}

\item{searchbar}{Whether to enable the search bar. TRUE by default.}

\item{multiple}{Whether to allow multiple values. FALSE by default.}

\item{maxLength}{Maximum items to select when multiple is TRUE.}

\item{virtualList}{Enable Virtual List for smart select if your select has a lot
of options. Default to FALSE.}

\item{...}{Other options. See \url{https://framework7.io/docs/smart-select#smart-select-parameters}.}

\item{session}{The Shiny session object, usually the default value will suffice.}
}
\description{
\code{f7SmartSelect} is smarter than the classic \link{f7Select},
allows for choices filtering, ...

\code{updateF7SmartSelect} changes the value of a smart select input on the client.
}
\examples{
library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "Update f7SmartSelect",
    f7SingleLayout(
      navbar = f7Navbar(title = "Update f7SmartSelect"),
      f7Block(f7Button("update", "Update Smart Select")),
      f7List(
        inset = TRUE,
        strong = TRUE,
        outline = TRUE,
        f7SmartSelect(
          inputId = "smartselect",
          label = "Choose a variable:",
          choices = split(colnames(mtcars[-1]), rep(1:5)),
          openIn = "popup"
        )
      ),
      tableOutput("data")
    )
  ),
  server = function(input, output, session) {
    output$data <- renderTable(
      mtcars[, c("mpg", input$smartselect), drop = FALSE],
      rownames = TRUE
    )

    observeEvent(input$update, {
      updateF7SmartSelect(
        inputId = "smartselect",
        openIn = "sheet",
        selected = "hp",
        choices = c("hp", "gear", "carb"),
        multiple = TRUE,
        maxLength = 2
      )
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
}
