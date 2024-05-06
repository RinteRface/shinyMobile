test_that("color picker works", {
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/colorpicker/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "colorpicker-app"
  )

  app$wait_for_idle(2000)
  app$expect_values(input = "mycolorpicker")
  app$click(selector = "#mycolorpicker")
  app$wait_for_idle(2000)
  app$click(selector = ".color-picker-palette-value[data-palette-color='#FB8C00']")
  app$wait_for_idle(2000)
  app$expect_values(input = "mycolorpicker")
})
