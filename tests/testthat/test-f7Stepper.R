library(shinytest2)

test_that("stepper works", {
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/stepper/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "stepper-app"
  )

  app$expect_values(input = "stepper")
  app$click(select = "#update")
  app$wait_for_idle(1000)
  app$expect_values(input = "stepper")
})
