library(shinytest2)
test_that("sheet works", {
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/sheet/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "sheet-app",
    variant = platform_variant()
  )

  # Open
  app$click(select = "#toggle")
  app$wait_for_idle(3000)
  app$expect_values(input = "sheet")
})

test_that("sheet R tag work", {
  sheet_tag <- f7Sheet(id = "sheet", "test", swipeToClose = TRUE)
  expect_s3_class(sheet_tag, "shiny.tag")
  expect_identical(sheet_tag$attribs$class, "sheet-modal")
  expect_identical(sheet_tag$attribs$id, "sheet")
  sheet_config <- sheet_tag$children[[1]]
  expect_identical(sheet_config$attribs$`data-for`, "sheet")

  sheet_tag <- f7Sheet(id = "sheet", "test")
  expect_identical(sheet_tag$attribs$class, "sheet-modal sheet-modal-top")
})
