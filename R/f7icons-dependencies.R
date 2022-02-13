#' Framework7 icon dependencies
#'
#' @description This function attaches icon dependencies to the given tag.
#'
#' @param tag Element to attach the dependencies.
#'
#' @importFrom htmltools tagList htmlDependency
#' @export
add_f7icons_deps <- function(tag) {
  icon_deps <- htmlDependency(
    name = "f7-icons",
    version = "3.0.0",
    src = c(file = "f7icons"),
    package = "shinyMobile",
    stylesheet = "css/framework7-icons.css",
    all_files = TRUE
  )
  tagList(tag, icon_deps)
}

