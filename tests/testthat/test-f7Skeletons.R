test_that("skeletons works", {
  session <- as.environment(list(
    ns = identity,
    sendCustomMessage = function(type, message) {
      session$lastCustomMessage <- list(type = type, message = message)
    }
  ))

  f7Skeleton(
    ".card",
    "fade",
    1,
    session = session
  )

  res <- session$lastCustomMessage
  res$message <- jsonlite::fromJSON(res$message)
  expect_length(res, 2)
  expect_equal(res$type, "add-skeleton")
  expect_length(res$message$target, ".card")
  expect_equal(res$message$effect, "fade")
  expect_equal(res$message$duration, 1L)
})
