library(shinytest2)

test_that("picker works", {
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/picker/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "picker-app"
  )

  app$expect_values(input = "picker")
  app$click(selector = "#picker")
  app$wait_for_idle(2000)
  app$expect_values(input = "picker")
  app$click(select = "#update")
  app$click(selector = "#picker")
  app$wait_for_idle(2000)
  app$expect_values(input = "picker")
  app$click(selector = ".tab-link:first-child")
  app$click(selector = ".tab-link:not(.tab-link-active)")
  app$wait_for_idle(2000)
  app$expect_values(input = "picker2")
})

test_that("picker tag works", {
  picker <- f7Picker(
    inputId = "picker",
    label = "Picker Input",
    choices = c("a", "b", "c"),
    options = list(sheetPush = TRUE)
  )

  expect_s3_class(picker, "shiny.tag.list")
  config <- htmltools::tagQuery(picker)$
    find("script")$
    selectedTags()[[1]]
  expect_identical(config$attribs$`data-for`, "picker")

  input <- htmltools::tagQuery(picker)$
    find("input")$
    selectedTags()[[1]]
  expect_identical(input$attribs$class, "picker-input")
  expect_identical(input$attribs$id, "picker")
})

test_that("picker in list works", {
  picker <- f7List(
    f7Picker(
      inputId = "picker",
      label = "Picker Input",
      choices = c("a", "b", "c"),
      options = list(sheetPush = TRUE)
    )
  )

  expect_s3_class(picker, "shiny.tag")
  config <- htmltools::tagQuery(picker)$
    find("script")$
    selectedTags()[[1]]
  expect_identical(config$attribs$`data-for`, "picker")

  label <- htmltools::tagQuery(picker)$
    find(".item-title")$
    selectedTags()[[1]]
  expect_identical(label$attribs$class, "item-title item-label")
})
