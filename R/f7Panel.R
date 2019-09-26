#' Create a Framework7 panel
#'
#' Build a Framework7 panel
#'
#' @param ... Panel content. Slot for \link{f7PanelMenu}, if used as a sidebar.
#' @param title Panel title.
#' @param side Panel side: "left" or "right".
#' @param theme Panel background color: "dark" or "light".
#' @param style Whether the panel should behave when opened: "cover" or "reveal".
#' @param resizable Whether to enable panel resize. FALSE by default.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7Panel <- function(..., title = NULL, side = c("left", "right"), theme = c("dark", "light"),
                    style = c("reveal", "cover"), resizable = FALSE) {

  side <- match.arg(side)
  style <- match.arg(style)
  theme <- match.arg(theme)
  panelCl <- sprintf("panel panel-%s panel-%s theme-%s", side, style, theme)
  if (resizable) panelCl <- paste0(panelCl, " panel-resizable")

  items <- list(...)
  items <- lapply(seq_along(items), function(i) {
    if (length(items[[i]]) > 1) {
      item <- items[[i]][[1]]
      if (class(item) == "shiny.tag") items[[i]] else f7Block(items[[i]])
    } else {
      if (class(items[[i]]) == "shiny.tag") items[[i]] else f7Block(items[[i]])
    }

  })

  panelTag <- shiny::tags$div(
    class = panelCl,
    shiny::tags$div(
      class = "view",
      shiny::tags$div(
        class = "page",
        # Panel Header
        shiny::tags$div(
          class = "navbar",
          shiny::tags$div(
            class = "navbar-inner",
            shiny::tags$div(class = "title", title)
          )
        ),
        # Panel content
        shiny::tags$div(
          class = "page-content",
          items
        )
      )
    )
  )

  f7Shadow(panelTag, intensity = 24)

}



#' Create a Framework7 sidebar menu
#'
#' Build a Framework7 sidebar menu
#'
#' @param ... Slot for \link{f7PanelItem}.
#' @param id Unique id to access the currently selected item.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7PanelMenu <- function(..., id = NULL) {

  if (is.null(id)) id <- paste0("panelMenu_", round(stats::runif(1, min = 0, max = 1e9)))

  panelMenuJS <- shiny::singleton(
    shiny::tags$script(
      paste0(
        "
        // This function is necessary to activate the good tab at start.
        // If one tab is active, it has a data-active attribute set to true.
        // We then trigger the show function on that tab.
        // If no tab is active at start, the first tab is shown by default.
        $(function() {
          var firstPanel = $('#", id," li:eq(0)');
          var panelActiveId = $('#", id," a.tab-link-active').attr('href');
          if (panelActiveId != undefined) {
            app.tab.show(panelActiveId);
          } else {
            app.tab.show('#' + firstPanelId);
          }
        });

        // Below is necessary to set the input value for shiny
        $(document).on('shiny:sessioninitialized', function() {
          // trigger a click on the window at start
          // to be sure that the input value is setup
          setTimeout(function() {
            $(window).trigger('click');
          }, 10);

          // Below is to handle the case where tabs are swipeable
          // Swiping left or right does not trigger any click by default.
          // Therefore, we need to trigger a click to update the shiny input.
          app.on('tabShow', function() {
           $(window).trigger('click');
          });

          // update the input value
          $(window).on('click', function(e) {
           var selectedPanelVal = $('#", id," a.tab-link-active').attr('href');
           var selectedPanelVal = selectedPanelVal.split('#')[1];
           Shiny.setInputValue('", id, "', selectedPanelVal);
          });
        });
        "
      )
    )
  )

  shiny::tagList(
    panelMenuJS,
    shiny::tags$div(
      class = "list links-list",
      shiny::tags$ul(..., id = id)
    )
  )
}




#' Create a Framework7 sidebar menu item
#'
#' Build a Framework7 sidebar menu item for \link{f7SplitLayout}.
#'
#' @param title Item name.
#' @param tabName Item unique tabName. Must correspond to what is passed to
#' \link{f7Item}.
#' @param icon Item icon.
#' @param active Whether the item is active at start. Default to FALSE.
#'
#' @author David Granjon, \email{dgranjon@@ymail.com}
#'
#' @export
f7PanelItem <- function(title, tabName, icon = NULL, active = FALSE) {
  shiny::tags$li(
    # generate the link
    if (!is.null(icon)) {
      shiny::a(
        href = paste0("#", tabName),
        class = if (active) "tab-link tab-link-active" else "tab-link",
        icon,
        shiny::span(class = "tabbar-label", title)
      )
    } else {
      shiny::a(
        href = paste0("#", tabName),
        class = if (active) "tab-link tab-link-active" else "tab-link",
        title
      )
    }
  )
}
