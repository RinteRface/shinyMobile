library(shinytest2)

test_that("Split layout works as expected", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/split_layout/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "splitlayout-app",
    width = 1024,
    height = 768
  )
  # Animation/transition takes a bit of time
  app$wait_for_idle(1000)
  app$expect_values(input = "menu")
  app$click(selector = '#menu a.tab-link[data-tab="#tab2"]')
  app$expect_values(input = "menu")
  app$stop()
})
