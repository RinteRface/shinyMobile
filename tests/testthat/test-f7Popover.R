library(shinytest2)
test_that("popover works", {
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/popover/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "popover-app"
  )

  # Disable popovers
  app$click(select = "#toggle")
  app$click(selector = "#target_1")
  app$wait_for_idle(1000)
  app$expect_values(input = "target_1")

  app$click(select = "#toggle")
  app$click(selector = "#target_1")
  # Wait for any animation to complete
  app$wait_for_idle(1000)
  app$expect_values(input = "target_1")
})
