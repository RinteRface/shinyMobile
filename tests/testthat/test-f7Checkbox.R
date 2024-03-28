test_that("checkbox tag", {
  checkbox <- f7Checkbox("check", "Checkbox")
  expect_s3_class(checkbox, "shiny.tag.list")
  expect_length(checkbox, 2)
  expect_identical(checkbox[[2]]$attribs$class, "checkbox")
  expect_identical(checkbox[[2]]$children[[1]]$attribs$id, "check")
})

library(shinytest2)
test_that("checkbox works as expected", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/checkbox/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "checkbox-app",
    variant = platform_variant()
  )
  app$expect_values(input = "checkbox")
  app$click(selector = "#update")
  app$expect_values(input = "checkbox")
})

test_that("checkboxgroup tag", {
  checkbox_group <- f7CheckboxGroup(
    inputId = "checkboxgroup",
    label = "Choose a variable:",
    choices = colnames(mtcars)[-1],
    selected = "disp",
    position = "right"
  )
  expect_s3_class(checkbox_group, "shiny.tag.list")
  expect_length(checkbox_group, 2)
  expect_identical(checkbox_group[[1]]$attribs$class, "block-title")
  expect_identical(checkbox_group[[2]]$attribs$id, "checkboxgroup")
  expect_identical(
    checkbox_group[[2]]$attribs$class,
    "list chevron-center shiny-input-checkboxgroup"
  )

  # Test if items number match the choices param.
  items <- htmltools::tagQuery(checkbox_group[[2]])$
    find("li")$
    selectedTag()

  expect_length(items, length(colnames(mtcars)) - 1)

  # With f7CheckboxChoice
  expect_error(
    f7CheckboxGroup(
      inputId = "checkboxgroup2",
      label = "Custom choices",
      choices = list(
        f7CheckboxChoice(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        Nulla sagittis tellus ut turpis condimentum,
        ut dignissim lacus tincidunt",
          title = "Choice 1",
          subtitle = "David",
          after = "March 16, 2024"
        )
      ),
      selected = 2
    )
  )
  checkbox_group <- f7CheckboxGroup(
    inputId = "checkboxgroup2",
    label = "Custom choices",
    choices = list(
      f7CheckboxChoice(
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
        Nulla sagittis tellus ut turpis condimentum,
        ut dignissim lacus tincidunt",
        title = "Choice 1",
        subtitle = "David",
        after = "March 16, 2024"
      )
    )
  )

  expect_true(grepl("media-list", checkbox_group[[2]]$attribs$class))
})

library(shinytest2)
test_that("checkboxgroup works as expected", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/checkboxgroup/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "checkboxgroup-app",
    variant = platform_variant()
  )
  app$expect_values(input = c("checkboxgroup", "checkboxgroup2"))
  app$set_inputs("checkboxgroup" = "wt", "checkboxgroup2" = "1")
  app$expect_values(input = c("checkboxgroup", "checkboxgroup2"))
})
