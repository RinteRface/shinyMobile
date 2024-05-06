test_that("card works", {
  expect_s3_class(f7Card(), "shiny.tag")
  expect_identical(f7Card()$attribs$class, "card")

  # Children
  card <- f7Card("Content", title = "title", footer = "footer")
  expect_length(card$children, 3)
  expect_identical(card$children[[1]]$attribs$class, "card-header")
  expect_identical(card$children[[2]]$attribs$class, "card-content card-content-padding")
  expect_identical(card$children[[3]]$attribs$class, "card-footer")

  # classes
  card <- f7Card(
    raised = TRUE,
    outline = TRUE,
    divider = TRUE,
    image = "https://cdn.framework7.io/placeholder/nature-1000x600-3.jpg"
  )

  expect_identical(
    card$attribs$class,
    "card demo-card-header-pic card-outline card-raised card-header-divider card-footer-divider"
  )
})

test_that("expandable cards work expected", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/card/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "card-app"
  )
  app$expect_values(input = "card2")
  app$click(selector = "#go")
  # Animation/transition takes a bit of time
  app$wait_for_idle(2000)
  app$expect_values(input = "card2")
})
