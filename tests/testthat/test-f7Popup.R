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
  app$click(select = "#toggle1")
  app$wait_for_idle(3000)
  app$expect_values(input = "popup1")

  # Inputs work in a popup
  app$set_inputs("text1" = "balbla")
  app$wait_for_idle(1000)
  app$expect_values(input = c("popup1", "text1"), output = "res1")

  # Close
  app$click(select = ".popup-close")
  app$wait_for_idle(1000)
  app$expect_values(input = "popup1")

  # Open
  app$click(select = "#toggle2")
  app$wait_for_idle(3000)
  app$expect_values(input = "popup2")

  # Inputs work in a popup
  app$set_inputs("text2" = "balbla")
  app$wait_for_idle(1000)
  app$expect_values(input = c("popup2", "text2"), output = "res2")

  # Close
  app$click(select = ".popup-close")
  app$wait_for_idle(1000)
  app$expect_values(input = "popup2")
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
  expect_equal(grepl("page-content", res$message$content), FALSE)


  f7Popup(
    id = "popup",
    title = "My first popup",
    page = TRUE,
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
  expect_equal(grepl("page-content", res$message$content), TRUE)

})
