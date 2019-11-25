# # list all input bindings
# bindings <- list.files(
#   path = system.file("framework7-5.1.3/input-bindings", package = "shinyMobile"),
#   pattern = "Binding\\.js$",
#   recursive = TRUE,
#   full.names = TRUE
# )
#
# test_that("check-input-bindings", {
#   # check them
#   res <- jshint_file(
#     input = bindings,
#     options =
#       jshint_options(
#         undef = FALSE, # to ignore undefined vars.
#         jquery = TRUE,
#         globals = list("Shiny"),
#         evil = TRUE # to ensure that eval does not return a warning
#       )
#   )
#
#   # capture errors
#   errors <- unlist(lapply(seq_along(res), function (i) res[[i]]$errors))
#   # expect no errors
#   expect_identical(errors, NULL)
# })
