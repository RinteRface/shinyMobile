#' Framework7 social card
#'
#' `r lifecycle::badge("deprecated")`.
#' \code{f7SocialCard} is a special card for social content.
#'
#' @param ... Card content.
#' @param image Author img.
#' @param author Author.
#' @param date Date.
#' @param footer Footer content, if any. Must be wrapped in a tagList.
#'
#' @keywords internal
#' @export
f7SocialCard <- function(..., image = NULL, author = NULL, date = NULL,
                         footer = NULL) {
  lifecycle::deprecate_warn("2.0.0", "f7SocialCard()", "f7Card()")

  headerTag <- shiny::tags$div(
    class = "card-header",
    shiny::tags$div(
      shiny::img(src = image, width = "34", height = "34")
    ),
    shiny::tags$div(author),
    shiny::tags$div(date)
  )
  contentTag <- shiny::tags$div(
    class = "card-content card-content-padding",
    ...
  )

  footerTag <- if (!is.null(footer)) shiny::tags$div(class = "card-footer", footer)

  shiny::tags$div(
    class = "card",
    headerTag,
    contentTag,
    footerTag
  )
}

#' Framework7 menu container
#'
#' `r lifecycle::badge("deprecated")`.
#' \code{f7Menu} is a container for \link{f7MenuItem} and/or \link{f7MenuDropdown}.
#'
#' @param ... Slot for \link{f7MenuItem} or \link{f7MenuDropdown}.
#' @export
#' @rdname menu
#' @keywords internal
f7Menu <- function(...) {
  lifecycle::deprecate_stop(
    when = "2.0.0",
    what = "f7Menu()",
    details = "f7Menu has been
      removed from Framework7 and there is no replacement in shinyMobile."
  )
  shiny::tags$div(
    class = "menu",
    shiny::tags$div(
      class = "menu-inner",
      ...
    )
  )
}

#' Framework7 menu item
#'
#' \code{f7MenuItem} creates a special action button for \link{f7Menu}.
#'
#' @rdname menu
#' @param inputId Menu item input id.
#' @param label Button label.
#' @export
f7MenuItem <- function(inputId, label) {
  lifecycle::deprecate_stop(
    when = "2.0.0",
    what = "f7MenuItem()",
    details = "f7MenuItem has been
      removed from Framework7 and there is no replacement in shinyMobile."
  )
  shiny::tags$a(
    class = "menu-item action-button",
    href = "#",
    id = inputId,
    shiny::tags$div(class = "menu-item-content", label)
  )
}

#' Framework7 dropdown menu
#'
#' \code{f7MenuDropdown} creates a dropdown menu for \link{f7Menu}.
#'
#' @param ... Slot for \link{f7MenuItem} and \link{f7MenuDropdownDivider}.
#' @param id Dropdown menu id. This is required when once wants to programmatically toggle
#' the dropdown on the server side with \link{updateF7MenuDropdown}.
#' @param label Button label.
#' @param side Dropdown opening side. Choose among \code{c("left", "center", "right")}.
#' @rdname menu
#' @export
f7MenuDropdown <- function(..., id = NULL, label, side = c("left", "center", "right")) {
  lifecycle::deprecate_stop(
    when = "2.0.0",
    what = "f7MenuDropdown()",
    details = "f7MenuDropdown has been
      removed from Framework7 and there is no replacement in shinyMobile."
  )
  side <- match.arg(side)

  # need to slightly transform f7MenuItem
  items <- lapply(list(...), function(x) {
    # do not target dividers
    if (x$attribs$class != "menu-dropdown-divider") {
      x$attribs$class <- "menu-dropdown-link menu-close action-button"
      x$children <- x$children[[1]]$children[[1]]
    }
    x
  })

  shiny::tags$div(
    class = "menu-item menu-item-dropdown",
    id = id,
    shiny::tags$div(class = "menu-item-content", label),
    shiny::tags$div(
      class = sprintf("menu-dropdown menu-dropdown-%s", side),
      shiny::tags$div(
        class = "menu-dropdown-content",
        style = "max-height: 200px",
        items
      )
    )
  )
}

