test_that("select works", {
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/select/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "select-app"
  )

  # Open
  app$expect_values(input = "select", output = "test")
  app$click(select = "#update")
  app$wait_for_idle(1000)
  app$expect_values(input = "select", output = "test")
})

test_that("select R tag work", {
  select_tag <- f7Select("select", "Select", colnames(mtcars))
  expect_s3_class(select_tag, "shiny.tag")
  input <- htmltools::tagQuery(select_tag)$
    find("select")$
    selectedTags()
  expect_identical(input[[1]]$attribs$class, "input-select")
  expect_identical(input[[1]]$attribs$id, "select")
  opts <- input[[1]]$children
  expect_length(opts, length(colnames(mtcars)))
})
