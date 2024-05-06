library(shinytest2)

test_that("popup works", {
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/popup/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "popup-app"
  )

  # Open
  app$click(select = "#toggle")
  app$wait_for_idle(3000)
  app$expect_values(input = "popup")

  # Inputs work in a popup
  app$set_inputs("text" = "balbla")
  app$wait_for_idle(1000)
  app$expect_values(input = c("popup", "text"), output = "res")

  # Close
  app$click(select = ".popup-close")
  app$wait_for_idle(1000)
  app$expect_values(input = "popup")
})

test_that("Popup R function work", {
  session <- as.environment(list(
    ns = identity,
    sendCustomMessage = function(type, message) {
      session$lastCustomMessage <- list(type = type, message = message)
    }
  ))

  f7Popup(
    id = "popup",
    title = "My first popup",
    f7Text(
      "text", "Popup content",
      "This is my first popup ever, I swear!"
    ),
    shiny::verbatimTextOutput("res"),
    session = session
  )

  res <- session$lastCustomMessage
  res$message <- jsonlite::fromJSON(res$message)
  expect_length(res, 2)
  expect_equal(res$type, "popup")
  expect_identical(res$message$id, "popup")
})
