#' @importFrom shiny registerInputHandler
.onLoad <- function(...) {
  shiny::registerInputHandler("f7DatePicker.date", function(data, ...) {
    if (is.null(data) || length(data) < 1) {
      NULL
    } else {
      date <- data[[1]]
      if (is.null(date))
        return(NULL)
      if (is.numeric(date)) {
        date <- as.POSIXct(date / 1000, tz = "UTC", origin = "1970-01-01")
      } else {
        date <- as.POSIXct(date, format = "%Y-%m-%dT%H:%M:%S", tz = "UTC")
      }
      as.Date(date, tz = Sys.timezone())
    }
  }, force = TRUE)
}
