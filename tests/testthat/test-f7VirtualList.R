library(shinytest2)
test_that("virtualList works as expected", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/virtualList/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "virtualList-app"
  )
  # Animation/transition takes a bit of time
  app$wait_for_idle(1000)
  app$expect_values(input = "vlist")
  app$click(selector = "#prependItems")
  app$click(selector = "#moveItem")
  app$wait_for_idle(1000)
  app$expect_values(input = "vlist")
  # Set search bar value
  app$wait_for_js("var searchbarEl = document.getElementById('search1'); app.searchbar.search(searchbarEl, 'Title 1000')")
  app$wait_for_idle(1000)
  app$expect_values(input = "vlist")
  app$stop()
})
