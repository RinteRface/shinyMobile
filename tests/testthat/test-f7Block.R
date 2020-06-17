context("f7Block")

test_that("block class", {
  expect_true(inherits(f7Block(), "shiny.tag"))
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


test_that("blocktitle", {
  expect_true(inherits(f7BlockTitle(), "shiny.tag"))
  expect_equal(
    f7BlockTitle()$attribs$class,
    "block-title"
  )
  expect_equal(
    f7BlockTitle(size = "large")$attribs$class,
    "block-title block-title-large"
  )
  expect_equal(
    f7BlockTitle(size = "medium")$attribs$class,
    "block-title block-title-medium"
  )
})
