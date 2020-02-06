context("f7Accordion")

test_that("accordion", {
  expect_shinytaglist(f7Accordion())
  # [[1]] is the f7InputDeps() slot
  # [[2]] is the accordion wrapper slot
  expect_equal(
    f7Accordion()[[2]]$attribs$class,
    "list accordion-list"
  )

  # id
  expect_equal(
    f7Accordion(inputId = "test")[[2]]$attribs$id,
    "test"
  )

  # check that children are wrapped by an <ul></ul>
  expect_equal(f7Accordion()[[2]]$children[[1]]$name, "ul")

  # multicollapse
  expect_equal(
    f7Accordion(multiCollapse = TRUE)[[2]]$attribs$class,
    "list"
  )
})


test_that("accordion items", {
  expect_shinytag(f7AccordionItem())
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
      session$lastInputMessage = list(id = inputId, message = message)
    }
  ))

  updateF7Accordion(session = session, inputId = "accordion", selected = 1)
  result <- session$lastInputMessage

  expect_equal(result$message$selected, 1)
  expect_equal(result$id, "accordion")

})
