# Add an html dependency, without overwriting existing ones
appendDependencies <- function(x, value) {
  if (inherits(value, "html_dependency"))
    value <- list(value)

  old <- attr(x, "html_dependencies", TRUE)

  htmltools::htmlDependencies(x) <- c(old, value)
  x
}

# Add CSS dependencies to a tag object
addCSSDeps <- function(x) {

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

  f7Deps <- list(
    # deps
    htmltools::htmlDependency(
      name = "framework7",
      version = "5.5.0",
      src = c(file = "framework7-5.5.0"),
      package = "shinyMobile",
      script = NULL,
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
  # currently, this piece is a bit useless since
  # there is only 1 dependency. However, we never
  # what will happen later!
  appendDependencies(x, f7Deps)
}



# Add JS dependencies to a tag object
# for framework 7 htmldependency is not
# what we want in order to include js files
# we need the crapy tags$script function.
# Indeed, framework7 js deps MUUUUUUST be
# located at the end of the body.
addJSDeps <- function() {

  depsPath <- "framework7-5.5.0/"

  # JS
  framework7_js <- paste0(depsPath, "framework7.bundle.min.js")
  custom_js <- paste0(depsPath, "my-app.js")
  pwa_compat <- paste0(depsPath, "pwacompat/pwacompat.min.js")

  shiny::tagList(
    shiny::singleton(
      shiny::tags$script(src = framework7_js)
    ),
    shiny::singleton(
      shiny::tags$script(async = NA, src = custom_js)
    ),
    shiny::singleton(
      shiny::tags$script(async = NA, src = pwa_compat)
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
      file = "framework7-5.5.0",
      href = "framework7-5.5.0"
    ),
    package = "shinyMobile",
    script = "framework7.bindings.min.js"
  )
}


html_dependencies_f7Icons <- function(old = TRUE) {
  name <- "f7-icons"
  if (isTRUE(old)) {
    name <- paste0(name, "-old")
  }
  htmlDependency(
    name = name,
    version = "3.0.0",
    src = list(
      href = "framework7-5.5.0",
      file = "framework7-5.5.0"
    ),
    package = "shinyMobile",
    stylesheet = file.path(name, "css/framework7-icons.css"),
    all_files = TRUE
  )
}


# deps for pwa compat
addPWADeps <- function(icon, favicon, manifest) {
  depsPath <- "framework7-5.3.0/pwacompat/"
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




