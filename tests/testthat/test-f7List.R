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

  expect_error(f7ListItem(right = "test"))
  expect_error(f7ListItem(right = "test", header = "header"))
  expect_error(f7ListItem(right = "test", footer = "footer"))

  list_item <- f7ListItem(
    title = "Title",
    subtitle = "subtitle",
    href = "https://www.google.com",
    media = shiny::tags$img(
      src = "https://cdn.framework7.io/placeholder/people-160x160-1.jpg"
    ),
    right = "After item",
    "Item content"
  )
  expect_identical(list_item$name, "li")
})

test_that("list group works", {
  expect_s3_class(f7ListGroup(title = "plop"), "shiny.tag")
  list_group <- f7ListGroup(
    title = "test",
    lapply(1:3, \(x) f7ListItem(x))
  )
  expect_identical(list_group$attribs$class, "list-group")
})
