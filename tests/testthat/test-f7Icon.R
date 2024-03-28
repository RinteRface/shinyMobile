test_that("icon works", {
  icon <- f7Icon("envelope", color = "red")
  expect_s3_class(icon, "shiny.tag")
  expect_identical(
    icon$attribs$class,
    "icon f7-icons color-red"
  )

  md_icon <- f7Icon("envelope", lib = "md")
  expect_identical(
    md_icon$attribs$class,
    "icon material-icons md-only"
  )

  ios_icon <- f7Icon("envelope", lib = "ios")
  expect_identical(
    ios_icon$attribs$class,
    "icon f7-icons if-not-md"
  )
})
