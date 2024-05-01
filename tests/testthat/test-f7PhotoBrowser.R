library(shinytest2)
test_that("photobrowser works", {
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/photobrowser/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "photobrowser-app"
  )

  # Open
  app$click(selector = "#togglePhoto")
  app$wait_for_idle(3000)
  app$expect_values(input = "photobrowser1")

  # Close
  app$click(select = ".left > .link.icon-only.back")
  app$wait_for_idle(3000)
  app$expect_values(input = "photobrowser1")
})

test_that("photobrowser R function works", {
  session <- as.environment(list(
    ns = identity,
    sendCustomMessage = function(type, message) {
      session$lastCustomMessage <- list(type = type, message = message)
    }
  ))

  f7PhotoBrowser(
    id = "photobrowser1",
    theme = "dark",
    type = "page",
    photos = list(
      list(url = "https://cdn.framework7.io/placeholder/sports-1024x1024-1.jpg"),
      list(url = "https://cdn.framework7.io/placeholder/sports-1024x1024-2.jpg"),
      list(
        url = "https://cdn.framework7.io/placeholder/sports-1024x1024-3.jpg",
        caption = "Me cycling"
      )
    ),
    thumbs = c(
      "https://cdn.framework7.io/placeholder/sports-1024x1024-1.jpg",
      "https://cdn.framework7.io/placeholder/sports-1024x1024-2.jpg",
      "https://cdn.framework7.io/placeholder/sports-1024x1024-3.jpg"
    ),
    session = session
  )

  res <- session$lastCustomMessage
  res$message <- jsonlite::fromJSON(res$message)
  expect_length(res, 2)
  expect_equal(res$type, "photoBrowser")
  expect_equal(res$message$id, "photobrowser1")
  expect_equal(res$message$type, "page")
})
