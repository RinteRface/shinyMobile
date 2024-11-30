test_that("grid works", {
  grid <- f7Grid(cols = 2)
  expect_s3_class(grid, "shiny.tag")
  expect_identical(grid$attribs$class, "grid grid-cols-2 grid-gap")

  grid <- f7Grid(cols = 2, gap = FALSE)
  expect_identical(grid$attribs$class, "grid grid-cols-2")
  

  # responsiveCl
  grid <- f7Grid(cols = 2, responsiveCl = 'xsmall-1')
  expect_identical(grid$attribs$class, "grid grid-cols-2 xsmall-grid-cols-1 grid-gap")
  
  grid <- f7Grid(cols = 2, responsiveCl = 'small-2')
  expect_identical(grid$attribs$class, "grid grid-cols-2 small-grid-cols-2 grid-gap")
  
  grid <- f7Grid(cols = 2, responsiveCl = 'medium-4')
  expect_identical(grid$attribs$class, "grid grid-cols-2 medium-grid-cols-4 grid-gap")
  
  grid <- f7Grid(cols = 2, responsiveCl = 'large-6')
  expect_identical(grid$attribs$class, "grid grid-cols-2 large-grid-cols-6 grid-gap")
  
  grid <- f7Grid(cols = 2, responsiveCl = 'xlarge-8')
  expect_identical(grid$attribs$class, "grid grid-cols-2 xlarge-grid-cols-8 grid-gap")
})
