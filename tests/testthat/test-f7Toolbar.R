test_that("toolbar works", {
  expect_s3_class(f7Toolbar(), "shiny.tag")
  expect_identical(f7Toolbar(position = "top")$attribs$class, "toolbar toolbar-top")
  expect_identical(f7Toolbar(icons = TRUE)$attribs$class, "toolbar tabbar tabbar-icons toolbar-bottom")
})
