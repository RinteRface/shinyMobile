test_that("notif R function", {
  session <- as.environment(list(
    ns = identity,
    sendCustomMessage = function(type, message) {
      session$lastCustomMessage <- list(type = type, message = message)
    }
  ))

  f7Notif(
    text = "test",
    icon = f7Icon("bolt_fill"),
    title = "Notification",
    subtitle = "A subtitle",
    titleRightText = "now",
    session = session
  )

  res <- session$lastCustomMessage
  res$message <- jsonlite::fromJSON(res$message)
  expect_length(res, 2)
  expect_equal(res$type, "notification")
  expect_length(res$message, length(formals(f7Notif)) - 2)
  expect_equal(res$message$closeTimeout, formals(f7Notif)$closeTimeout)
})
