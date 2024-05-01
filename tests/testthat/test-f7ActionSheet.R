context("f7ActionSheet")
library(shinytest2)

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

test_that("actionSheet work as expected", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/actionsheet/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "actionsheet-app"
  )

  app$expect_values(input = c("sheet1-action1", "sheet1-action1_button"))

  app$click(selector = "#sheet1-go")
  app$wait_for_idle(3000)
  app$expect_values(input = c("sheet1-action1"))

  app$click(selector = ".actions-button:first-child")
  app$wait_for_idle(3000)
  app$expect_values(input = c("sheet1-action1", "sheet1-action1_button"))

  app$click(selector = "#sheet1-go")
  app$wait_for_idle(3000)
  app$click(selector = ".actions-button:nth-child(2)")
  app$expect_values(input = c("sheet1-action1", "sheet1-action1_button"))

  app$click(selector = "div.dialog-buttons > span:nth-child(1)")
  app$click(selector = "#sheet1-update")
  app$click(selector = "#sheet1-go")
  app$wait_for_idle(3000)
  app$click(selector = ".actions-button:first-child")
  app$expect_values(input = c("sheet1-action1", "sheet1-action1_button"))
})
