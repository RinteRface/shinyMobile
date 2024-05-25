library(shinytest2)

test_that("toggle works", {
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/toggle/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "toggle-app"
  )

  # Open
  app$expect_values(input = "toggle", output = "test")
  app$click(select = "#update")
  app$wait_for_idle(1000)
  app$expect_values(input = "toggle", output = "test")
})

test_that("toggle R tag work", {
  toggle_tag <- f7Toggle("toggle", "Toggle", color = "pink")
  expect_s3_class(toggle_tag, "shiny.tag.list")
  expect_identical(toggle_tag[[2]]$attribs$class, "toggle color-pink")
  expect_identical(toggle_tag[[2]]$attribs$id, "toggle")
})
