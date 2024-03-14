library(shinytest2)
test_that("messages work as expected", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/messages/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "messages-app",
    variant = platform_variant()
  )
  app$expect_values(input = "mymessages")
  # Send a message
  app$set_inputs(mymessagebar = "Test message")
  app$click(selector = "#mymessagebar-send")
  # Animation/transition takes a bit of time
  app$wait_for_idle(3000)
  app$expect_values(input = "mymessages")
})
