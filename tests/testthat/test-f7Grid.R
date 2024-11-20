test_that("grid works", {
  grid <- f7Grid(cols = 2)
  expect_s3_class(grid, "shiny.tag")
  expect_identical(grid$attribs$class, "grid grid-cols-2 grid-gap")

  grid <- f7Grid(cols = 2, gap = FALSE)
  expect_identical(grid$attribs$class, "grid grid-cols-2")
  
  grid <- f7Grid(cols = 2, medium_cols = 4)
  expect_identical(grid$attribs$class, "grid grid-cols-2 medium-grid-cols-4")
})
