library(shinytest2)

test_that("panel works", {
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/panel/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "panel-app"
  )

  inputs <- c("mypanel1", "mypanel2", "panelmenu")
  app$expect_values(input = inputs)
  app$click(selector = "#toggle")
  # Wait for any animation to complete
  app$wait_for_idle(1000)
  app$expect_values(input = inputs)
})

test_that("panel tag works", {
  id <- "test"
  panel <- f7Panel(id = id)
  expect_s3_class(panel, "shiny.tag")

  # structure
  expect_identical(panel$attribs$class, "panel panel-left panel-reveal")
  expect_length(panel$children, 2)
  expect_identical(panel$children[[1]]$attribs$`data-for`, id)
  expect_identical(panel$children[[2]]$attribs$class, "page")

  # Config
  config <- jsonlite::fromJSON(panel$children[[1]]$children[[1]])
  expect_length(config, 1)
  expect_identical(config[["effect"]], "reveal")
})

test_that("panel menu works", {
  panel_menu <- f7PanelMenu(id = "menu")
  expect_s3_class(panel_menu, "shiny.tag")

  # structure
  expect_identical(panel_menu$attribs$class, "list chevron-center links-list")
  expect_identical(panel_menu$children[[1]]$children[[1]]$attribs$id, "menu")
})

test_that("panel item works", {
  panel_item <- f7PanelItem("Title", "tab1", active = TRUE)
  expect_s3_class(panel_item, "shiny.tag")
  expect_identical(panel_item$name, "li")
  expect_identical(panel_item$children[[1]]$attribs$`data-tab`, "#tab1")
  expect_identical(
    panel_item$children[[1]]$attribs$class,
    "tab-link tab-link-active"
  )
})
