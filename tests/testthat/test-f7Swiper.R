library(shinytest2)

test_that("swiper slide works", {
  slide <- f7Slide()
  expect_s3_class(slide, "shiny.tag")
  expect_identical(slide$attribs$class, "swiper-slide")
})

test_that("swiper tag works", {
  swiper <- f7Swiper(
    id = "swiper",
    lapply(1:2, f7Slide)
  )
  expect_s3_class(swiper, "shiny.tag")
  expect_identical(swiper$attribs$class, "swiper")
  expect_identical(swiper$attribs$id, "swiper")
})

test_that("swiper works", {
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/swiper/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "swiper-app"
  )

  app$expect_values(
    input = c("toggle", "slider"),
    output = c("test", "test2")
  )
  app$run_js("app.swiper.get('#swiper').slideNext();")
  app$wait_for_idle(1000)
  app$expect_values(
    input = c("toggle", "slider"),
    output = c("test", "test2")
  )
})
