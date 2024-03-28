context("f7Button")

library(shinytest2)
test_that("button works as expected", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/button/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "button-app",
    variant = platform_variant()
  )
  app$expect_values(input = "button")
  app$click(selector = "#update")
  app$wait_for_idle(1000)
  app$expect_values(input = "button")
})

test_that("button", {
  expect_true(inherits(f7Button(), "shiny.tag"))

  # errors
  expect_error(f7Button(inputId = "test", href = "https://www.google.com"))
  expect_error(f7Button(outline = TRUE, fill = TRUE))
  expect_error(f7Button(outline = TRUE, color = "red"))

  # class
  expect_equal(f7Button()$attribs$class, "button button-fill")
  expect_equal(f7Button(fill = FALSE)$attribs$class, "button")
  expect_equal(
    f7Button(fill = FALSE, outline = TRUE)$attribs$class,
    "button button-outline"
  )
  expect_equal(f7Button(shadow = TRUE)$attribs$class, "button button-fill button-raised")
  expect_equal(f7Button(rounded = TRUE)$attribs$class, "button button-fill button-round")
  expect_equal(f7Button(size = "small")$attribs$class, "button button-fill button-small")
  expect_equal(f7Button(color = "pink")$attribs$class, "button color-pink button-fill")
  expect_equal(f7Button(active = TRUE)$attribs$class, "button button-fill button-active")

  expect_equal(f7Button(tonal = TRUE)$attribs$class, "button button-fill button-tonal")
  # input binding class
  expect_equal(f7Button(inputId = "test")$attribs$class, "button f7-action-button button-fill")
})


context("f7Segment")

test_that("f7Segment", {
  expect_true(inherits(f7Segment(), "shiny.tag"))

  # class
  expect_equal(f7Segment()$attribs$class, "block")
  expect_equal(f7Segment()$children[[1]]$attribs$class, "segmented")
  expect_equal(
    f7Segment(shadow = TRUE)$children[[1]]$attribs$class,
    "segmented segmented-raised"
  )
  expect_equal(
    f7Segment(rounded = TRUE)$children[[1]]$attribs$class,
    "segmented segmented-round"
  )

  expect_equal(
    f7Segment(strong = TRUE)$children[[1]]$attribs$class,
    "segmented segmented-strong"
  )
})
