context("f7Block")

test_that("block class", {
  expect_shinytag(f7Block())
  expect_equal(f7Block()$attribs$class, "block")

  # no hairlines, strong, inset, tablet
  expect_equal(
    f7Block(
      hairlines = FALSE,
      strong = TRUE,
      inset = TRUE,
      tablet = TRUE,
    )$attribs$class,
    "block no-hairlines block-strong inset tablet-inset"
  )

  # no inset
  expect_equal(
    f7Block(
      hairlines = FALSE,
      strong = TRUE,
      inset = FALSE,
      tablet = TRUE,
    )$attribs$class,
    "block no-hairlines block-strong tablet-inset"
  )
})
