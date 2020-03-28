#' Allow to preview a given app on different devices.
#'
#' @param appPath App to preview if local.
#' @param url App to preview if online.
#' @param port Default port. Ignored if url is provided.
#' @param device Wrapper devices.
#' @param color Wrapper color. Only with iphone8 (black, silver, gold),
#' iphone8+ (black, silver, gold), iphone5s (black, silver, gold),
#' iphone5c (white,red , yellow, green, blue), iphone4s (black, silver), ipadMini (black, silver) and
#' galaxyS5 (black, white).
#' @param landscape Whether to put the device wrapper in landscape mode. Default to FALSE.
#'
#' @note choose either url or appPath!
#'
#' @return A shiny app containing an iframe surrounded by the device wrapper.
#' @export
#'
#' @examples
#' if (interactive()) {
#'  library(shiny)
#'  library(shinyMobile)
#'  preview_mobile(appPath = "~/whatever", device = "galaxyNote8")
#'  preview_mobile(url = "https://dgranjon.shinyapps.io/miniUI2DemoMd", device = "ipadMini")
#' }
preview_mobile <- function(appPath = NULL, url = NULL, port = 3838,
                           device = c(
                             "iphoneX",
                             "galaxyNote8",
                             "iphone8",
                             "iphone8+",
                             "iphone5s",
                             "iphone5c",
                             "ipadMini",
                             "iphone4s",
                             "nexus5",
                             "galaxyS5",
                             "htcOne"
                           ),
                           color = NULL,
                           landscape = FALSE
) {

  # some tests
  if (!is.numeric(port)) stop("Port must be numeric")
  if (!is.null(appPath) & !is.null(url)) stop("Choose either local or online app")
  if (is.null(appPath) & is.null(url)) stop("Choose at least one option")
  if (!is.null(appPath) & is.null(port)) stop("Please set a port when running locally")

  # set up the height
  appHeight <- switch(
    device,
    "iphoneX" = if (!landscape) 812 else 375,
    "galaxyNote8" = if (!landscape) 822 else 400,
    "iphone8" = if (!landscape) 670 else 375,
    "iphone8+" = if (!landscape) 736 else 415,
    "iphone5s" = if (!landscape) 570 else 325,
    "iphone5c" = if (!landscape) 570 else 325,
    "ipadMini" = if (!landscape) 770 else 580,
    "iphone4s" = if (!landscape) 485 else 325,
    "nexus5" = if (!landscape) 570 else 320,
    "galaxyS5" = if (!landscape) 570 else 320,
    "htcOne" = if (!landscape) 570 else 320
  )

  # run the shiny app to test
  if (!is.null(appPath)) {
    message("Copy in your terminal (not the R console): R -e \"shiny::runApp('", appPath, "', port = ", port, ")\"")
    invisible(readline(prompt = "Press [enter] to continue"))
  }

  # iframe
  iframeApp <- shiny::tags$iframe(
    width = "100%",
    src = if (!is.null(appPath)) {
      paste0("http://127.0.0.1:", port)
    } else {
      url
    },
    allowfullscreen = "",
    frameborder = "0",
    scrolling = "no",
    height = paste0(appHeight, "px") # height depends on the choosen device!
  )

  # master app
  ui <- create_app_ui(iframeApp, device, color, landscape)
  server <- function(input, output, session) {}

  shiny::runApp(
    list(
      ui = ui,
      server = server
    ),
    port = port / 2,
    launch.browser = TRUE
  )
  invisible(ui)
}



#' Create the app UI
#'
#' Internal
#'
#' @param iframe iframe tag designed by \link{preview_mobile}.
#' @param device See \link{preview_mobile} input.
#' @param color See \link{preview_mobile} input.
#' @param landscape See \link{preview_mobile} input.
create_app_ui <- function(iframe, device, color, landscape) {

  devices_css_deps <- htmltools::htmlDependency(
    name = "framework7",
    version = "5.5.0",
    src = c(file = system.file("framework7-5.5.0", package = "shinyMobile")),
    script = NULL,
    stylesheet = c("devices/devices.min.css")
  )

  shiny::fluidPage(
    htmltools::attachDependencies(
      devices_css_deps,
      shiny::br()
    ),
    # container for preview app
    shiny::br(),
    shiny::fluidRow(
      align = "center",
      create_app_container(
        iframe,
        skin = device,
        color = color,
        landscape = landscape
      )
    )
  )

}


