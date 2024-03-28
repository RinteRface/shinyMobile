library(shinytest2)
test_that("Treeview works as expected", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/treeview/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "treeview-app",
    variant = platform_variant()
  )
  # Animation/transition takes a bit of time
  app$wait_for_idle(1000)
  app$click(selector = "#checkbox .treeview-item-toggle")
  app$expect_values(input = "checkbox")
  app$click(selector = "#checkbox .treeview-item-children .treeview-item:nth-child(2) input[type='checkbox']")
  app$click(selector = "#selectable .treeview-item-toggle")
  app$expect_values(input = c("selectable","checkbox"))
  app$stop()
})
