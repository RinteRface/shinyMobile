#' Framework7 panel
#'
#' \code{f7Panel} is a sidebar element. It may be used as a simple
#' sidebar or as a container for \link{f7PanelMenu} in case of
#' \link{f7SplitLayout}.
#'
#' @param ... Panel content. Slot for \link{f7PanelMenu}, if used as a sidebar.
#' @param id Panel unique id. This is to access the input$id giving the panel
#' state, namely open or closed.
#' @param title Panel title.
#' @param side Panel side: "left" or "right".
#' @param theme `r lifecycle::badge("deprecated")`:
#' removed from Framework7.
#' @param effect Whether the panel should behave
#' when opened: "cover", "reveal", "floating" or "push".
#' @param resizable Whether to enable panel resize. FALSE by default.
#' @param options Other panel options.
#' See \url{https://framework7.io/docs/panel#panel-parameters}.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#' @rdname panel
#'
#' @export
#' @example inst/examples/panel/app.R
f7Panel <- function(..., id = NULL, title = NULL,
                    side = c("left", "right"), theme = deprecated(),
                    effect = c("reveal", "cover", "push", "floating"),
                    resizable = FALSE,
                    options = list()) {
  if (lifecycle::is_present(theme)) {
    lifecycle::deprecate_warn(
      when = "1.1.0",
      what = "f7Panel(theme)",
      details = "theme has been
      removed from Framework7 and will be removed from shinyMobile
      in the next release."
    )
  }
  side <- match.arg(side)
  effect <- match.arg(effect)
  panelCl <- sprintf("panel panel-%s panel-%s", side, effect)
  if (resizable) panelCl <- paste0(panelCl, " panel-resizable")

  if (is.null(id)) {
    id <- sprintf(
      "panel_%s",
      round(stats::runif(1, min = 0, max = 1e9))
    )
  }

  options[["effect"]] <- effect

  shiny::tags$div(
    class = panelCl,
    id = id,
    shiny::tags$script(
      type = "application/json",
      `data-for` = id,
      jsonlite::toJSON(
        x = options,
        auto_unbox = TRUE,
        json_verbatim = TRUE
      )
    ),
    shiny::tags$div(
      class = "page",
      # Panel Header
      shiny::tags$div(
        class = "navbar",
        shiny::tags$div(class = "navbar-bg"),
        shiny::tags$div(
          class = "navbar-inner sliding",
          shiny::tags$div(class = "title", title)
        )
      ),
      # Panel content
      shiny::tags$div(
        class = "panel-content page-content",
        ...
      )
    )
  )
}

#' Framework7 sidebar menu
#'
#' \code{f7PanelMenu} creates a menu for \link{f7Panel}. It may contain
#' multiple \link{f7PanelItem}.
#'
#' @param ... Slot for \link{f7PanelItem}.
#' @param id Unique id to access the currently selected item.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @rdname panelmenu
#'
#' @export
f7PanelMenu <- function(..., id = NULL) {
  if (is.null(id)) {
    id <- paste0("panelMenu_", round(stats::runif(1, min = 0, max = 1e9)))
  }

  shiny::tags$div(
    class = "list links-list list-dividers",
    shiny::tags$ul(
      class = "panel-menu ",
      ...,
      id = id
    )
  )
}

#' Framework7 sidebar menu item
#'
#' \code{f7PanelItem} creates a Framework7 sidebar menu item for \link{f7SplitLayout}.
#'
#' @param title Item name.
#' @param tabName Item unique tabName. Must correspond to what is passed to
#' \link{f7Item}.
#' @param icon Item icon.
#' @param active Whether the item is active at start. Default to FALSE.
#'
#' @rdname panelmenu
#'
#' @export
f7PanelItem <- function(title, tabName, icon = NULL, active = FALSE) {
  shiny::tags$li(
    # generate the link
    if (!is.null(icon)) {
      shiny::a(
        `data-tab` = paste0("#", tabName),
        class = if (active) "tab-link tab-link-active" else "tab-link",
        icon,
        shiny::span(class = "tabbar-label", title)
      )
    } else {
      shiny::a(
        `data-tab` = paste0("#", tabName),
        class = if (active) "tab-link tab-link-active" else "tab-link",
        title
      )
    }
  )
}

#' Update Framework7 panel
#'
#' \code{updateF7Panel} toggles an \link{f7Panel} from the server.
#'
#' @param id Panel unique id.
#' @param session Shiny session object.
#' @rdname panel
#'
#' @export
updateF7Panel <- function(id, session = shiny::getDefaultReactiveDomain()) {
  session$sendInputMessage(id, NULL)
}
