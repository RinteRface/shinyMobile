test_that("f7DownloadButton works", {
  tag <- f7DownloadButton("download","Download!")
  expect_s3_class(tag, "shiny.tag")
  expect_identical(tag$attribs$id, "download")
  expect_identical(
    tag$attribs$class,
    "button button-fill external shiny-download-link"
  )
  expect_identical(tag$attribs$download, NA)
})
