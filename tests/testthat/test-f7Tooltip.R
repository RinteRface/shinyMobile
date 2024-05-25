library(shinytest2)

test_that("tooltips work as expected", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()

  shiny_app_path <-
    system.file("examples/tooltip/app.R", package = "shinyMobile")

  app <- AppDriver$new(
    shiny_app_path,
    name = "tooltip-app"
  )

  app$click(selector = "#target_1")

  # Animation/transition takes a bit of time
  app$wait_for_idle(1000)
  # Expect text to be present in HTML: there are no Shiny inputs/outputs related to tooltips
  app$expect_text(selector = ".tooltip-content")

  # Update tooltip
  app$set_inputs(tooltip_text = "Test tooltip")
  app$click(selector = "#target_1")

  # Animation/transition takes a bit of time
  app$wait_for_idle(1000)
  # Expect updated text to be present in HTML
  app$expect_text(selector = ".tooltip-content")

  app$stop()

})
