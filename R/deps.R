# Add an html dependency, without overwriting existing ones
appendDependencies <- function(x, value) {
  if (inherits(value, "html_dependency"))
    value <- list(value)

  old <- attr(x, "html_dependencies", TRUE)

  htmltools::htmlDependencies(x) <- c(old, value)
  x
}

# Add dashboard dependencies to a tag object
addDeps <- function(x) {

  # CSS
  framework7_css <- "framework7.bundle.min.css"
  framework7_icons_css <- "framework7-icons.css"
  custom_css <- "my-app.css"

  # card extra elements
  social_cards_css <- "social-cards.css"
  card_img_css <- "card-img.css"

  # swiper css
  swiper_css <- "swiper.css"

  # grid extra css
  grid_css <- "grid-extra.css"

  # JS
  framework7_js <- "framework7.bundle.min.js"
  custom_js <- "my-app.js"

  # material icons
  material_icons_css <- "material-icons.css"

  f7Deps <- list(
    # deps
    htmltools::htmlDependency(
      name = "framework7",
      version = "4.3.1",
      src = c(file = system.file("framework7-4.3.1", package = "shinyF7")),
      script = c(framework7_js, custom_js),
      stylesheet = c(
        framework7_css,
        material_icons_css,
        custom_css,
        framework7_icons_css,
        social_cards_css,
        card_img_css,
        grid_css,
        swiper_css
      )
    )
  )
  appendDependencies(x, f7Deps)
}

#' @importFrom utils packageVersion
#' @importFrom htmltools htmlDependency
f7InputsDeps <- function() {
  htmltools::htmlDependency(
    name = "framework7-bindings",
    version = as.character(packageVersion("shinyF7")),
    src = c(
      file = system.file("framework7-4.3.1/input-bindings", package = "shinyF7"),
      href = "framework7-4.3.1/input-bindings"
    ),
    package = "shinyF7",
    script = c("sliderInputBinding.js",
               "stepperInputBinding.js",
               "toggleInputBinding.js")
  )
}

