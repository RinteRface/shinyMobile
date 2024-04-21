test_that("updateF7App works", {
  session <- as.environment(list(
    ns = identity,
    sendCustomMessage = function(type, message) {
      session$lastCustomMessage <- list(type = type, message = message)
    }
  ))

  updateF7Entity(
    id = "action",
    options = list(
      buttons = list(
        list(
          text = "Notification",
          icon = f7Icon("info"),
          color = NULL
        )
      )
    ),
    session = session
  )

  res <- session$lastCustomMessage
  res$message <- jsonlite::fromJSON(res$message)
  expect_length(res, 2)
  expect_equal(res$type, "update-entity")
  expect_equal(res$message$id, "action")
})
