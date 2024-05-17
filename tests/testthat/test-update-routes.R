test_that("updateF7Routes works", {
  session <- as.environment(list(
    ns = identity,
    sendCustomMessage = function(type, message) {
      session$lastCustomMessage <- list(type = type, message = message)
    }
  ))

  routes <- list(
    list(path = "/new", url = "/new", name = "new", keepAlive = TRUE)
  )

  updateF7Routes(
    routes,
    session = session
  )

  res <- session$lastCustomMessage
  expect_identical(res$message, routes)
  expect_equal(res$type, "update-routes")
})