

# Packages ----------------------------------------------------------------

library(jstools)




# Validate ----------------------------------------------------------------

bindings <- list.files(
  path = "inst/framework7-5.5.0/input-bindings/",
  recursive = TRUE,
  full.names = TRUE
)
jshint_file(input = bindings, options = jshint_options(jquery = TRUE, globals = list("Shiny", "app")))




# Compress ----------------------------------------------------------------

terser_file(input = bindings, output = "inst/framework7-5.5.0/framework7.bindings.min.js")
