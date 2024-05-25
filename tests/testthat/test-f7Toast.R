test_that("Toast works", {
  session <- as.environment(list(
    ns = identity,
    sendCustomMessage = function(type, message) {
      session$lastCustomMessage <- list(type = type, message = message)
    }
  ))

  f7Toast(
    position = "top",
    text = "I am a toast. Eat me!",
    session = session
  )

  res <- session$lastCustomMessage
  res$message <- jsonlite::fromJSON(res$message)
  expect_length(res, 2)
  expect_equal(res$type, "toast")
  expect_length(res$message, length(formals(f7Toast)) - 3)
  expect_equal(res$message$closeTimeout, formals(f7Toast)$closeTimeout)
})
