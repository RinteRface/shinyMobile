library(shinytest2)

test_that("table works", {
  expect_true(inherits(f7Table(mtcars), "shiny.tag"))

  # Expect correct top-level classes
  expect_equal(f7Table(mtcars)$attribs$class, "data-table")
  expect_equal(f7Table(mtcars, card = TRUE)$attribs$class, "data-table card")

  # Expect table to have the correct number of rows
  body_children <- f7Table(mtcars)$children[[1]]$children[[2]]$children[[1]]
  expect_equal(length(body_children), nrow(mtcars))
})

test_that("table works as expected", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/table/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "table-app"
  )
  app$expect_values(output = "table")
})
