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
  expect_error(f7ListItem(subtitle = "subtitle"))
  expect_error(f7ListItem(routable = TRUE))
  expect_error(f7List(mode = "media", f7ListItem(header = "header", footer = "footer")))

  list_item <- f7ListItem(
    mode = "media",
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
    lapply(1:3, function(x) f7ListItem(x))
  )
  expect_identical(list_group$attribs$class, "list-group")
})

test_that("list index works", {
  session <- as.environment(list(
    ns = identity,
    sendCustomMessage = function(type, message) {
      session$lastCustomMessage <- list(type = type, message = message)
    }
  ))

  f7ListIndex(id = "test", target = "#test", session = session)

  res <- session$lastCustomMessage
  res$message <- jsonlite::fromJSON(res$message)
  expect_length(res, 2)
  expect_equal(res$type, "listIndex")
  expect_equal(res$message$el, "test")
  expect_equal(res$message$listEl, "#test")
})
