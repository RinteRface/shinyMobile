library(shinytest2)

test_that("progress works", {
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/progress/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "progress-app"
  )

  app$expect_values(input = "obs")
  app$set_inputs("obs" = 25)
  app$wait_for_idle(1000)
  app$expect_values(input = "obs")
})

test_that("f7Progress works", {
  progress <- f7Progress(id = "progress", 100, "green")
  expect_s3_class(progress, "shiny.tag")
  expect_identical(progress$attribs$class, "progressbar color-green")
  expect_identical(progress$attribs$id, "progress")
  expect_identical(progress$attribs$`data-progress`, 100)
})

test_that("infinite f7Progress works", {
  progress <- f7Progress(id = "progress", value = NULL, "red")
  expect_s3_class(progress, "shiny.tag")
  expect_identical(progress$attribs$class, "progressbar-infinite color-red")
  expect_identical(progress$attribs$id, "progress")
  expect_identical(progress$attribs$`data-progress`, NULL)
})

test_that("updateF7Progress function work", {
  session <- as.environment(list(
    ns = identity,
    sendCustomMessage = function(type, message) {
      session$lastCustomMessage <- list(type = type, message = message)
    }
  ))

  updateF7Progress(id = "pg1", value = 100, session = session)

  res <- session$lastCustomMessage
  expect_length(res, 2)
  expect_equal(res$type, "update-progress")
  expect_identical(res$message$id, "pg1")
  expect_identical(res$message$progress, 100)
})
