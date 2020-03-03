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
#' @param background_color The background_color property is used on the splash screen when the application is first launched.
#' @param theme_color The theme_color sets the color of the tool bar, and may be reflected in the app's preview in task switchers.
#' @param icon Dataframe containing icon specs. src gives the icon path
#' (in the www folder for instance), sizes gives the size and types the type.
#'
#' @return This function creates a www folder for your shiny app. Must specify the path.
#' It creates 1 folders to contain icons and the manifest.json file.
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
#'   background_color = "#3367D6",
#'   theme_color = "#3367D6",
#'   icon = data.frame(
#'     src = "icons/128x128.png",
#'     sizes = "128x128", 10,
#'     types = "image/png"
#'   )
#' )
create_manifest <- function(path, name = "My App", shortName = "My App",
                            description = "What it does!", lang = "en-US",
                            startUrl, display = c("minimal-ui", "standalone", "fullscreen", "browser"),
                            background_color = "#000000", theme_color = "#0000ffff",
                            icon) {

  display <- match.arg(display)

  manifest <- list(
    name = name,
    short_name = shortName,
    description = description,
    lang = lang,
    start_url = startUrl,
    display = display,
    background_color = background_color,
    theme_color = theme_color,
    icon = icon
  )
  manifest <- jsonlite::toJSON(manifest, pretty = TRUE, auto_unbox = TRUE)
  print(manifest)
  # create /wwww folder if does not exist yet
  if (!dir.exists(paste0(path, "/www"))) {
    dir.create(paste0(path, "/www"))
    dir.create(paste0(path, "/www/icons"))
  }
  jsonlite::write_json(manifest, path = paste0(path, "/www/manifest.json"))
}
