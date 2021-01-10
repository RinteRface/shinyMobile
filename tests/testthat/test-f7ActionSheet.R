context("f7ActionSheet")

test_that("send custom message", {
  session <- as.environment(list(
    ns = identity,
    sendCustomMessage = function(type, message) {
      session$lastCustomMessage <- list(type = type, message = message)
    }
  ))

  f7ActionSheet(
    id = "action",
    session = session,
    grid = FALSE,
    buttons = list(
      list(
        text = "Notification",
        icon = f7Icon("info"),
        color = NULL
      ),
      list(
        text = "Dialog",
        icon = f7Icon("lightbulb_fill"),
        color = NULL
      )
    )
  )

  res <- session$lastCustomMessage
  res$message <- jsonlite::fromJSON(res$message)
  expect_length(res, 2)
  expect_equal(res$type, "action-sheet")
  expect_length(res$message, 3)
  expect_is(res$message$buttons, "data.frame")
  expect_equal(res$message$grid, FALSE)
  expect_equal(res$message$id, "action")
})

