context("f7Badge")

test_that("basic test", {

  badge <- f7Badge("mybadge")
  expect_shinytag(badge)
  expect_equal(badge$name, "span")
  expect_equal(badge$attribs$class, "badge")

  # with color
  badgeColor <- f7Badge("hello", color = "red")
  expect_equal(badgeColor$attribs$class, "badge color-red")
  expect_error(f7Badge("hello", color = "diamonds"))

  # Below we make sure that shinyMobile is still up to date
  # regarding framework7 css classes. Indeed, if for some reasons
  # framework7 would change the badge class to another name, f7Badge would
  # fail to render correctly (because of wrong CSS). The tests above only capture
  # potential shinyMobile braking changes but not external breaking changes (not due
  # to shinyMobile).
  ui <- f7Badge("32", color = "green")
  expect_html_equal(
    ui = ui,
    html = system.file("tests/templates/badge.html", package = "shinyMobile")
  )

})
