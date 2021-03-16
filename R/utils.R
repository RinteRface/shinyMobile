# Unexported usefull functions from shiny

# dropNulls
dropNulls <- function(x) {
  x[!vapply(x, is.null, FUN.VALUE = logical(1))]
}

"%OR%" <- function(a, b) if (!is.null(a)) a else b

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


validateF7Color <- function(color) {
  if (!(color %in% getF7Colors())) {
    stop("Color must be one of: ", paste(getF7Colors(), collapse = ", "))
  }
}


tagAppendAttributes <- function(tag, ...) {
  tag$attribs <- c(tag$attribs, dropNulls(list(...)))
  tag
}


shinyInputLabel <- function(inputId, label = NULL) {
  shiny::tags$label(label, class = "control-label", class = if (is.null(label)) {
    "shiny-label-null"
  }, `for` = inputId)
}



#' Attach all created dependencies in the ./R directory to the provided tag
#'
#' This function only works if there are existing dependencies. Otherwise,
#' an error is raised.
#'
#' @param tag Tag to attach the dependencies.
#' @param deps Dependencies to add. Expect a vector of names. If NULL, all dependencies
#' are added.
#' @export
add_dependencies <- function(tag, deps = NULL) {
  if (is.null(deps)) {
    temp_names <- list.files("./R", pattern = "dependencies.R$")
    deps <- unlist(lapply(temp_names, strsplit, split = "-dependencies.R"))
  }

  if (length(deps) == 0) stop("No dependencies found.")

  deps <- lapply(deps, function(x) {
    temp <- eval(
      parse(
        text = sprintf("htmltools::findDependencies(add_%s_deps(htmltools::div()))", x)
      )
    )
    # this assumes all add_*_deps function only add 1 dependency
    temp[[1]]
  })

  htmltools::tagList(tag, deps)
}


# Popovers utils
validateSelector <- function(id, selector) {
  if (!is.null(id) && !is.null(selector)) {
    stop("Please choose either target or selector!")
  }
}


sendCustomMessage <- function(type, message, session) {
  session$sendCustomMessage(
    type,
    jsonlite::toJSON(
      message,
      auto_unbox = TRUE,
      json_verbatim = TRUE
    )
  )
}



# Given a Shiny tag object, process singletons and dependencies. Returns a list
# with rendered HTML and dependency objects.
processDeps <- function (tags, session) {
  ui <- htmltools::takeSingletons(tags, session$singletons, desingleton = FALSE)$ui
  ui <- htmltools::surroundSingletons(ui)
  dependencies <- lapply(htmltools::resolveDependencies(htmltools::findDependencies(ui)),
                         htmltools::createWebDependency)
  names(dependencies) <- NULL
  list(html = htmltools::doRenderTags(ui), deps = dependencies)
}
