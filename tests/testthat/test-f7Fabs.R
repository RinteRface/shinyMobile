library(shinytest2)
test_that("fabs works as expected", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/fabs/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "fabs-app"
  )
  app$expect_values(input = c("fabs", "fabsMorph", "1"), output = "res")
  app$click(selector = "#toggle")
  # Animation/transition takes a bit of time
  app$wait_for_idle(1000)
  app$expect_values(input = c("fabs", "fabsMorph", "1"), output = "res")

  app$click(selector = "#toggle")
  app$wait_for_idle(1000)
  app$expect_values(input = c("fabs", "fabsMorph", "1"), output = "res")

  app$click(selector = "#fabsMorph")
  app$wait_for_idle(1000)
  app$expect_values(input = c("fabs", "fabsMorph", "1"), output = "res")
})

test_that("fabs close works", {
  el <- shiny::div() |> f7FabClose()
  expect_s3_class(el, "shiny.tag")
  expect_identical(
    el$attribs$class,
    "fab-close"
  )
})

test_that("f7FabMorphTarget works", {
  el <- shiny::div() |> f7FabMorphTarget()
  expect_s3_class(el, "shiny.tag")
  expect_identical(
    el$attribs$class,
    "fab-morph-target"
  )
})

test_that("f7Fab works", {
  el <- f7Fab("id", "Label", flag = "plop")
  expect_s3_class(el, "shiny.tag")
  expect_true(grepl("f7-action-button", el$attribs$class))
  expect_identical(el$attribs$id, "id")
})

test_that("f7Fabs tag works", {
  el <- f7Fabs(
    position = "center-center",
    id = "fabs",
    morphTarget = ".toolbar",
    lapply(1:3, function(i) f7Fab(inputId = i, label = i))
  )
  expect_s3_class(el, "shiny.tag")
  expect_identical(
    el$attribs$`data-morph-to`,
    ".toolbar"
  )

  btns <- el$children[[2]]
  expect_identical(
    btns$attribs$class,
    "fab-buttons fab-buttons-left"
  )
  expect_length(btns$children[[1]], 3)
})
