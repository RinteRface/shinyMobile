library(shinytest2)

test_that("accordion", {
  expect_true(inherits(f7Accordion(), "shiny.tag"))
  expect_equal(f7Accordion()$attribs$class, "list list-strong list-outline-ios list-dividers-ios inset-md accordion-list")

  # Opposite
  cl <- f7Accordion(side = "left")$attribs$class
  expect_true(grepl("accordion-opposite", cl))

  # id
  expect_equal(
    f7Accordion(id = "test")$attribs$id,
    "test"
  )

  # check that children are wrapped by an <ul></ul>
  expect_equal(f7Accordion()$children[[1]]$name, "ul")
})

test_that("accordion items", {
  expect_true(inherits(f7AccordionItem(), "shiny.tag"))
  expect_equal(f7AccordionItem()$name, "li")
  expect_equal(f7AccordionItem()$attribs$class, "accordion-item")
  expect_equal(
    f7AccordionItem(open = TRUE)$attribs$class,
    "accordion-item accordion-item-opened"
  )

  # structure: [[1]] is the link, [[2]] is the content
  item <- f7AccordionItem(open = TRUE)$children
  expect_length(item, 2)
  expect_equal(item[[1]]$name, "a")
  expect_equal(item[[1]]$children[[1]]$attribs$class, "item-inner")
  expect_equal(item[[1]]$children[[1]]$children[[1]]$attribs$class, "item-title")
  expect_equal(item[[2]]$name, "div")
  expect_equal(item[[2]]$attribs$class, "accordion-item-content")
})

test_that("update", {
  session <- as.environment(list(
    ns = identity,
    sendInputMessage = function(inputId, message) {
      session$lastInputMessage <- list(id = inputId, message = message)
    }
  ))

  updateF7Accordion(session = session, id = "accordion", selected = 1)
  result <- session$lastInputMessage

  expect_equal(result$message$selected, 1)
  expect_equal(result$id, "accordion")
})

test_that("accordion works as expected", {
  # Don't run these tests on the CRAN build servers
  skip_on_cran()
  shiny_app_path <-
    system.file("examples/accordion/app.R", package = "shinyMobile")
  app <- AppDriver$new(
    shiny_app_path,
    name = "accordion-app"
  )
  app$expect_values(input = "myaccordion1")
  app$click(selector = "#go")
  # Animation/transition takes a bit of time
  app$wait_for_idle(1000)
  app$expect_values(input = "myaccordion1")
})
