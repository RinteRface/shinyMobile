test_that("updateF7App works", {
  session <- as.environment(list(
    ns = identity,
    sendCustomMessage = function(type, message) {
      session$lastCustomMessage <- list(type = type, message = message)
    }
  ))

  opts <- list(
    dialog = list(
      buttonOk = "Yeaaaah!",
      buttonCancel = "Ouuups!"
    )
  )

  updateF7App(
    options = opts,
    session = session
  )

  res <- session$lastCustomMessage
  res$message <- jsonlite::fromJSON(res$message)
  expect_length(res, 2)
  expect_equal(res$type, "update-app")
})
