#' PWA dependencies utils
#'
#' @description This function attaches PWA manifest and icons to the given tag
#'
#' @param tag Element to attach the dependencies.
#'
#' @importFrom utils packageVersion
#' @importFrom htmltools tagList htmlDependency
#' @export
add_pwa_deps <- function(tag) {
 pwa_deps <- htmlDependency(
  name = "pwa-utils",
  version = packageVersion("shinyMobile"),
  src = c(file = "shinyMobile-1.0.0.9000"),
  head = "<link rel=\"manifest\" href=\"manifest.webmanifest\" />
<link rel=\"icon\" type=\"image/png\" href=\"icons/icon-144.png\" sizes=\"144x144\" />
<link rel=\"apple-touch-icon\" href=\"icons/apple-touch-icon.png\" />
<link rel=\"icon\" href=\"icons/favicon.png\"/>
  ",
  package = "shinyMobile",
 )
 tagList(tag, pwa_deps)
}

