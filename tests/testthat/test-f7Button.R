context("f7Button")

test_that("button", {
  expect_shinytaglist(f7Button())
  # deps
  expect_is(f7Button()[[1]], "html_dependency")

  # errors
  expect_error(f7Button(inputId = "test", src = "src"))
  expect_error(f7Button(outline = TRUE, fill = TRUE))
  expect_error(f7Button(outline = TRUE, color = "red"))

  # class
  expect_equal(f7Button()[[2]]$attribs$class, "button button-fill")
  expect_equal(f7Button(fill = FALSE)[[2]]$attribs$class, "button")
  expect_equal(
    f7Button(fill = FALSE, outline = TRUE)[[2]]$attribs$class,
    "button button-outline"
  )
  expect_equal(f7Button(shadow = TRUE)[[2]]$attribs$class, "button button-fill button-raised")
  expect_equal(f7Button(rounded = TRUE)[[2]]$attribs$class, "button button-fill button-round")
  expect_equal(f7Button(size = "small")[[2]]$attribs$class, "button button-fill button-small")
  expect_equal(f7Button(color = "pink")[[2]]$attribs$class, "button color-pink button-fill")

  # input binding class
  expect_equal(f7Button(inputId = "test")[[2]]$attribs$class, "button f7-action-button button-fill")
})
