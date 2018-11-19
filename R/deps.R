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
  framework7_css <- "framework7.min.css"
  framework7_icons_css <- "framework7-icons.css"
  custom_css <- "my-app.css"

  # JS
  framework7_js <- "framework7.min.js"
  custom_js <- "my-app.js"

  f7Deps <- list(
    # deps
    htmltools::htmlDependency(
      name = "framework7",
      version = "3.5.1",
      src = c(file = system.file("framework7-3.5.1", package = "shinyF7")),
      script = c(framework7_js, custom_js),
      stylesheet = c(framework7_css, custom_css, framework7_icons_css)
    )
  )
  appendDependencies(x, f7Deps)
}
