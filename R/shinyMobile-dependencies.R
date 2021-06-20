#' shinyMobile dependencies utils
#'
#' @description This function attaches shinyMobile dependencies to the given tag
#'
#' @param tag Element to attach the dependencies.
#'
#' @importFrom utils packageVersion
#' @importFrom htmltools tagList htmlDependency
#' @export
add_shinyMobile_deps <- function(tag) {
 shinyMobile_deps <- htmlDependency(
  name = "shinyMobile",
  version = packageVersion("shinyMobile"),
  src = c(file = "shinyMobile-1.0.0.9001"),
  script = "js/shinyMobile.js",
  stylesheet = "css/shinyMobile.css",
  package = "shinyMobile",
 )
 tagList(tag, shinyMobile_deps)
}

