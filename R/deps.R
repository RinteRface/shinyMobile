# Add CSS dependencies to a tag object
add_shinyMobile_deps <- function(tag) {

  # CSS
  framework7_css <- "framework7.bundle.min.css"
  custom_css <- "my-app.css"
  # card extra elements
  social_cards_css <- "social-cards.css"
  card_img_css <- "card-img.css"
  # swiper css
  swiper_css <- "swiper.css"
  # material icons
  material_icons_css <- "material-icons.css"

  shiny::tagList(
    tag,
    htmltools::htmlDependency(
      name = "framework7",
      version = "5.7.8",
      src = c(file = "framework7-5.7.8"),
      package = "shinyMobile",
      script = c(
        "framework7.bundle.min.js",
        "my-app.js",
        "pwacompat/pwacompat.min.js"
      ),
      stylesheet = c(
        framework7_css,
        material_icons_css,
        custom_css,
        social_cards_css,
        card_img_css,
        swiper_css
      )
    )
  )
}




#' @importFrom utils packageVersion
#' @importFrom htmltools htmlDependency
f7InputsDeps <- function() {

  htmltools::htmlDependency(
    name = "framework7-bindings",
    version = as.character(packageVersion("shinyMobile")),
    src = c(
      file = "framework7-5.7.8",
      href = "framework7-5.7.8"
    ),
    package = "shinyMobile",
    script = "framework7.bindings.min.js"
  )
}


html_dependencies_f7Icons <- function() {
  name <- "f7-icons"
  htmlDependency(
    name = name,
    version = "3.0.0",
    src = list(
      href = "framework7-5.7.8",
      file = "framework7-5.7.8"
    ),
    package = "shinyMobile",
    stylesheet = file.path(name, "css/framework7-icons.css"),
    all_files = TRUE
  )
}


# deps for pwa compat
addPWADeps <- function(icon, favicon, manifest) {
  depsPath <- "framework7-5.7.8/pwacompat/"
  shiny::tagList(
    # manifest
    shiny::singleton(
      shiny::tags$link(
        rel = "manifest",
        href = if(!is.null(manifest)) {
          manifest
        } else {
          paste0(depsPath, "manifest.json")
        }
      )
    ),
    # apple touch icon (not created by pwacompat)
    shiny::singleton(
      shiny::tags$link(
        rel = "apple-touch-icon",
        href = if (!is.null(icon)) {
          icon
        } else {
          paste0(depsPath, "icons/apple-touch-icon.png")
        }
      )
    ),
    #favicon
    shiny::singleton(
      shiny::tags$link(
        rel = "icon",
        href = if(!is.null(favicon)) {
          favicon
        } else {
          paste0(depsPath, "icons/favicon.png")
        }
      )
    )
  )
}




