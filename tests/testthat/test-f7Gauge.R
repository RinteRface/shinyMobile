library(shinytest2)

test_that("gauge tags works", {
  gauge <- f7Gauge(id = "test", value = 10)
  expect_s3_class(gauge, "shiny.tag")
  expect_identical(gauge$attribs$id, "test")
  expect_identical(gauge$attribs$class, "gauge")
  expect_identical(gauge$children[[1]]$attribs$`data-for`, "test")
  expect_s3_class(gauge$children[[1]]$children[[1]], "json")
})

test_that("update gauge works", {
  session <- as.environment(list(
    ns = identity,
    sendCustomMessage = function(type, message) {
      session$lastCustomMessage <- list(type = type, message = message)
    }
  ))

  updateF7Gauge(id = "test", value = 10, session = session)

  res <- session$lastCustomMessage
  res$message <- jsonlite::fromJSON(res$message)
  expect_length(res, 2)
  expect_equal(res$type, "update-gauge")
  expect_equal(res$message$value, 0.1)
  expect_equal(res$message$id, "test")
})

test_that("gauge e2e", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/gauge/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "gauge-app",
    variant = platform_variant()
  )

  app$expect_values()
  app$click(selector = "#update")
  app$wait_for_idle(1000)
  app$expect_values()
})
