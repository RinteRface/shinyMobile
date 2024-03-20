test_that("list works", {
  expect_s3_class(f7List(), "shiny.tag")
  list_tag <- f7List(
    inset = TRUE,
    strong = TRUE,
    outline = TRUE,
    dividers = TRUE,
    mode = "media"
  )

  expect_identical(
    list_tag$attribs$class,
    "list chevron-center list-strong list-outline list-dividers media-list inset"
  )
})

test_that("list item works", {
  expect_s3_class(f7ListItem(), "shiny.tag")
  list_item <- f7ListItem(
    title = "Title",
    subtitle = "subtitle",
    header = "Header",
    footer = "Footer",
    href = "https://www.google.com",
    media = tags$img(
      src = "https://cdn.framework7.io/placeholder/people-160x160-1.jpg"
    ),
    right = "After item",
    "Item content"
  )
  expect_identical(list_item$name, "li")
})
