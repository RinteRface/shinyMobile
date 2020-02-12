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
    buttons = data.frame(
      text = c('Notification', 'Dialog'),
      color = c(NA, NA)
    ),
    icons = list(
      f7Icon("info"),
      f7Icon("lightbulb_fill")
    )
  )

  res <- session$lastCustomMessage
  expect_length(res, 2)
  expect_equal(res$type, "action-sheet")
  expect_length(res$message, 4)
  expect_is(res$message$buttons, "json")
  expect_equal(res$message$grid, "false")
  expect_length(res$message$icons, 2)
  expect_equal(res$message$id, "action")
})

