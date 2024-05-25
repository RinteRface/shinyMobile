library(shinytest2)

test_that("messages work as expected", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/messages/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "messages-app"
  )
  app$expect_values(input = "mymessages")
  # Send a message
  app$set_inputs(mymessagebar = "Test message")
  app$click(selector = "#mymessagebar-send")
  # Animation/transition takes a bit of time
  app$wait_for_idle(3000)
  app$expect_values(input = "mymessages")
})

test_that("message bar work as expected", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/messagebar/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "messagebar-app"
  )
  app$expect_values(input = "mymessagebar")

  # Update placeholder
  app$click(selector = "#updateMessageBarPlaceholder")
  app$wait_for_idle(2000)
  app$expect_values(input = "mymessagebar")

  # Update text content
  app$click(selector = "#updateMessageBar")
  # Animation/transition takes a bit of time
  app$wait_for_idle(2000)
  app$expect_values(input = "mymessagebar")
})
