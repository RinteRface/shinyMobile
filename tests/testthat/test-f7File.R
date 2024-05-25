test_that("f7File works", {
  up_tag <- f7File("up", "Upload!")
  input <- htmltools::tagQuery(up_tag)$find("input")$selectedTags()
  expect_identical(input[[1]]$attribs$type, "file")
  expect_identical(input[[1]]$attribs$id, "up")
  expect_identical(input[[2]]$attribs$type, "text")

  progress <- htmltools::tagQuery(up_tag)$
    find(".shiny-file-input-progress")$selectedTags()
  expect_length(progress, 1)
  expect_identical(progress[[1]]$attribs$id, "up_progress")
})
