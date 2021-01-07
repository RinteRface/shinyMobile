#' framework7 dependencies utils
#'
#' @description This function attaches framework7. dependencies to the given tag
#'
#' @param tag Element to attach the dependencies.
#'
#' @importFrom htmltools tagList htmlDependency
#' @export
add_framework7_deps <- function(tag) {
 framework7_deps <- htmlDependency(
  name = "framework7",
  version = "5.7.14",
  src = c(file = "framework7-5.7.14"),
  script = "js/framework7.bundle.min.js",
  stylesheet = "css/framework7.bundle.min.css",
  package = "shinyMobile",
 )
 tagList(tag, framework7_deps)
}
    
