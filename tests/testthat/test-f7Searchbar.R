test_that("searchbar tag works", {
  searchbar <- f7Searchbar(
    id = "test",
    options = list(customSearch = TRUE)
  )

  config <- searchbar[[2]]
  search_content <- searchbar[[1]]

  expect_s3_class(searchbar, "shiny.tag.list")
  expect_identical(config$attribs$`data-for`, "test")
  expect_identical(
    jsonlite::fromJSON(config$children[[1]]),
    list(customSearch = TRUE)
  )

  expect_identical(search_content$name, "form")
  expect_identical(search_content$attribs$class, "searchbar")
  expect_identical(search_content$attribs$id, "test")

  # Expandable
  searchbar <- f7Searchbar(
    id = "test",
    expandable = TRUE
  )

  expect_true(grepl("searchbar-expandable", searchbar[[1]]$attribs$class))

  # Inline
  searchbar <- f7Searchbar(
    id = "test",
    inline = TRUE
  )

  expect_true(grepl("searchbar-inline", searchbar[[1]]$attribs$class))
})

test_that("searchbar trigger works", {
  trigger <- f7SearchbarTrigger("test")
  expect_identical(trigger$name, "a")
  expect_identical(trigger$attribs$`data-searchbar`, "#test")
  expect_true(grepl("searchbar-enable", trigger$attribs$class))
})

test_that("hide on search works", {
  res <- f7HideOnSearch(shiny::tags$div())
  expect_true(grepl("searchbar-hide-on-search", res$attribs$class))
})

test_that("hide on enable works", {
  res <- f7HideOnEnable(shiny::tags$div())
  expect_true(grepl("searchbar-hide-on-enable", res$attribs$class))
})

test_that("Not found works", {
  res <- f7NotFound(shiny::tags$div())
  expect_true(grepl("searchbar-not-found", res$attribs$class))
})

test_that("Found works", {
  res <- f7Found(shiny::tags$div())
  expect_true(grepl("searchbar-found", res$attribs$class))
})

test_that("Search ignore works", {
  res <- f7SearchIgnore(shiny::tags$div())
  expect_true(grepl("searchbar-ignore", res$attribs$class))
})

test_that("searchbar works", {
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/searchbar/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "searchbar-app"
  )

  # Open
  app$click(selector = "[data-searchbar=\"#search1\"]")
  app$run_js("app.searchbar.search('.searchbar', 'mobile')")
  app$wait_for_idle(2000)
  app$expect_html(selector = ".searchbar-found")
  app$click(selector = ".input-clear-button")
  app$wait_for_idle(2000)
  app$expect_html(selector = ".searchbar-found")
})
