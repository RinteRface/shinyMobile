library(shinytest2)

test_that("form works", {
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/forms/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "forms-app"
  )

  # Open
  app$expect_values(input = "myform")
  app$click(select = "#update")
  app$wait_for_idle(1000)
  app$expect_values(input = "myform")
})

test_that("form tag works", {
  form <- f7Form(id = "form", f7Text("ee", "ee"))
  expect_s3_class(form, "shiny.tag")
  expect_identical(form$attribs$class, "inputs-form")
  expect_identical(form$attribs$id, "form")
})