#' Framework7 dropdown menu divider
#'
#' \code{f7MenuDropdownDivider} creates a dropdown divider for \link{f7MenuDropdown}.
#'
#' @rdname menu
#' @export
f7MenuDropdownDivider <- function() {
  lifecycle::deprecate_stop(
    when = "2.0.0",
    what = "f7MenuDropdownDivider()",
    details = "f7MenuDropdownDivider has been
      removed from Framework7 and there is no replacement in shinyMobile."
  )
  shiny::tags$div(class = "menu-dropdown-divider")
}

#' Update Framework7 menu
#'
#' \code{updateF7MenuDropdown} toggles \link{f7MenuDropdown} on the client.
#'
#' @param id Menu to target.
#' @param session Shiny session object.
#' @rdname menu
#' @export
updateF7MenuDropdown <- function(id, session = shiny::getDefaultReactiveDomain()) {
  lifecycle::deprecate_stop(
    when = "2.0.0",
    what = "updateF7MenuDropdown()",
    details = "updateF7MenuDropdown has been
      removed from Framework7 and there is no replacement in shinyMobile."
  )
  session$sendInputMessage(inputId = id, message = NULL)
}

#' Framework7 row container
#'
#' `r lifecycle::badge("deprecated")`
#' \link{f7Grid} is a replacement
#'
#' @param ... Row content.
#' @param gap Whether to display gap between columns. TRUE by default.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @keywords internal
#' @export
f7Row <- function(..., gap = TRUE) {
  lifecycle::deprecate_warn("2.0.0", "f7Row()", "f7Grid()")
  shiny::tags$div(class = if (gap) "row" else "row no-gap", ...)
}

#' Framework7 column container
#'
#' `r lifecycle::badge("deprecated")`
#' \link{f7Grid} is a replacement
#'
#' @param ... Column content. The width is automatically handled depending
#' on the number of columns.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @note The dark theme does not work for items embedded in a column. Use \link{f7Flex}
#' instead.
#'
#' @keywords internal
#' @export
f7Col <- function(...) {
  lifecycle::deprecate_warn("2.0.0", "f7Col()", "f7Grid()")
  shiny::tags$div(class = "col", ...)
}

#' Framework7 flex container
#'
#' `r lifecycle::badge("deprecated")`
#' \link{f7Grid} is a replacement
#'
#' @param ... Items.
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
#' @keywords internal
f7Flex <- function(...) {
  lifecycle::deprecate_warn("2.0.0", "f7Flex()", "f7Grid()")
  shiny::tags$div(
    class = "display-flex justify-content-space-between align-items-flex-start",
    ...
  )
}

#' Create a manifest for your shiny app
#'
#' `r lifecycle::badge("deprecated")`.
#' \code{create_manifest} creates a manifest for your shiny App. Please use this workflow instead:
#' \url{https://unleash-shiny.rinterface.com/mobile-pwa.html#charpente-and-pwa-tools}.
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
#' @keywords internal
#' @export
create_manifest <- function(path, name = "My App", shortName = "My App",
                            description = "What it does!", lang = "en-US",
                            startUrl, display = c("minimal-ui", "standalone", "fullscreen", "browser"),
                            background_color = "#000000", theme_color = "#0000ffff",
                            icon) {
  .Deprecated(
    NULL,
    package = "shinyMobile",
    "create_manifest will be removed in future release. Please use
    the workflow described at https://unleash-shiny.rinterface.com/mobile-pwa.html#charpente-and-pwa-tools instead.",
    old = as.character(sys.call(sys.parent()))[1L]
  )

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

#' Framework7 shadow effect
#'
#' `r lifecycle::badge("deprecated")`.
#' Creates a shadow effect to apply on UI elements like \link{f7Card}.
#'
#' @param tag Tag to apply the shadow on.
#' @param intensity Shadow intensity. Numeric between 1 and 24. 24 is the highest elevation.
#' @param hover Whether to display the shadow on hover. FALSE by default.
#' @param pressed Whether to display the shadow on click. FALSE by default.
#'
#' @keywords internal
#' @export
f7Shadow <- function(tag, intensity, hover = FALSE, pressed = FALSE) {
  lifecycle::deprecate_warn(
    when = "2.0.0",
    what = "f7Shadow()"
  )
  tag
}
