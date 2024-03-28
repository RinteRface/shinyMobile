library(shinytest2)
test_that("date picker works", {
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/datepicker/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "datepicker-app",
    variant = platform_variant()
  )

  # Disable popovers
  app$expect_values(input = "picker")
  app$click(selector = "#picker")
  app$wait_for_idle(2000)
  app$expect_values(input = "picker")
  app$click(select = "#update")
  app$click(selector = "#picker")
  app$wait_for_idle(2000)
  app$expect_values(input = "picker")
  app$click(select = "#removeTime")
  app$click(selector = "#picker")
  app$wait_for_idle(2000)
  app$expect_values(input = "picker")
})
