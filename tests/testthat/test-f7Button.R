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

})
