test_that("preloader functions work", {
  session <- as.environment(list(
    ns = identity,
    sendCustomMessage = function(type, message) {
      session$lastCustomMessage <- list(type = type, message = message)
    }
  ))

  # Show
  showF7Preloader(
    id = "loader",
    type = "dialog",
    color = "red",
    session = session
  )

  res <- session$lastCustomMessage
  expect_length(res, 2)
  expect_equal(res$type, "show-preloader")
  expect_identical(res$message$type, "dialog")
  expect_equal(res$message$color, "red")
  expect_equal(res$message$id, "loader")

  # Hide
  hideF7Preloader(id = "loader", session = session)

  res <- session$lastCustomMessage
  expect_length(res, 2)
  expect_equal(res$type, "hide-preloader")
  expect_equal(res$message$id, "loader")

  # Update
  updateF7Preloader(
    id = "loader",
    title = "title",
    text = "text",
    session = session
  )

  res <- session$lastCustomMessage
  expect_length(res, 2)
  expect_equal(res$type, "update-preloader")
  expect_equal(res$message$id, "loader")
  expect_equal(res$message$title, "title")
  expect_equal(res$message$text, "text")
})
