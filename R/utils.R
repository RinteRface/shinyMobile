# Unexported usefull functions from shiny

# dropNulls
dropNulls <- function (x)
{
  x[!vapply(x, is.null, FUN.VALUE = logical(1))]
}


#' @importFrom magrittr %>%
#' @export
magrittr::`%>%`



# function needed to set up the color theme
# of the app. Generate the hex corresponding to the
# given color
colorToHex <- function(color) {
  # the default color
  if (is.null(color)) {
    "#007aff"
  } else {
    switch (color,
            "red" = "#ff3b30",
            "green" = "#4cd964",
            "blue" = "#2196f3",
            "pink" = "#ff2d55",
            "yellow" = "#ffcc00",
            "orange" = "#ff9500",
            "purple" = "#9c27b0",
            "deeppurple" = "#673ab7",
            "lightblue" = "#5ac8fa",
            "teal" = "#009688",
            "lime" = "#cddc39",
            "deeporange" = "#ff6b22",
            "gray" = "#8e8e93",
            "white" = "#ffffff",
            "black" = "#000000"
    )
  }
}



#' Function to get all colors available in shinyMobile
#'
#' @return A vector containing colors
#' @export
getF7Colors <- function() {
  colors <- c(
    "red",
    "green",
    "blue",
    "pink",
    "yellow",
    "orange",
    "purple" ,
    "deeppurple",
    "lightblue",
    "teal" ,
    "lime",
    "deeporange",
    "gray",
    "black"
  )
  colors
}


tagAppendAttributes <- function (tag, ...)
{
  tag$attribs <- c(tag$attribs, dropNulls(list(...)))
  tag
}
