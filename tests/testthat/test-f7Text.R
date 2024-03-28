library(htmltools)

test_that("f7Text tag works", {
  text_input <- f7Text("ee", "label", value = "text")
  expect_s3_class(text_input, "shiny.tag")
  expect_true(
    tagQuery(text_input)$
      find(".item-content")$
      hasClass("item-input")
  )

  expect_true(
    tagQuery(text_input)$
      find(".item-title")$
      hasClass("item-label")
  )

  expect_true(
    tagQuery(text_input)$
      find(".item-title")$
      siblings()$
      hasClass("item-input-wrap")
  )

  input_tag <- tagQuery(text_input)$
    find("input")$
    selectedTags()[[1]]

  expect_identical(input_tag$attribs$id, "ee")
  expect_identical(input_tag$attribs$value, "text")
  expect_identical(input_tag$attribs$type, "text")
})


library(shinytest2)
test_that("text inputs as expected", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/text/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "text-app",
    variant = platform_variant()
  )

  inputs <- c(
    "text",
    "textarea",
    "password"
  )

  app$expect_values(input = inputs)
  app$click(selector = "#update")
  # Animation/transition takes a bit of time
  app$wait_for_idle(2000)
  app$expect_values(input = inputs)
})
