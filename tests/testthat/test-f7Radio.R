library(shinytest2)

test_that("radio works as expected", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/radio/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "radio-app"
  )
  app$expect_values(input = c("radio", "radio2"), output = c("res", "res2"))
  app$click(selector = "#update")
  app$wait_for_idle(3000)
  app$expect_values(input = c("radio", "radio2"), output = c("res", "res2"))
})
