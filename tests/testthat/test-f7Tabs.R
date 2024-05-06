test_that("tabs works", {
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/tabs/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "tabs-app"
  )

  app$expect_values(input = "tabs")
  # Update
  app$click(selector = "#update")
  app$wait_for_idle(1000)
  app$expect_values(input = "tabs")
  # Insert twice
  app$click(selector = "#insert")
  app$wait_for_idle(1000)
  app$click(selector = "#insert")
  app$wait_for_idle(1000)
  app$expect_values(input = "tabs")
  app$click(selector = "#update")
  app$wait_for_idle(1000)
  app$expect_values(input = "tabs")
  # Remove twice
  app$click(selector = "#remove")
  app$wait_for_idle(1000)
  app$click(selector = "#remove")
  app$wait_for_idle(1000)
  app$expect_values(input = "tabs")
})
