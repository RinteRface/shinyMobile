test_that("block class", {
  expect_true(inherits(f7Block(), "shiny.tag"))
  expect_equal(f7Block()$attribs$class, "block")

  expect_error(f7Block(inset = FALSE, tablet = TRUE))
  expect_error(f7Block(inset = TRUE))

  # basic
  expect_equal(
    f7Block()$attribs$class,
    "block"
  )

  # strong, inset
  expect_equal(
    f7Block(
      strong = TRUE,
      inset = TRUE
    )$attribs$class,
    "block block-strong inset"
  )

  # strong, inset, tablet, outline
  expect_equal(
    f7Block(
      strong = TRUE,
      inset = TRUE,
      tablet = TRUE,
      outline = TRUE,
    )$attribs$class,
    "block block-strong medium-inset block-outline"
  )
})

test_that("blocktitle", {
  expect_true(inherits(f7BlockTitle("plop"), "shiny.tag"))
  expect_equal(
    f7BlockTitle("plop")$attribs$class,
    "block-title"
  )
  expect_equal(
    f7BlockTitle("plop", size = "large")$attribs$class,
    "block-title block-title-large"
  )
  expect_equal(
    f7BlockTitle("plop", size = "medium")$attribs$class,
    "block-title block-title-medium"
  )
})
