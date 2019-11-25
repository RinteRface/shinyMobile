library(testthat)
library(shinyMobile)
library(V8)
library(rstudioapi)
library(cli)


# # These helpers are from Victor Perrier, \email{info@@dreamrs.fr}
# jshint_file <- function(input, options = jshint_options()) {
#   if (length(input) > 1) {
#     output <- lapply(input, jshint_file, options = options)
#     return(invisible(output))
#   }
#   input <- normalizePath(path = input, mustWork = TRUE)
#   cat(rule(left = sprintf("Checking %s", basename(input)), width = 80), "\n")
#   input <- readLines(con = input, encoding = "UTF-8")
#   output <- jshint(code = input, options = options)
#   if (NROW(output$errors) == 0) {
#     # cli::cli_alert_success("No errors.")
#     cat(col_green("No errors found."), "\n")
#   } else {
#     errs <- output$errors
#     errs <- errs[order(errs$line), ]
#     cat(col_red(sprintf("%s errors found.", nrow(errs))), "\n")
#     for (i in seq_len(nrow(errs))) {
#       # cli::cli_alert_danger()
#       cat(col_red(sprintf(" - Line %s: %s", errs$line[i], errs$reason[i])), "\n")
#     }
#   }
#   invisible(output)
# }
#
#
# jshint <- function(code, options = jshint_options()) {
#   ctx <- v8()
#   ctx$source(
#     file = system.file("assets/jshint/jshint.js", package = "jstools")
#   )
#   ctx$assign("code", code)
#   ctx$assign("options", options)
#   ctx$assign("predef", list())
#   ctx$eval("JSHINT(code, options, predef);")
#   output <- ctx$get("JSHINT.data()")
#   class(output) <- c(class(output), "jshint")
#   return(output)
# }
#
# jshint_options <- function(undef = TRUE, unused = "vars",
#                            browser = TRUE, jquery = FALSE,
#                            devel = FALSE, ...) {
#   list(
#     undef = undef,
#     unused = unused,
#     browser = browser,
#     jquery = jquery,
#     devel = devel,
#     ...
#   )
# }
#
#
# jshint_addin <- function() {
#   context <- getSourceEditorContext()
#   jshint_file(input = context$path)
# }
#
# test_check("shinyMobile")
