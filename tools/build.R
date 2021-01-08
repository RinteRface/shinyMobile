library(charpent)

# order files
jsFiles <- list.files("srcjs")
initJS <- which(jsFiles == "init.js")
appJS <- which(jsFiles == "app.js")
jsFiles <- jsFiles[-c(initJS, appJS)]

# build
build_js(files = paste0("srcjs/", c("init.js", "app.js", jsFiles)))
build_js(files = paste0("srcjs/", c("init.js", "app.js", jsFiles)), mode = "dev")
