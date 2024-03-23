test_that("swipeout works", {
  expect_error(f7Swipeout(tag = div()))
  swipeout <- f7Swipeout(
    tag = div(class = "parent", div(class = "content")),
    left = f7SwipeoutItem(id = "1", "test"),
    right = f7SwipeoutItem(id = "2", "test2", color = "blue")
  )

  expect_s3_class(swipeout, "shiny.tag")
  expect_identical(swipeout$attribs$class, "swipeout swiper-no-swiping")
  expect_length(swipeout$children, 3)
  expect_identical(swipeout$children[[1]]$attribs$class, "swipeout-content")
})

test_that("swipeout item works", {
  swipeout_item <- f7SwipeoutItem("test", "test")
  expect_identical(swipeout_item$attribs$class, "swipeout-item")
  expect_identical(swipeout_item$attribs$id, "test")
})
