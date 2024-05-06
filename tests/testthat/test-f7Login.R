library(shinytest2)

test_that("login works", {
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/login/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "login-app"
  )

  app$expect_values(input = "login", export = "res")

  app$set_inputs("login-user" = "usr", "login-password" = "pwd")
  app$wait_for_idle(2000)
  # Wait for any animation to complete
  app$click(selector = "#login-submit")
  app$wait_for_idle(2000)
  app$expect_values(input = "login", export = "res")
})
