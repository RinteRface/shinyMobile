test_that("Input validation R function works", {
  session <- as.environment(list(
    ns = identity,
    sendCustomMessage = function(type, message) {
      session$lastCustomMessage <- list(type = type, message = message)
    }
  ))

  validateF7Input(
    inputId = "caption2",
    pattern = "[0-9]*",
    error = "Only numbers please!",
    session = session
  )

  res <- session$lastCustomMessage
  expect_length(res, 2)
  expect_equal(res$type, "validate-input")
  expect_length(res$message, length(formals(validateF7Input)) - 2)
  expect_equal(res$message$target, "caption2")
})

test_that("input validation works as expected", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/validateinput/app.R", package = "shinyMobile")

  app <- AppDriver$new(
    shiny_app_path,
    name = "validateinput-app"
  )

  app$wait_for_idle(1000)
  # Expect props to be present in HTML: there are no Shiny inputs/outputs related to tooltips
  app$expect_html(selector = "#caption2")

})
