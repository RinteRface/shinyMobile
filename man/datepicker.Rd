% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/f7-inputs.R
\name{f7DatePicker}
\alias{f7DatePicker}
\alias{updateF7DatePicker}
\title{Framework7 date picker}
\usage{
f7DatePicker(
  inputId,
  label,
  value = NULL,
  multiple = FALSE,
  direction = c("horizontal", "vertical"),
  minDate = NULL,
  maxDate = NULL,
  dateFormat = "yyyy-mm-dd",
  openIn = c("auto", "popover", "sheet", "customModal"),
  scrollToInput = FALSE,
  closeByOutsideClick = TRUE,
  toolbar = TRUE,
  toolbarCloseText = "Done",
  header = FALSE,
  headerPlaceholder = "Select date",
  style = list(outline = FALSE, inset = FALSE, strong = FALSE, dividers = FALSE),
  ...
)

updateF7DatePicker(
  inputId,
  value = NULL,
  ...,
  session = shiny::getDefaultReactiveDomain()
)
}
\arguments{
\item{inputId}{Date input id.}

\item{label}{Input label.}

\item{value}{Array with initial selected dates. Each array item represents selected date.
If timePicker enabled, the value needs to be an object of type POSIXct.}

\item{multiple}{If \code{TRUE} allow to select multiple dates.}

\item{direction}{Months layout direction, could be 'horizontal' or 'vertical'.}

\item{minDate}{Minimum allowed date.}

\item{maxDate}{Maximum allowed date.}

\item{dateFormat}{Date format: "yyyy-mm-dd", for instance.}

\item{openIn}{Can be auto, popover (to open calendar in popover), sheet
(to open in sheet modal) or customModal (to open in custom Calendar modal overlay).
In case of auto will open in sheet modal on small screens and in popover on large screens.}

\item{scrollToInput}{Scroll viewport (page-content) to input when calendar opened.}

\item{closeByOutsideClick}{If enabled, picker will be closed by clicking outside of picker or related input element.}

\item{toolbar}{Enables calendar toolbar.}

\item{toolbarCloseText}{Text for Done/Close toolbar button.}

\item{header}{Enables calendar header.}

\item{headerPlaceholder}{Default calendar header placeholder text.}

\item{style}{Input style. Inherit from \link{f7List} options
such as outline, inset, strong and dividers.}

\item{...}{Other options to pass to the picker. See
\url{https://framework7.io/docs/calendar#calendar-parameters}.}

\item{session}{The Shiny session object, usually the default value will suffice.}
}
\value{
a \code{Date} vector.
}
\description{
\code{f7DatePicker} creates a Framework7 date picker input.

\code{updateF7DatePicker} changes the value of a date picker input on the client.
}
\examples{
library(shiny)
library(shinyMobile)

app <- shinyApp(
  ui = f7Page(
    title = "My app",
    f7SingleLayout(
      navbar = f7Navbar(title = "Update date picker"),
      f7Segment(
        f7Button(inputId = "update", label = "Update"),
        f7Button(inputId = "rmToolbar", label = "Remove toolbar"),
        f7Button(inputId = "addToolbar", label = "Add toolbar")
      ),
      f7Segment(
        f7Button(inputId = "removeTime", label = "Remove time"),
        f7Button(inputId = "addTime", label = "Add time")
      ),
      f7DatePicker(
        inputId = "picker",
        label = "Choose a date and time",
        value = as.POSIXct("2024-03-24 09:00:00 UTC"),
        openIn = "auto",
        direction = "horizontal",
        timePicker = TRUE,
        dateFormat = "yyyy-mm-dd, HH::mm"
      ),
      f7Block(verbatimTextOutput("pickerval"))
    )
  ),
  server = function(input, output, session) {
    output$pickerval <- renderPrint(input$picker)

    observeEvent(input$update, {
      updateF7DatePicker(
        inputId = "picker",
        value = as.POSIXct("2024-03-23 10:00:00 UTC"),
        timePicker = TRUE,
        dateFormat = "yyyy-mm-dd, HH::mm" # preserve date format
      )
    })

    observeEvent(input$rmToolbar, {
      updateF7DatePicker(
        inputId = "picker",
        timePicker = TRUE,
        toolbar = FALSE,
        dateFormat = "yyyy-mm-dd, HH::mm" # preserve date format
      )
    })

    observeEvent(input$addToolbar, {
      updateF7DatePicker(
        inputId = "picker",
        timePicker = TRUE,
        toolbar = TRUE,
        dateFormat = "yyyy-mm-dd, HH::mm" # preserve date format
      )
    })

    observeEvent(input$removeTime, {
      updateF7DatePicker(
        inputId = "picker",
        value = as.Date(input$picker),
        timePicker = FALSE,
        dateFormat = "yyyy-mm-dd" # new date format
      )
    })

    observeEvent(input$addTime, {
      updateF7DatePicker(
        inputId = "picker",
        value = as.POSIXct(input$picker),
        timePicker = TRUE,
        dateFormat = "yyyy-mm-dd, HH::mm" # preserve date format
      )
    })
  }
)

if (interactive() || identical(Sys.getenv("TESTTHAT"), "true")) app
}
