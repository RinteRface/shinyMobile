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

  expect_length(deps, 2)
  expect_equal(deps[[2]]$name, "marvel-devices-css")
  expect_equal(deps[[2]]$version, "1.0.0")
  expect_equal(deps[[2]]$stylesheet, "devices.min.css")
})