create_app_container <- function(..., skin, color = NULL, landscape) {

  phoneCl <- "marvel-device"
  if (landscape) phoneCl <- paste0(phoneCl, " landscape")
  if (!is.null(color)) phoneCl <- paste(phoneCl, color)

  oldIphoneInner <- shiny::tagList(
    shiny::tags$div(class = "top-bar"),
    shiny::tags$div(class = "sleep"),
    shiny::tags$div(class = "volume"),
    shiny::tags$div(class = "camera"),
    shiny::tags$div(class = "sensor"),
    shiny::tags$div(class = "speaker"),
    shiny::tags$div(class = "screen", ...),
    shiny::tags$div(class = "home"),
    shiny::tags$div(class = "bottom-bar")
  )

  tag <- if (skin == "iphoneX") {
    shiny::tags$div(
      class = paste0(phoneCl, " iphone-x"),
      shiny::tags$div(class = "top-bar"),
      shiny::tags$div(class = "sleep"),
      shiny::tags$div(class = "bottom-bar"),
      shiny::tags$div(class = "volume"),
      shiny::tags$div(
        class = "overflow",
        shiny::tags$div(class = "shadow shadow--tr"),
        shiny::tags$div(class = "shadow shadow--tl"),
        shiny::tags$div(class = "shadow shadow--br"),
        shiny::tags$div(class = "shadow shadow--bl")
      ),
      shiny::tags$div(class = "inner-shadow"),
      shiny::tags$div(class = "screen", ...)
    )
  } else if (skin == "galaxyNote8") {
    shiny::tags$div(
      class = paste0(phoneCl, " note8"),
      shiny::tags$div(class = "inner"),
      shiny::tags$div(class = "overflow", shiny::tags$div(class = "shadow")),
      shiny::tags$div(class = "speaker"),
      shiny::tags$div(class = "sensors"),
      shiny::tags$div(class = "more-sensors"),
      shiny::tags$div(class = "sleep"),
      shiny::tags$div(class = "volume"),
      shiny::tags$div(class = "camera"),
      shiny::tags$div(class = "screen", ...)
    )
  } else if (skin == "ipadMini") {
    shiny::tags$div(
      class = paste0(phoneCl, " ipad"),
      shiny::tags$div(class = "camera"),
      shiny::tags$div(class = "screen", ...),
      shiny::tags$div(class = "home")
    )
  } else if (skin == "iphone8") {
    shiny::tags$div(
      class = paste0(phoneCl, " iphone8"),
      oldIphoneInner
    )
  } else if (skin == "iphone8+") {
    shiny::tags$div(
      class = paste0(phoneCl, " iphone8plus"),
      oldIphoneInner
    )
  } else if (skin == "iphone5s") {
    shiny::tags$div(
      class = paste0(phoneCl, " iphone5s"),
      oldIphoneInner
    )
  } else if (skin == "iphone5c") {
    shiny::tags$div(
      class = paste0(phoneCl, " iphone5c"),
      oldIphoneInner
    )
  } else if (skin == "iphone4s") {
    shiny::tags$div(
      class = paste0(phoneCl, " iphone4s"),
      oldIphoneInner
    )
  } else if (skin == "nexus5") {
    shiny::tags$div(
      class = paste0(phoneCl, " nexus5"),
      shiny::tags$div(class = "top-bar"),
      shiny::tags$div(class = "sleep"),
      shiny::tags$div(class = "volume"),
      shiny::tags$div(class = "camera"),
      shiny::tags$div(class = "screen", ...)
    )
  } else if (skin == "galaxyS5") {
    shiny::tags$div(
      class = paste0(phoneCl, " s5"),
      shiny::tags$div(class = "top-bar"),
      shiny::tags$div(class = "sleep"),
      shiny::tags$div(class = "camera"),
      shiny::tags$div(class = "sensor"),
      shiny::tags$div(class = "speaker"),
      shiny::tags$div(class = "screen", ...),
      shiny::tags$div(class = "home")
    )
  } else if (skin == "htcOne") {
    shiny::tags$div(
      class = paste0(phoneCl, " htc-one"),
      shiny::tags$div(class = "top-bar"),
      shiny::tags$div(class = "camera"),
      shiny::tags$div(class = "sensor"),
      shiny::tags$div(class = "speaker"),
      shiny::tags$div(class = "screen", ...)
    )
  }

  return(tag)
}
