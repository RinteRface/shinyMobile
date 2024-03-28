library(shinytest2)

test_that("dialog R function", {
  session <- as.environment(list(
    ns = identity,
    sendCustomMessage = function(type, message) {
      session$lastCustomMessage <- list(type = type, message = message)
    }
  ))

  f7Dialog(
    title = "Dialog title",
    text = "This is an alert dialog",
    session = session
  )

  res <- session$lastCustomMessage
  res$message <- jsonlite::fromJSON(res$message)
  expect_length(res, 2)
  expect_equal(res$type, "dialog")
  expect_length(res$message, 3)
  expect_identical(res$message$title, "Dialog title")
  expect_identical(res$message$text, "This is an alert dialog")
  expect_identical(res$message$type, "alert")
})

test_that("dialog works as expected", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/dialog/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "dialog-app",
    variant = platform_variant()
  )

  inputs <- c("comfirm_dialog", "prompt_dialog", "login_dialog")

  app$expect_values(input = inputs)
  app$click(selector = "#alert")
  app$wait_for_idle(2000)
  app$expect_values(input = inputs)
  app$click(selector = ".dialog-button")
  app$wait_for_idle(1000)

  app$click(selector = "#confirm")
  app$wait_for_idle(2000)
  app$click(selector = ".dialog-button:nth-child(1)")
  app$wait_for_idle(1000)
  app$expect_values(input = inputs)

  app$click(selector = "#confirm")
  app$wait_for_idle(2000)
  app$click(selector = ".dialog-button:nth-child(2)")
  app$wait_for_idle(1000)
  app$expect_values(input = inputs)

  app$click(selector = "#prompt")
  app$wait_for_idle(2000)
  app$run_js("$('.dialog-input').val('test');")
  app$click(selector = ".dialog-button:nth-child(2)")
  app$wait_for_idle(1000)
  app$expect_values(input = inputs)

  app$click(selector = "#login")
  app$wait_for_idle(2000)
  app$run_js("$('.dialog-input[name=\"dialog-username\"]').val('test');")
  app$run_js("$('.dialog-input[name=\"dialog-password\"]').val('test');")
  app$click(selector = ".dialog-button:nth-child(2)")
  app$wait_for_idle(1000)
  app$expect_values(input = inputs)
})
