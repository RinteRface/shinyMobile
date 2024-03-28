test_that("chip works", {
  expect_s3_class(f7Chip(), "shiny.tag")
  expect_identical(f7Chip()$attribs$class, "chip")
  expect_identical(
    f7Chip(status = "green", outline = TRUE)$attribs$class,
    "chip chip-outline color-green"
  )

  # With icon
  chip_children <- dropNulls(
    f7Chip(icon = f7Icon("plus_circle_fill"), iconStatus = "pink")$children
  )
  expect_length(chip_children, 2)
  expect_identical(chip_children[[1]]$attribs$class, "chip-media bg-color-pink")
  expect_identical(chip_children[[2]]$attribs$class, "chip-label")
})
