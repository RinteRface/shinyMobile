test_that("pwa compat deps", {
  tag <- add_pwacompat_deps(div())
  deps <- htmltools::findDependencies(tag)
  expect_is(deps, "list")
  expect_length(deps, 1)
  dep <- deps[[1]]
  expect_identical(dep$name, "pwacompat")
})

test_that("pwa deps", {
  tag <- add_pwa_deps(div())
  deps <- htmltools::findDependencies(tag)
  expect_is(deps, "list")
  expect_length(deps, 1)
  dep <- deps[[1]]
  expect_identical(dep$name, "pwa-utils")
})
