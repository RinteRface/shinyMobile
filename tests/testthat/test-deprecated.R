test_that("deprecated messages work", {
  expect_snapshot(f7SocialCard())
  expect_snapshot(f7Menu())
  expect_snapshot(f7MenuItem("ee", "Label"))
  expect_snapshot(f7MenuDropdown(label = "label"))
  expect_snapshot(f7MenuDropdownDivider())

  expect_error({
    session <- as.environment(list(
      ns = identity,
      sendInputMessage = function(inputId, message) {
        session$lastInputMessage <- list(inputId = inputId, message = message)
      }
    ))
    updateF7MenuDropdown("id", session)
  })

  expect_snapshot(f7Row())
  expect_snapshot(f7Col())
  expect_snapshot(f7Flex())
  expect_snapshot(f7Shadow(shiny::div(), 4))
  #expect_snapshot(create_manifest(tempdir()))
})
