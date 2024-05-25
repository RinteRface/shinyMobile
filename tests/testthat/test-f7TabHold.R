test_that("Tap Hold works", {
  session <- as.environment(list(
    ns = identity,
    sendCustomMessage = function(type, message) {
      session$lastCustomMessage <- list(type = type, message = message)
    }
  ))

  f7TapHold(
    target = "#pressme",
    callback = "app.dialog.alert('Tap hold fired!')",
    session = session
  )

  res <- session$lastCustomMessage
  expect_length(res, 2)
  expect_equal(res$type, "tapHold")
  expect_equal(res$message$target, "#pressme")
  expect_equal(res$message$callback, "app.dialog.alert('Tap hold fired!')")
})
