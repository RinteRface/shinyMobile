#' @importFrom shiny registerInputHandler
.onLoad <- function(...) {
  shiny::registerInputHandler("f7DatePicker.date", function(f7DatePicker.data, ...) {
    if (is.null(f7DatePicker.data) || length(f7DatePicker.data) < 1) {
      NULL
    } else {
      f7DatePicker.date <- unlist(f7DatePicker.data)
      if (is.numeric(f7DatePicker.date)) {
        f7DatePicker.date <- as.POSIXct(f7DatePicker.date / 1000, tz = "UTC", origin = "1970-01-01")
      } else {
        f7DatePicker.date <- as.POSIXct(f7DatePicker.date, format = "%Y-%m-%dT%H:%M:%S", tz = "UTC")
      }
      as.Date(f7DatePicker.date, tz = Sys.timezone())
    }
  }, force = TRUE)
}
