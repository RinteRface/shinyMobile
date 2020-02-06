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
