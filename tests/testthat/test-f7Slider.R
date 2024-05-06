library(shinytest2)

test_that("slider works", {
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/slider/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "slider-app"
  )

  inputs <- c("slider", "range")
  app$expect_values(input = inputs)
  app$click(select = "#update_slider")
  app$click(select = "#update_range")
  app$wait_for_idle(2000)
  app$expect_values(input = inputs)
})
