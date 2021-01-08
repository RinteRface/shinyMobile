context("f7Button")

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

  # input binding class
  expect_equal(f7Button(inputId = "test")$attribs$class, "button f7-action-button button-fill")
})


context("f7Segment")

test_that("f7Segment", {
  expect_true(inherits(f7Segment(container = "segment"), "shiny.tag"))

  # error
  expect_error(f7Segment(container = "row", rounded = TRUE))
  expect_error(f7Segment(container = "row", shadow = TRUE))

  # class
  expect_equal(f7Segment(container = "segment")$attribs$class, "block")
  expect_equal(f7Segment(container = "segment")$children[[1]]$attribs$class, "segmented")
  expect_equal(f7Segment(container = "row")$children[[1]]$attribs$class, "row")
  expect_equal(
    f7Segment(container = "segment", shadow = TRUE)$children[[1]]$attribs$class,
    "segmented segmented-raised"
  )
  expect_equal(
    f7Segment(container = "segment", rounded = TRUE)$children[[1]]$attribs$class,
    "segmented segmented-round"
  )

  expect_equal(
    f7Segment(container = "segment", strong = TRUE)$children[[1]]$attribs$class,
    "segmented segmented-strong"
  )

  # structure: check children elements inside
  #segmentTag <- f7Segment(container = "row", lapply(1:3, f7Button))
  #expect_length(segmentTag$children[[1]]$children[[1]][[1]], 4)
  #bttn1 <- segmentTag$children[[1]]$children[[1]][[1]][[1]]
  #expect_match(bttn1[[2]]$attribs$class, "col")


})
