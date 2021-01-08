context("preview_mobile")

test_that("dependencies", {
  device <- "iphoneX"
  landscape <- FALSE
  appHeight <- if (!landscape) 812 else 375

  iframeApp <- shiny::tags$iframe(
    width = "100%",
    src = "http://127.0.0.1:3838",
    allowfullscreen = "",
    frameborder = "0",
    scrolling = "no",
    height = paste0(appHeight, "px")# height depends on the choosen device!
  )

  ui <- shinyMobile:::create_app_ui(iframeApp, device, color = NULL, landscape)
  deps <- htmltools::findDependencies(ui)

  # we need index since shiny might not have the same version
  # locally and on CRAN machines ... (dependencies are not in the same order)
  deps_names <- vapply(deps, `[[`, "name", FUN.VALUE = character(1))
  idx <- which(deps_names == "marvel-devices-css")

  expect_length(deps, 2)
  expect_equal(deps[[idx]]$name, "marvel-devices-css")
  expect_equal(deps[[idx]]$version, "1.0.0")
  expect_equal(deps[[idx]]$stylesheet, "devices.min.css")
})
