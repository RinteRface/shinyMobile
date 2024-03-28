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
  version = "1.0.1",
  src = c(file = "shinyMobile-1.0.1"),
  script = "dist/shinyMobile.min.js",
  stylesheet = "dist/shinyMobile.min.css",
  package = "shinyMobile",
 )
 tagList(tag, shinyMobile_deps)
}
    
