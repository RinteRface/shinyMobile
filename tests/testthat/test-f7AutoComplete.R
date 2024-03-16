test_that("autocomplete works", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/autocomplete/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "autocomplete-app",
    variant = platform_variant()
  )
  app$expect_values(input = "myautocomplete")
  app$click(selector = "#update")
  # Wait for any animation to complete
  app$wait_for_idle(1000)
  app$expect_values(input = "myautocomplete")
})
