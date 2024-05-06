test_that("smartselect works", {
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/smartselect/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "smartselect-app"
  )

  app$expect_values(input = "smartselect")
  app$click(select = "#update")
  app$wait_for_idle(1000)
  app$expect_values(input = "smartselect")
})
