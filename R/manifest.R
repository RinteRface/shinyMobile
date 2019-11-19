#' Create a manifest for your shiny app
#'
#' This is a central piece if you want to have your app standalone for instance
#'
#' @param path package path.
#' @param name App name.
#' @param shortName App short name.
#' @param description App description
#' @param lang App language (en-US by default).
#' @param startUrl Page to open at start.
#' @param display Display mode. Choose among \code{c("minimal-ui", "standalone", "fullscreen", "browser")}.
#' In practice, you want the standalone mode so that the app looks like a native app.
#' @param icons Dataframe containing icons specs for instance \code{data.frame(src = rep("icons/128x128.png", 10), sizes = rep("128x128", 10), types = rep("image/png", 10))}.
#' src gives the icon path (in the www folder for instance), sizes gives the size and types the type.
#'
#' @return This function creates a www folder for your shiny app. Must specify the path.
#' It also creates 2 additional folders to contain icons and splashscreen (splashscreen creation
#' is not automatic for iOS). It also creates the manifest.json file in this www folder.
#' You still have to create your own icons and splashscreen!
#'
#' @note See \url{https://developer.mozilla.org/en-US/docs/Web/Manifest} for more informations.
#' @export
#'
#' @examples
#' create_manifest(
#'   path = tempdir(),
#'   name = "My App",
#'   shortName = "My App",
#'   description = "What it does!",
#'   lang = "en-US",
#'   startUrl = "https://www.google.com/",
#'   display = "standalone",
#'   icons = data.frame(
#'     src = rep("icons/128x128.png", 10),
#'     sizes = rep("128x128", 10),
#'     types = rep("image/png", 10)
#'   )
#' )
create_manifest <- function(path, name = "My App", shortName = "My App",
                            description = "What it does!", lang = "en-US",
                            startUrl, display = c("minimal-ui", "standalone", "fullscreen", "browser"),
                            icons) {

  display <- match.arg(display)

  manifest <- list(
    name = name,
    short_name = shortName,
    description = description,
    lang = lang,
    start_url = startUrl,
    display = display,
    icons = icons
  )
  manifest <- jsonlite::toJSON(manifest, pretty = TRUE, auto_unbox = TRUE)
  print(manifest)
  # create /wwww folder if does not exist yet
  if (!dir.exists(paste0(path, "/www"))) {
    dir.create(paste0(path, "/www"))
    dir.create(paste0(path, "/www/icons"))
    dir.create(paste0(path, "/www/splashscreens"))
  }
  jsonlite::write_json(manifest, path = paste0(path, "/www/manifest.json"))
}
