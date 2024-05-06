library(shinytest2)

test_that("navbar works", {
  expect_s3_class(f7Navbar(), "shiny.tag")
  expect_identical(f7Navbar()$attribs$class, "navbar")
  expect_length(f7Navbar()$children, 2)

  expect_identical(
    f7Navbar(
      transparent = TRUE,
      bigger = TRUE,
      hairline = FALSE
    )$attribs$class,
    "navbar navbar-transparent navbar-large no-outline"
  )

  children <- f7Navbar(leftPanel = TRUE, rightPanel = TRUE)$children
  expect_length(children, 2)
  expect_identical(children[[1]]$attribs$class, "navbar-bg")

  navbar_inner <- children[[2]]
  expect_identical(navbar_inner$attribs$class, "navbar-inner sliding")
})

test_that("toggle navbar works as expected", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/navbar/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "navbar-app"
  )
  app$expect_values(input = "toggle")
  app$click(selector = "#toggle")
  # Animation/transition takes a bit of time
  app$wait_for_idle(2000)
  app$expect_values(input = "toggle")

  app$click(selector = "#toggle")
  # Animation/transition takes a bit of time
  app$wait_for_idle(2000)
  app$expect_values(input = "toggle")
})
