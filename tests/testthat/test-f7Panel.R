test_that("panel works", {
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/panel/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "panel-app",
    variant = platform_variant()
  )

  inputs <- c("mypanel1", "mypanel2", "panelmenu")
  app$expect_values(input = inputs)
  app$click(selector = "#toggle")
  # Wait for any animation to complete
  app$wait_for_idle(1000)
  app$expect_values(input = inputs)
})
